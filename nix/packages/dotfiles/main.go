// Command dotfiles works with the dotfiles repository from anywhere: it opens it in a coding agent, the shell, the file
// manager or an editor, and applies a machine's configuration from it.
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
