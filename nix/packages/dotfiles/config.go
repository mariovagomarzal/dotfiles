package main

import (
	"errors"
	"fmt"
	"io/fs"
	"os"
	"path/filepath"
	"strings"

	"github.com/BurntSushi/toml"
)

// Config is read from the configuration file, then overridden by environment variables and finally by flags.
type Config struct {
	Path     string            `toml:"path"`
	Agent    string            `toml:"agent"`
	Commands map[string]string `toml:"commands"`
}

// configFile follows the XDG base directory specification.
func configFile() string {
	dir := os.Getenv("XDG_CONFIG_HOME")
	if dir == "" {
		home, _ := os.UserHomeDir()
		dir = filepath.Join(home, ".config")
	}
	return filepath.Join(dir, "dotfiles", "config.toml")
}

func loadConfig() (Config, error) {
	cfg := Config{
		Agent:    "claude",
		Commands: map[string]string{"claude": "claude", "codex": "codex"},
	}

	var file Config
	if _, err := toml.DecodeFile(configFile(), &file); err != nil && !errors.Is(err, fs.ErrNotExist) {
		return cfg, fmt.Errorf("reading %s: %w", tildify(configFile()), err)
	}
	if file.Path != "" {
		cfg.Path = file.Path
	}
	if file.Agent != "" {
		cfg.Agent = file.Agent
	}
	for name, command := range file.Commands {
		cfg.Commands[name] = command
	}

	if v := os.Getenv("DOTFILES_PATH"); v != "" {
		cfg.Path = v
	}
	if v := os.Getenv("DOTFILES_AGENT"); v != "" {
		cfg.Agent = v
	}
	for _, name := range []string{"claude", "codex"} {
		if v := os.Getenv("DOTFILES_" + strings.ToUpper(name)); v != "" {
			cfg.Commands[name] = v
		}
	}

	cfg.Path = expandHome(cfg.Path)
	return cfg, nil
}

// repo returns the repository's path, or explains how to set it.
func (c Config) repo() (string, error) {
	if c.Path == "" {
		return "", fmt.Errorf("no repository path: set `path` in %s or DOTFILES_PATH", tildify(configFile()))
	}
	if info, err := os.Stat(c.Path); err != nil || !info.IsDir() {
		return "", fmt.Errorf("the repository path %s is not a directory", tildify(c.Path))
	}
	return c.Path, nil
}

func expandHome(path string) string {
	if path == "~" || strings.HasPrefix(path, "~/") {
		home, _ := os.UserHomeDir()
		return filepath.Join(home, strings.TrimPrefix(path, "~"))
	}
	return path
}

func tildify(path string) string {
	home, _ := os.UserHomeDir()
	if home != "" && (path == home || strings.HasPrefix(path, home+string(filepath.Separator))) {
		return "~" + strings.TrimPrefix(path, home)
	}
	return path
}
