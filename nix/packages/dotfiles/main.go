// Command dotfiles opens the dotfiles repository from anywhere: in a coding agent, the shell, the file manager or an
// editor.
package main

import (
	"context"
	"os"

	"github.com/charmbracelet/fang"
)

// Set at build time.
var version = "dev"

func main() {
	if err := fang.Execute(context.Background(), newRootCmd(), fang.WithVersion(version)); err != nil {
		os.Exit(1)
	}
}
