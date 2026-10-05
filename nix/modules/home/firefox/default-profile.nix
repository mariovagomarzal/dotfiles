{pkgs, ...}: {
  programs.firefox.profiles.default = {
    # Id 0 makes this the default profile.
    id = 0;
    name = "Default";

    bookmarks = {
      force = true;
      settings = [
        {
          name = "Toolbar Bookmarks";
          toolbar = true;
          bookmarks = [
            {
              name = "YouTube";
              url = "https://www.youtube.com";
            }
            {
              name = "Reddit";
              url = "https://www.reddit.com";
            }
            {
              name = "GitHub";
              url = "https://github.com";
            }
            {
              name = "Communication";
              bookmarks = [
                {
                  name = "WhatsApp Web";
                  url = "https://web.whatsapp.com";
                }
                {
                  name = "Discord";
                  url = "https://discord.com";
                }
              ];
            }
            {
              name = "Video Streaming";
              bookmarks = [
                {
                  name = "Netflix";
                  url = "https://www.netflix.com";
                }
                {
                  name = "Prime Video";
                  url = "https://www.primevideo.com";
                }
                {
                  name = "Disney+";
                  url = "https://www.disneyplus.com";
                }
                {
                  name = "Max";
                  url = "https://play.max.com";
                }
              ];
            }
            {
              name = "Nix Sites";
              bookmarks = [
                {
                  name = "NixOS Wiki";
                  url = "https://wiki.nixos.org";
                }
                {
                  name = "Nixpkgs Reference Manual";
                  url = "https://nixos.org/manual/nixpkgs/stable";
                }
                {
                  name = "Nix-Darwin Configuration Options";
                  url = "https://daiderd.com/nix-darwin/manual/index.html";
                }
                {
                  name = "Home-Manager Configuration Options";
                  url = "https://nix-community.github.io/home-manager/options.xhtml";
                }
              ];
            }
            {
              name = "University";
              bookmarks = [
                {
                  name = "Portal UV";
                  url = "https://portal.uv.es";
                }
                {
                  name = "Aula Virtual UV";
                  url = "https://aulavirtual.uv.es";
                }
              ];
            }
          ];
        }
      ];
    };

    search = {
      force = true;

      default = "google";
      privateDefault = "google";

      engines = let
        dayInMs = 24 * 60 * 60 * 1000;
      in {
        "google".metaData.alias = "@g";
        "wikipedia".metaData.alias = "@wk";
        "duckduckgo".metaData.hidden = true;
        "bing".metaData.hidden = true;
        "ecosia".metaData.hidden = true;
        "qwant".metaData.hidden = true;
        "youtube" = {
          urls = [
            {
              template = "https://www.youtube.com/results";
              params = [
                {
                  name = "search_query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@yt"];
          icon = "https://www.youtube.com/favicon.ico";
          updateInterval = dayInMs;
        };
        "reddit" = {
          urls = [
            {
              template = "https://www.reddit.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@rd"];
          icon = "https://www.redditstatic.com/shreddit/assets/favicon/192x192.png";
          updateInterval = dayInMs;
        };
        "GitHub" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
                {
                  name = "type";
                  value = "repositories";
                }
              ];
            }
          ];
          definedAliases = ["@gh"];
          icon = "https://github.githubassets.com/favicons/favicon.png";
          updateInterval = dayInMs;
        };
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@np"];
          icon = "https://search.nixos.org/favicon.png";
          updateInterval = dayInMs;
        };
        "NixOS Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "channel";
                  value = "unstable";
                }
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@no"];
          icon = "https://search.nixos.org/favicon.png";
          updateInterval = dayInMs;
        };
        "Home-Manager Options" = {
          urls = [
            {
              template = "https://home-manager-options.extranix.com";
              params = [
                {
                  name = "release";
                  value = "master";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = ["@hm"];
          icon = "https://home-manager-options.extranix.com/images/favicon.png";
          updateInterval = dayInMs;
        };
      };

      order = [
        "google"
        "wikipedia"
        "youtube"
        "reddit"
        "GitHub"
        "Nix Packages"
        "NixOS Options"
        "Home Manager Options"
      ];
    };

    extensions = {
      force = true;
      packages = with pkgs.nur.repos.rycee.firefox-addons; [
        stylus
        firefox-color
      ];
    };

    containersForce = true;
    containers = {};

    settings = {
      "extensions.autoDisableScopes" = 0;

      "browser.translations.enable" = false;

      "browser.startup.page" = 3; # Open the last session.
      "browser.shell.checkDefaultBrowser" = false;

      "browser.startup.homepage" = "about:home";
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.toolbars.bookmarks.visibility" = "always";

      "services.sync.engine.passwords" = true;
      "services.sync.engine.tabs" = true;
      "services.sync.engine.history" = true;

      "browser.warnOnQuit" = false;
      "browser.warnOnQuitShortcut" = false;
    };
    extraConfig = "";

    userChrome = "";
    userContent = "";
  };
}
