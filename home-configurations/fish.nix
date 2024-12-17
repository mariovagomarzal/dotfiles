#############################
# Fish shell configuration. #
#############################
{...}: {
  programs.fish = {
    enable = true;

    # Shell script code to run in interactive shells.
    interactiveShellInit = ''
      # Set the fish theme.
      fish_config theme choose "ayu Mirage"
    '';

    # Fish functions.
    functions = {
      fish_greeting = ''
        echo "Welcome, $(set_color green; echo -n $USER; set_color normal)! This is fish shell."
        echo ""
      '';

      _is_python_project = {
        description = "Check if the current directory is a Python project";
        body = ''
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
        '';
      };

      _python_info = {
        description = "Show Python version and, if available, virtualenv";
        body = ''
          # The message should look like this:
          #   x.y.z (venv)
          # The virtualenv part is only shown if the VIRTUAL_ENV variable is set.
          # Then, only the name of the virtualenv is shown, not the full path.
          echo -n (python -c "import sys; print(sys.version.split()[0])")
          if test -n "$VIRTUAL_ENV"
              echo -n " ("(basename "$VIRTUAL_ENV")")"
          end
        '';
      };
    };
  };
}
