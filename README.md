# [Mario][mario]'s dotfiles

## Development

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
