function is_python_project -d "Check if the current directory is a Python project"
    # We consider a directory a Python project if one or the following
    # conditions are met:
    #   1. The current directory contains any of the following files:
    #      `.python-version`, `Pipfile`, `__init__.py` or `pyproject.toml`.
    #   2. The current directory contains any file with the `.py` extension
    #      except for `tasks.py`.
    # Return 0 if the current directory is a Python project, 1 otherwise.

    if [ -f .python-version ] || [ -f Pipfile ] || [ -f __init__.py ] || [ -f pyproject.toml ]
        return 0
    else if [ (find . -maxdepth 1 -name '*.py' -not -name 'tasks.py' | count) -gt 0 ]
        return 0
    else
        return 1
    end
end
