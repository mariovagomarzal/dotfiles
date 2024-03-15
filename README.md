# [Mario][mario]'s dotfiles

My personal dotfiles for setting up a new (macOS) machine.

## Table of contents

- [📖 About this repository](#about-this-repository)
- [🚀 Setup](#setup)
- [📦 Packages and configurations](#packages-and-configurations)
- [👨‍💻 Development](#development)
- [📝 License](#license)

## About this repository

This repository contains my _personal_ dotfiles for setting up a new
(macOS) machine. This includes many system settings and the installation
and configuration of most of the tools and applications I use on a daily
basis.

> [!NOTE]
> As mentioned, these dotfiles are tailored to my personal needs and
> preferences. Therefore, in most cases, they will not be suitable for
> anyone else. However, feel free to use them as a starting point for your
> own dotfiles. This guide is intended to be a reference for myself, but
> also for anyone else who might find it useful to build their own
> dotfiles.

I use the [dotbot][dotbot] tool (with some plugins) to manage the setup
process. The structure of this repository can be separated into the
following sections:

- The `install.conf.yaml` file, which contains the directives for the
  dotbot tool, and the `install` script that runs it. The dotbot tool and
  its plugins are included as submodules. For more information on what
  these directives do and how to setup the machine, see the [Setup](#setup)
  section.
- The package-specific directories, which contain the configuration files
  and scripts that may be necessary to install and configure the
  respective packages. A detailed description of each package and
  configuration can be found in the [Packages and
  configurations](#packages-and-configurations) section.
- Development related files, such as the `requirements-dev.txt`,
  `tasks.py`, `.pre-commit-config.yaml`... For more information on how to
  work with this repository, see the [Development](#development) section.

## Setup

> [!CAUTION]
> The following instructions will install and configure many tools and
> applications on your machine. Make sure to read and understand what the
> setup process does before running it.

The setup process can be divided in two main parts: the prerequisites and
the installation.

### Prerequisites

First, we are going to need some tools such as Git or Python to be
able to clone and run the repository. To do this, we will install the
Xcode Command Line Tools. For that, open a terminal and run the following
command:

```sh
xcode-select --install
```

This will open a dialog asking you to install the tools. Follow the
instructions and wait for the installation to finish.

Once Git is installed, we can clone the repository (and its submodules)
to the `~/Projects` directory (or any other directory of your choice) by
running the following command:

```sh
git clone --recurse-submodules https://github.com/mariovagomarzal/dotfiles.git ~/Projects/dotfiles
```

I use [SSH keys][ssh-keys] to authenticate with GitHub and other services.
For that reason, we will need to safely restore the SSH keys from a backup
or [generate new ones][generate-ssh-keys] and store them in the `~/.ssh`
directory.

Whith this, we are ready to install the dotfiles.

### Installation

To install the dotfiles, we will first need to navigate to the
`dotfiles` directory. In our case, this would be the `~/Projects/dotfiles`
directory, so we can run the following command:

```sh
cd ~/Projects/dotfiles
```

Once we are in the `dotfiles` directory, we can simply run the `install`
script to start the installation process:

```sh
./install
```

The script will start running the dotbot tool, which will install and
configure all the packages and settings specified in the
`install.conf.yaml` file. So, in order to understand what the setup process
does, it is recommended to read the `install.conf.yaml` file and, possibly,
the [dotbot documentation][dotbot] along with the documentation of the
[dotbot-brew][dotbot-brew] plugin.

Besides this, the dotbot tool will also print the steps it is taking and
notify the user of any errors that may occur. Keep in my mind that sudo
permissions may be required for some steps, so you may be asked to enter
your password at some point.

**Note:** This dotfiles are designed to be idempotent, meaning that
consecutive runs of the `install` script should not change anything if the
system is already configured as specified in the `install.conf.yaml` file.
Because of this, if some steps fail, it is possible to simply run the
`install` script again with no side effects.

## Packages and configurations

In this section, we will describe the packages and configurations that are
installed and/or configured by the dotfiles. Each main package has its own
subsection, which contains a short description of the package, the
installation and/or setup method and a list of related files, if any.

We will also include a miscellaneous subsection for any other packages
like fonts, media applications, etc.

### SSH keys

As mentioned, I use SSH keys to authenticate with GitHub and other
services. The SSH keys should be stored in the `~/.ssh` directory, in
particular, the `id_ed25519` and `id_ed25519.pub` files.

**Installation and/or setup method:** Keys must be restored or generated
manually. Setup is done by running the corresponding setup script.

**Related files:** Files related to the SSH keys are stored in the `ssh`
directory of this repository. These files are:

- `config`: The SSH configuration file that specifies the keys to use for
  each host.
- `setup_ssh.sh`: A script that adds the SSH keys to the SSH agent.

### Homebrew

Homebrew is the package manager I use to install most of the command-line
tools and applications.

**Installation and/or setup method:** The installation and setup of
Homebrew is done by the `dotbot-brew` plugin.

**Related files:** There are no related files for Homebrew.

### Fish

Fish is the shell I use as my default shell.

**Installation and/or setup method:** Fish is installed via Homebrew.

**Related files:** The configuration files for Fish are stored in the
`fish` directory of this repository. These files are:

  - `config.fish`: The main configuration file for Fish.
  - `functions`: A directory containing the custom functions for Fish.
  - `conf.d`: A directory containing extra configuration files for Fish.

### Starship

Starship is the prompt I use for Fish.

**Installation and/or setup method:** Starship is installed via Homebrew.

**Related files:** The configuration file for Starship is stored in the
`starship` directory of this repository. This file is:

- `starship.toml`: The main configuration file for Starship.

### Git

Git is the version control system I use for most of my projects.

**Installation and/or setup method:** Git is installed via Homebrew.

**Related files:** The configuration files for Git are stored in the `git`
directory of this repository. These files are:

- `.gitconfig`: The main configuration file for Git.
- `.gitignore_global`: The global gitignore file for Git.
- `.gitconfig.local`: The local configuration file for Git.

### Alacritty

Alacritty is the terminal emulator I use.

**Installation and/or setup method:** Alacritty is installed via Homebrew
as a cask.

**Related files:** The configuration files for Alacritty are stored in the
`alacritty` directory of this repository. These files are:

- `alacritty.toml`: The main configuration file for Alacritty.
- `themes`: A git submodule containing the themes for Alacritty.

### Visual Studio Code

I use Visual Studio Code as my main code editor. For the moment,
configurations and extensions are automatically synced between machines.

**Installation and/or setup method:** Visual Studio Code is installed via
Homebrew as a cask.

**Related files:** There are no related files for Visual Studio Code.

### Karabiner-Elements

Karabiner-Elements is the keyboard customizer I use.

**Installation and/or setup method:** Karabiner-Elements is installed via
Homebrew as a cask.

**Related files:** The configuration files for Karabiner-Elements are
stored in the `karabiner` directory of this repository. These files are:

- `karabiner.json`: The main configuration file for Karabiner-Elements.

### Python (via pyenv)

I use Python as the main programming language of some projects and for
installing some tools. For that reason, I use pyenv to manage the Python
versions.

**Installation and/or setup method:** Python is installed via pyenv, which
is installed via Homebrew. Setup is done by running the corresponding setup
script.

**Related files:** Files related to pyenv are stored in the `pyenv`
directory of this repository. These files are:

- `setup_pyenv.sh`: A script that installs Python 3.12.0 and sets it as the
  global version. It also installs the packages listed in the
  `requirements-sys.txt` file.
- `requirements-sys.txt`: A file containing the system-wide Python
  packages to be installed.

### Julia (via juliaup)

I use Julia as the main programming language of some projects. For that
reason, I use juliaup to manage the Julia versions.

**Installation and/or setup method:** Julia is installed via juliaup, which
is installed via Homebrew. Setup is done by running the corresponding setup
script.

**Related files:** Files related to juliaup are stored in the `juliaup`
directory of this repository. These files are:

- `setup_juliaup.sh`: A script that installs Julia 1.10.0 and sets it as
  the global version.

### LaTeX (via MacTeX)

I use LaTeX to write many documents and reports. For that reason, I use
MacTeX (with no GUI) to install the LaTeX distribution.

**Installation and/or setup method:** MacTeX is installed via Homebrew as a
cask, `mactex-no-gui`.

**Related files:** There are no related files for MacTeX.

### Typst

I use Typst to write many documents and reports.

**Installation and/or setup method:** Typst is installed via Homebrew.

**Related files:** There are no related files for Typst.

### Miscellaneous

#### GPG

GPG is the tool I use for signing commits, tags and other files.

**Installation and/or setup method:** GPG is installed via Homebrew.

#### Delta

Delta is the pager I use for Git diffs.

**Installation and/or setup method:** Delta is installed via Homebrew.

#### FiraCode Nerd Font

FiraCode Nerd Font is the main font I use in my terminal and code editor.

**Installation and/or setup method:** FiraCode Nerd Font is installed via
Homebrew as a cask, `font-fira-code-nerd-font`.

#### Google Drive

Google Drive is the cloud storage service I use to backup and sync some
files.

**Installation and/or setup method:** Google Drive is installed via
Homebrew as a cask.

#### Calibre

Calibre is the e-book manager I use. For the moment, I recover my Calibre
libraries from a backup into the `~/Calibre` directory. Then, I manually
add them to the Calibre application.

**Installation and/or setup method:** Calibre is installed via Homebrew as
a cask.

#### IINA

IINA is the media player for macOS I use.

**Installation and/or setup method:** IINA is installed via Homebrew as a
cask.

#### Maccy

Maccy is the clipboard manager I use.

**Installation and/or setup method:** Maccy is installed via Homebrew as
a cask.


## Development

In this section, we will describe how to setup the development environment,
the workflows and the conventions used in this repository.

### Development environment

I use some Python tools to manage the development environment, such as
[Invoke][invoke] or [pre-commit][pre-commit]. For that reason, we will
create a virtual environment and install the development dependencies
specified in the `requirements-dev.txt` file by running the following
commands:

```sh
python -m venv .venv
source .venv/bin/activate.fish # or .venv/bin/activate if using other shell
pip install -r requirements-dev.txt
```

Tasks related to the development environment are defined in the `tasks.py`
file. To see a list of available tasks, run the following command:

```sh
inv --list
```

To start the development environment, run the following command:

```sh
inv setup
```

This task will download the necessary submodules and install the the
pre-commit hooks. The submodules used in this repository are listed in the
`.gitmodules` file. On the other hand, the pre-commit configuration is
defined in the `.pre-commit-config.yaml` file.

### Workflows

The git workflow used in this repository is based on the [Feature branch
workflow][feauture-branch-workflow]. The main steps are:

1. Create a new branch from `main` to work on an specific change.
2. Make the changes and commit them to the branch.
3. Push the branch to the remote repository.
4. Merge the branch into `main` once the changes are ready.
5. Tag the commit with the version number. See the
   [Versioning](#versioning) section for more details.

### Versioning

The versioning of this repository is based on the [CalVer][calver]
convention. The version number is defined as `YYYY.MM.DD`.

## License

This repository is licensed under the [MIT License](/LICENSE) by [Mario Vago Marzal][mario].


<!-- External links -->
[mario]: https://github.com/mariovagomarzal
[dotbot]: https://github.com/anishathalye/dotbot
[ssh-keys]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/about-ssh
[generate-ssh-key]:
  https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
[dotbot-brew]: https://github.com/mariovagomarzal/dotbot-brew
[invoke]: https://www.pyinvoke.org/
[pre-commit]: https://pre-commit.com/
[feauture-branch-workflow]:
  https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[calver]: https://calver.org/
