from invoke import task


@task
def setup(c):
    """Setup the project for development."""
    # Download the git submodules
    c.run("git submodule update --init --recursive")

    # Install the `pre-commit` hooks
    c.run("pre-commit install")
