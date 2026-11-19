/**
Installs the standalone Tailscale app as a Homebrew cask, which also provides the `tailscale` command.

The standalone app is the variant Tailscale recommends on macOS: it runs as a system extension, so the tailnet is shared
by every user of the machine, and it updates itself outside the App Store.
*/
_: {
  homebrew.casks = ["tailscale-app"];
}
