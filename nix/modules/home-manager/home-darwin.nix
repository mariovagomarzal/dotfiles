/**
Copies the apps installed by home-manager into ~/Applications instead of
linking them, so Spotlight finds them: it does not index symbolic links.
*/
_: {
  targets.darwin = {
    copyApps.enable = true;
    linkApps.enable = false;
  };
}
