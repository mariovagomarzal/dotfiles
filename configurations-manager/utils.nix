#####################################
# Utility functions of the library. #
#####################################
{
  lib,
  rootDir,
  ...
}: let
  /*
  Receives a directory path and a file (or directory) name as a string and
  returns the final path object.
  */
  toPath = path: fileName: path + ("/" + fileName);

  /*
  Checks if a directory contains a 'default.nix' file.
  */
  containsDefaultNix = path: let
    files = builtins.readDir path;
  in
    (files ? "default.nix") && (files."default.nix" == "regular");

  /*
  Checks if a path is a Nix module, i.e., a '.nix' file or a directory
  containing a 'default.nix' file.
  */
  isNixModule = path:
    if lib.pathIsDirectory path
    then containsDefaultNix path
    else lib.hasSuffix ".nix" path;

  /*
  Returns a list of Nix modules in a directory. The `dirName` argument is the
  directory name relative to 'rootDir' and the `excludedModules` argument is a
  list of file (or directory) names to be excluded from the result.
  */
  getDirModules = dirName: excludedModules: let
    dir = toPath rootDir dirName;
    files = builtins.readDir dir;
    filteredFiles =
      lib.filterAttrs (
        fileName: fileType:
          (isNixModule (toPath dir fileName))
          && ! (lib.elem fileName excludedModules)
      )
      files;
  in
    lib.mapAttrsToList (fileName: _: toPath dir fileName) filteredFiles;
in {
  /*
  Returns a list of Nix modules in a directory. It receives the following
  arguments:
  - `dirName`: The directory name (as a string) relative to 'rootDir'.
  - `excludedModules`: A list of file (or directory) names to be excluded from
    the result.
  - `extraModules`: A list of additional modules to be included in the result.
    Note that these modules are assumed to be final paths or module objects
    and are not parsed in any way.
  */
  getModules = dirName: excludedModules: extraModules: let
    dirModules = getDirModules dirName excludedModules;
  in
    dirModules ++ extraModules;
}
