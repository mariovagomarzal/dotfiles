package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strings"
	"syscall"

	"github.com/spf13/cobra"
)

// A manager is the tool that applies a machine's configuration.
type manager struct {
	name    string
	command string
	// root is whether applying changes the system, and so runs as root.
	root bool
	// target names what the optional argument chooses, and the file under each host that defines one.
	target, file string
}

var (
	darwinManager = manager{name: "nix-darwin", command: "darwin-rebuild", root: true, target: "host", file: "darwin-configuration.nix"}
	nixosManager  = manager{name: "NixOS", command: "nixos-rebuild", root: true, target: "host", file: "configuration.nix"}
	homeManager   = manager{name: "home-manager", command: "home-manager", target: "user@host"}
)

func newApplyCmd(use string, m manager) *cobra.Command {
	var noSudo bool
	cmd := &cobra.Command{
		Use:   use + " [" + m.target + "]",
		Short: "Apply this machine's configuration with " + m.name,
		Long: "Apply a configuration from the repository with " + m.name + ", wherever the command is run.\n" +
			"With no argument, " + m.command + " chooses the configuration named after this machine.",
		Args: cobra.MaximumNArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			return apply(m, args, !noSudo)
		},
		ValidArgsFunction: func(_ *cobra.Command, args []string, _ string) ([]string, cobra.ShellCompDirective) {
			if len(args) > 0 {
				return nil, cobra.ShellCompDirectiveNoFileComp
			}
			return targets(m), cobra.ShellCompDirectiveNoFileComp
		},
	}
	if m.root {
		cmd.Flags().BoolVar(&noSudo, "no-sudo", false, "run without sudo, such as when already root")
	}
	return cmd
}

// The switch command applies the machine with whichever tool manages it, so the same command works on every machine.
func newSwitchCmd() *cobra.Command {
	var noSudo bool
	cmd := &cobra.Command{
		Use:   "switch [target]",
		Short: "Apply this machine's configuration",
		Long: "Apply a configuration from the repository with the tool that manages this machine: nix-darwin on macOS,\n" +
			"NixOS on NixOS, and home-manager anywhere else. The target is a host, or user@host for home-manager.",
		Args: cobra.MaximumNArgs(1),
		RunE: func(_ *cobra.Command, args []string) error {
			return apply(current(), args, !noSudo)
		},
		ValidArgsFunction: func(_ *cobra.Command, args []string, _ string) ([]string, cobra.ShellCompDirective) {
			if len(args) > 0 {
				return nil, cobra.ShellCompDirectiveNoFileComp
			}
			return targets(current()), cobra.ShellCompDirectiveNoFileComp
		},
	}
	cmd.Flags().BoolVar(&noSudo, "no-sudo", false, "run without sudo, such as when already root")
	return cmd
}

// current finds the tool that manages this machine.
func current() manager {
	if _, err := os.Stat("/etc/NIXOS"); err == nil {
		return nixosManager
	}
	if _, err := exec.LookPath(darwinManager.command); err == nil && runtime.GOOS == "darwin" {
		return darwinManager
	}
	return homeManager
}

// apply replaces this process with the manager, from the repository, so sudo and the build talk to the terminal.
func apply(m manager, args []string, sudo bool) error {
	repo, err := repoPath()
	if err != nil {
		return err
	}
	bin, err := exec.LookPath(m.command)
	if err != nil {
		return fmt.Errorf("cannot find %s: is this machine managed by %s?", m.command, m.name)
	}

	flake := repo
	if len(args) > 0 {
		flake += "#" + args[0]
	}
	argv := []string{bin, "switch", "--flake", flake}
	if m.root && sudo {
		sudoBin, err := exec.LookPath("sudo")
		if err != nil {
			return errors.New("cannot find sudo: use --no-sudo when already root")
		}
		argv = append([]string{sudoBin}, argv...)
	}

	warnUntracked(repo)
	announce("Applying with "+m.name+" from", tildify(repo))
	if err := os.Chdir(repo); err != nil {
		return err
	}
	return syscall.Exec(argv[0], argv, os.Environ())
}

// warnUntracked lists the files git does not track, since a flake in a git repository cannot see them.
func warnUntracked(repo string) {
	out, err := exec.Command("git", "-C", repo, "ls-files", "--others", "--exclude-standard").Output()
	if err != nil {
		return
	}
	files := strings.Fields(string(out))
	if len(files) == 0 {
		return
	}
	announce("Not seen by Nix until added to git:", strings.Join(files, " "))
}

// targets lists the configurations a manager can apply, from the hosts directory, for completion.
func targets(m manager) []string {
	repo, err := repoPath()
	if err != nil {
		return nil
	}
	hosts, _ := filepath.Glob(filepath.Join(repo, "nix", "hosts", "*"))
	var out []string
	for _, host := range hosts {
		name := filepath.Base(host)
		if m.target == "host" {
			if _, err := os.Stat(filepath.Join(host, m.file)); err == nil {
				out = append(out, name)
			}
			continue
		}
		// A user is either `users/<user>.nix` or a `users/<user>/` directory.
		users, _ := filepath.Glob(filepath.Join(host, "users", "*"))
		for _, user := range users {
			out = append(out, strings.TrimSuffix(filepath.Base(user), ".nix")+"@"+name)
		}
	}
	return out
}
