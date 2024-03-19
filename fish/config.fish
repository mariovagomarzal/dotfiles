if status is-interactive
    # Commands to be run in interactive mode

    # Set the fish theme
    fish_config theme choose "ayu Mirage"

    # Set the fish prompt with Starship
    starship init fish | source
end

# Load variables
source ~/.config/fish/conf.d/variables.fish

# Initialize Pyenv
pyenv init - | source
