#!/usr/bin/env bash

# Install the 3.12.0 version of Python and set it as the global version
pyenv install --skip-existing 3.12.0
pyenv global 3.12.0

# Install packages in `requirements-sys.txt` with this version of Python
pyenv exec pip install -r pyenv/requirements-sys.txt
