# [Mario][mario]'s dotfiles

## Development

In this section, we will describe how to setup the development environment, the
workflows and the conventions used in this repository.

### Environment

To work with this repository, as we are using Nix with flakes, a development
shell with the necessary tools and configurations has been defined in the
`development.nix` file as a submodule of the main flake.

Assuming that you have Nix installed, you can enter the development shell by
running the following command:

```sh
nix --extra-experimental-features 'nix-command flakes' develop
```

The `--extra-experimental-features 'nix-command flakes'` flag is only needed if
this features are no enabled by default in your Nix installation.

If the command succeeds, you will see a welcome message with a list of the
available tools and commands. There is an special category of commands,
`internal`, that should not be used directly. You can type `menu` to see the
list of available commands again in any moment. Finally, you can exit the shell
by typing `exit`.

Here is a list of the available commands:

- `menu`: Show the list of available commands.
- `just`: Just is a command runner that can be used to run the recipes defined
  in the `Justfile`. You can type `just` to see the list of available recipes.
  However, it is recommended to take a look at the `Justfile` to see which
  recipes are related to the development of this repository. In any case, here
  is a list of those recipes:
  - `just setup-env`: Setup the development environment by installing the
    pre-commit hooks. Should be run after entering the development shell for
    the first time.
  - `just check`: Run the flake checks.
  - `just format`: Format the Nix files.

### Workflow

The git workflow used in this repository is based on the [Feature branch
workflow][feauture-branch-workflow]. The main steps are:

1. Create a new branch from `main` to work on an specific change.
2. Make the changes and commit them to the branch.
3. Push the branch to the remote repository.
4. Merge the branch into `main` once the changes are ready.
5. Tag the commit with the version number. See the [Versioning](#versioning)
   section for more details.

### Versioning

The versioning of this repository is based on the [CalVer][calver] convention.
The version number is defined as `YYYY.0M.0D`.

### Changelog

We use a [changelog file](/CHANGELOG.md) to keep track of the changes made to
the repository. The changelog follows the [Keep a Changelog][keep-a-changelog]
format.

## License

This repository is licensed under the [MIT License](/LICENSE) by [Mario Vago
Marzal][mario].

<!-- External links -->
[mario]: https://github.com/mariovagomarzal
[feauture-branch-workflow]:
  https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow
[calver]: https://calver.org/
[keep-a-changelog]: https://keepachangelog.com/
