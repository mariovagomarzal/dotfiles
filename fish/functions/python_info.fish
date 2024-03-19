#!/usr/bin/env fish

function python_info -d "Show Python version and, if available, virtualenv"
    # The message should look like this:
    #   x.y.z (venv)
    # The virtualenv part is only shown if the VIRTUAL_ENV variable is set.
    # Then, only the name of the virtualenv is shown, not the full path.
    echo -n (python -c "import sys; print(sys.version.split()[0])")
    if test -n "$VIRTUAL_ENV"
        echo -n " ("(basename "$VIRTUAL_ENV")")"
    end
end
