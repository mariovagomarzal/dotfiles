package main

import (
	"errors"
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"slices"
	"strings"
	"syscall"

	"charm.land/lipgloss/v2"
	"github.com/spf13/cobra"
)

var (
	accent = lipgloss.NewStyle().Foreground(lipgloss.Color("#cba6f7")).Bold(true)
	muted  = lipgloss.NewStyle().Foreground(lipgloss.Color("#a6adc8"))
)

// announce tells, on stderr, what is about to happen, so standard output stays clean for scripts.
func announce(action, target string) {
	lipgloss.Fprintln(os.Stderr, accent.Render("→ ")+action+" "+muted.Render(target))
}

func newRootCmd() *cobra.Command {
	var agent string

	root := &cobra.Command{
		Use:   "dotfiles",
		Short: "Open the dotfiles repository from anywhere",
		Long:  "Open the dotfiles repository from anywhere: talk to a coding agent in it, go to it, or open it.\nWith no command, it starts a conversation with the default agent.",
		Args:  cobra.NoArgs,
		RunE: func(cmd *cobra.Command, _ []string) error {
			return chat(agent, nil)
		},
	}
	root.Flags().StringVarP(&agent, "agent", "a", "", "agent to talk to (default from the configuration)")

	root.AddCommand(newChatCmd(), newCdCmd(), newOpenCmd(), newEditCmd(), newPathCmd(), newShellCmd())
	return root
}

func newChatCmd() *cobra.Command {
	var agent string
	cmd := &cobra.Command{
		Use:   "chat [message]",
		Short: "Talk to a coding agent in the repository",
		Long:  "Start an interactive session with a coding agent in the repository, optionally with a first message.",
		Example: `  dotfiles chat
  dotfiles chat "add ripgrep to my packages"
  dotfiles chat -a codex "update the dependencies"`,
		RunE: func(cmd *cobra.Command, args []string) error {
			return chat(agent, args)
		},
	}
	cmd.Flags().StringVarP(&agent, "agent", "a", "", "agent to talk to (default from the configuration)")
	cmd.RegisterFlagCompletionFunc("agent", func(*cobra.Command, []string, string) ([]string, cobra.ShellCompDirective) {
		cfg, _ := loadConfig()
		names := make([]string, 0, len(cfg.Commands))
		for name := range cfg.Commands {
			names = append(names, name)
		}
		slices.Sort(names)
		return names, cobra.ShellCompDirectiveNoFileComp
	})
	return cmd
}

// chat replaces this process with the agent, so the session belongs to the terminal as if the agent had been started
// by hand.
func chat(agent string, message []string) error {
	cfg, err := loadConfig()
	if err != nil {
		return err
	}
	repo, err := cfg.repo()
	if err != nil {
		return err
	}
	if agent == "" {
		agent = cfg.Agent
	}
	command, ok := cfg.Commands[agent]
	if !ok {
		command = agent
	}
	bin, err := exec.LookPath(command)
	if err != nil {
		return fmt.Errorf("cannot find %q for the %s agent", command, agent)
	}

	args := []string{command}
	if len(message) > 0 {
		args = append(args, strings.Join(message, " "))
	}
	announce("Talking to "+agent+" in", tildify(repo))
	if err := os.Chdir(repo); err != nil {
		return err
	}
	return syscall.Exec(bin, args, os.Environ())
}

// A program cannot change its parent shell's directory; the function printed by `dotfiles shell` handles `cd`.
func newCdCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "cd",
		Short: "Go to the repository",
		Args:  cobra.NoArgs,
		RunE: func(*cobra.Command, []string) error {
			return errors.New("going to the repository needs the shell integration: add `dotfiles shell <shell> | source` to your shell's configuration")
		},
	}
}

func newOpenCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "open",
		Short: "Open the repository in the file manager",
		Args:  cobra.NoArgs,
		RunE: func(*cobra.Command, []string) error {
			repo, err := repoPath()
			if err != nil {
				return err
			}
			opener := "xdg-open"
			if runtime.GOOS == "darwin" {
				opener = "open"
			}
			announce("Opening", tildify(repo))
			return exec.Command(opener, repo).Run()
		},
	}
}

func newEditCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "edit",
		Short: "Open the repository in your editor",
		Long:  "Open the repository in the editor set in $VISUAL, or else in $EDITOR.",
		Args:  cobra.NoArgs,
		RunE: func(*cobra.Command, []string) error {
			repo, err := repoPath()
			if err != nil {
				return err
			}
			editor := os.Getenv("VISUAL")
			if editor == "" {
				editor = os.Getenv("EDITOR")
			}
			// The variable may carry arguments, such as `code --wait`.
			fields := strings.Fields(editor)
			if len(fields) == 0 {
				return errors.New("no editor: set $VISUAL or $EDITOR")
			}
			bin, err := exec.LookPath(fields[0])
			if err != nil {
				return fmt.Errorf("cannot find the editor %q", fields[0])
			}
			announce("Editing", tildify(repo))
			if err := os.Chdir(repo); err != nil {
				return err
			}
			return syscall.Exec(bin, append(fields, repo), os.Environ())
		},
	}
}

func newPathCmd() *cobra.Command {
	return &cobra.Command{
		Use:   "path",
		Short: "Print the repository's path",
		Args:  cobra.NoArgs,
		RunE: func(*cobra.Command, []string) error {
			repo, err := repoPath()
			if err != nil {
				return err
			}
			fmt.Println(repo)
			return nil
		},
	}
}

func repoPath() (string, error) {
	cfg, err := loadConfig()
	if err != nil {
		return "", err
	}
	return cfg.repo()
}
