#/usr/bin/env bash

# Add Fish to the list of shells
echo "$(which fish)" | sudo tee -a /etc/shells

# Change the default shell to Fish`
chsh -s "$(which fish)"
