# [Mario][mario]'s dotfiles

My personal dotfiles for setting up a new (macOS) machine.

## Table of contents

- [📖 About this repository](#about-this-repository)
- [🚀 Setup](#setup)
    - [How to setup a new machine](#how-to-setup-a-new-machine)
    - [What does the setup process do?](#what-does-the-setup-process-do)
- [📦 Packages and configurations](#packages-and-configurations)
    - [Homebrew](#homebrew)
    - [Fish](#fish)
    - [Starship](#starship)
    - [Git](#git)
      - [Delta](#delta)
    - [Pyenv](#pyenv)
    - [Juliaup](#juliaup)
    - [Miscellaneous](#miscellaneous)
      - [GPG](#gpg)
- [🏗️ Development](#development)
  - [Environment](#environment)
  - [Workflow and conventions](#workflow-and-conventions)
    - [Git workflow](#git-workflow)
    - [Versioning](#versioning)
- [📝 License](#license)

## About this repository

This repository contains my _personal_ dotfiles for setting up a new macOS
machine. It uses _[dotbot][dotbot]_ with some plugins to manage the
installation of packages and configurations.

The dotfiles related files are organized in the following way:

- `install.conf.yaml`: the configuration file for dotbot.
- `install`: the main script that runs dotbot.
- Package directories: each directory contains the files and/or scripts
  necessary to setup a specific package or configuration.

The details steps on how to setup a new machine as well as what this
process does are described in the _[Setup](#setup)_ section.

A list of the packages and configurations that are installed and/or
configured are listed in the _[Packages and
configurations](#packages-and-configurations)_ section. A brief
explaination of each package and configuration is also provided there. For
a more detailed explanation, you can refer to the specific package
directory.

> [!NOTE]
> This repository is intended for my personal use. However, you are free
> to use it as a reference or as a starting point for your own dotfiles.
> Refer to the _[Development](#development)_ section for more details on
> how to work with this repository.

## Setup

### How to setup a new machine

> [!CAUTION]
> The following steps will install and configure packages and
> configurations on your machine. Make sure you understand what this
> process does before running it.

We are going to describe the steps to setup a new macOS machine using this
repository. The steps are divided into two parts: _Prerequisites_ and
_Setup_.

__Prerequisites__: I use [SSH keys][ssh-keys] to authenticate with GitHub
and other services. So first, we are going to restore the SSH keys safely
from a backup to the `~/.ssh` directory. Alternatively, we can [generate a
new SSH][generate-ssh-key] key and add it to our GitHub account.

Now, we need to clone this repository. For that, we need to have `git`
installed. This can be done by running the following command in the
terminal:

```sh
xcode-select --install
```

This will install the Xcode Command Line Tools, which includes `git`. It
may be necessary to configure `git` with your name and email. This can be
done by running the following commands:

```sh
git config --global user.name "Your Name"
git config --global user.email "your.name@example.com"
```

Later on, we will be able to change the `git` configuration using the
`.gitconfig.local` file.

Once `git` is installed and configured, we can clone this repository by
running the following command:

```sh
git clone https://github.com/mariovagomarzal/dotfiles.git
```

We now have to navigate to the `dotfiles` directory we just cloned:

```sh
cd path/to/dotfiles
```

__Setup__: Once we have the repository cloned and we are in the
`dotfiles` directory, we can run the `install` script to setup the machine.
This can be done by running the following command:

```sh
./install
```

The details of what this process does are described in the _[What does the
setup process do?](#what-does-the-setup-process-do)_ section.

### What does the setup process do?

When running the `install` script, the _dotbot_ program is executed with
the `install.conf.yaml` configuration file. This file contains the
instructions for _dotbot_ to install and configure the packages. So, for a
more detailed explanation of what this process does, you can refer this
file (and, possibly, the _[dotbot documentation][dotbot]_).

In general, the process does the following:

1. Install the Homebrew package manager (if not installed).
2. With Homebrew, install all the specified packages and casks.
3. Symlink all the specified dotfiles to its corresponding location.
4. Run some commands to finish configuring the machine. In this step, sudo
   permissions may be required.

## Packages and configurations

### Homebrew

Homebrew is the package manager I use to install and manage the packages on
my machine. Homebrew is installed and used with the
_[dotbot-brew][dotbot-brew]_ plugin.

### Fish

I use the Fish shell as my main shell. The Fish shell is installed with
Homebrew. The configuration files are the following:

- `config.fish`: the main configuration file for the Fish shell.
- `functions`: the directory containing the Fish functions.
- `conf.d`: a directory containing extra configuration files that are
  sourced by the `config.fish` file. These files are the following:
    - `variables.fish`: contains the environment variables.

Since we want to use the Fish shell as the main shell, we run the following
command in the setup process:

```sh
chsh -s $(which fish)
```

### Starship

I use the Starship to customize the prompt of the Fish shell. Starship is
configured with the `starship.toml` file.

In this file, we have defined some different color palettes. You can choose
any of them by setting the `palette` variable in the `starship.toml` file.
Take a look at the file to see the available palettes.

> Since the default `python` module of Starship doesn't fit my needs, I use a
> custom one that depends on two fish functions defined in the `functions`
> directory of the Fish shell. The functions are `is_python_project` and
> `python_info`.

### Git

The Git configuration is defined in the `.gitconfig` file. The file
contains the main configuration for Git. We include the `.gitignore_global`
file in the configuration, which contains the global Git ignore rules.

User specific configuration can be defined in the `.gitconfig.local` file.

#### Delta

I use the Delta tool as the pager for Git. Delta configuration is defined
in the `.gitconfig` file too.

### Pyenv

I use Pyenv to manage Python versions. After installing Pyenv with
Homebrew, we execute the `setup_python.sh` script to install Python 3.12.0
and set it as the global version. Then, we install all the packages defined
in the `requirements-sys.txt` file via `pip`.

### Juliaup

I use Juliaup to manage Julia versions. After installing Juliaup with
Homebrew, we execute the `setup_julia.sh` script to install Julia 1.10.0
and set it as the global version.

### Miscellaneous

#### GPG

I use GPG to sign my commits and other key management tasks.

## Development

In this section, we will describe the development environment, workflow,
and conventions used in this repository.

I use this as a guide for myself. However, you are free to use it as a
reference or as a starting point for your own dotfiles.

### Environment

First, since I use some Python libraries to manage the development
environment, I recommend using a Python virtual environment to work with
this repository. This can be done by running the following commands:

```sh
python -m venv "venv"
source venv/bin/activate # Depending on your shell
```

Once the virtual environment is activated, we can install the development
dependencies by running the following command:

```sh
pip install -r requirements-dev.txt
```

This will install the development dependencies, wich are _[Invoke][invoke]_
and _[pre-commit][pre-commit]_.

We use _Invoke_ to manage the development tasks. The tasks are defined in
the `tasks.py` file. You can list the available tasks by running the
following command:

```sh
invoke --list
```

The _pre-commit_ library is used to manage the pre-commit hooks. The hooks
are defined in the `.pre-commit-config.yaml` file.

Before working on the repository for the first time, run the following
task:

```sh
invoke setup
```

This will install the pre-commit hooks and clone the submodules.

### Workflow and conventions

#### Git workflow

The git workflow used in this repository is based on the _[Feature branch
workflow][feauture-branch-workflow]_. The main steps are:

1. Create a new branch from `main` to work on an specific change.
2. Make the changes and commit them to the branch.
3. Push the branch to the remote repository.
4. Merge the branch into `main` once the changes are ready.
5. Tag the commit with the version number. See the
   _[Versioning](#versioning)_ section for more details.

#### Versioning

The versioning of this repository is based on the _[CalVer][calver]_
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
[dotbot-brew]: https://github.com/wren/dotbot-brew
[invoke]: https://www.pyinvoke.org/
[pre-commit]: https://pre-commit.com/
[feauture-branch-workflow]:
    https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[calver]: https://calver.org/
