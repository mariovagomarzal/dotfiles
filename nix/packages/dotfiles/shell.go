package main

import (
	"fmt"

	"github.com/spf13/cobra"
)

// The functions make `dotfiles cd` work and give the alias, if any, the same commands and completions.
const fishIntegration = `function dotfiles --wraps dotfiles --description 'Open the dotfiles repository'
    if test "$argv[1]" = cd
        set -l dir (command dotfiles path); or return
        cd $dir
    else
        command dotfiles $argv
    end
end
`

const posixIntegration = `dotfiles() {
    if [ "$1" = cd ]; then
        local dir
        dir=$(command dotfiles path) || return
        cd "$dir"
    else
        command dotfiles "$@"
    fi
}
`

func newShellCmd() *cobra.Command {
	var alias string
	cmd := &cobra.Command{
		Use:       "shell <fish|bash|zsh>",
		Short:     "Print the shell integration",
		Long:      "Print the functions that make `dotfiles cd` work, and optionally an alias, for the given shell.",
		Example:   "  dotfiles shell fish --alias dt | source",
		Args:      cobra.MatchAll(cobra.ExactArgs(1), cobra.OnlyValidArgs),
		ValidArgs: []string{"fish", "bash", "zsh"},
		RunE: func(cmd *cobra.Command, args []string) error {
			out := cmd.OutOrStdout()
			switch args[0] {
			case "fish":
				fmt.Fprint(out, fishIntegration)
				if alias != "" {
					fmt.Fprintf(out, "function %s --wraps dotfiles --description 'Open the dotfiles repository'\n    dotfiles $argv\nend\n", alias)
				}
			case "bash", "zsh":
				fmt.Fprint(out, posixIntegration)
				if alias != "" {
					fmt.Fprintf(out, "%s() { dotfiles \"$@\"; }\n", alias)
					if args[0] == "zsh" {
						fmt.Fprintf(out, "compdef %s=dotfiles 2>/dev/null\n", alias)
					}
				}
			}
			return nil
		},
	}
	cmd.Flags().StringVar(&alias, "alias", "", "also define this shorter name, such as dt")
	return cmd
}
