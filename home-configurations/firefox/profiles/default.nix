###########################################
# Default profile definition for Firefox. #
###########################################
{
  pkgs,
  userInfo,
  ...
}: {
  # Profile id and name. Id set to 0 to set it as the default profile.
  id = 0;
  name = userInfo.userName;

  # Bookmarks.
  bookmarks = [
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

  # Search settings.
  search = {
    force = true;

    # Default search engine.
    default = "Google";
    privateDefault = "Google";

    # Other search engines.
    engines = let
      dayInMs = 24 * 60 * 60 * 1000;
    in {
      # Default search engines.
      "Google".metaData.alias = "@g";
      "Wikipedia (en)".metaData.alias = "@wk";
      "DuckDuckGo".metaData.hidden = true;
      "Bing".metaData.hidden = true;
      "Ecosia".metaData.hidden = true;
      "Qwant".metaData.hidden = true;
      "YouTube" = {
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
        iconUpdateURL = "https://www.youtube.com/favicon.ico";
        updateInterval = dayInMs;
      };
      "Reddit" = {
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
        iconUpdateURL = "https://www.redditstatic.com/shreddit/assets/favicon/192x192.png";
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
        iconUpdateURL = "https://github.githubassets.com/favicons/favicon.png";
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
        iconUpdateURL = "https://search.nixos.org/favicon.png";
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
        iconUpdateURL = "https://search.nixos.org/favicon.png";
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
        iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
        updateInterval = dayInMs;
      };
    };

    # Order of search engines.
    order = [
      "Google"
      "Wikipedia (en)"
      "YouTube"
      "Reddit"
      "GitHub"
      "Nix Packages"
      "NixOS Options"
      "Home Manager Options"
    ];
  };

  # Extensions.
  extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    stylus
    firefox-color
  ];

  # Containers.
  containersForce = true;
  containers = {};

  # Profile settings.
  settings = {
    # Automatically enable extensions.
    "extensions.autoDisableScopes" = 0;

    # Disable translation features.
    "browser.translations.enable" = false;

    # Startup settings.
    "browser.startup.page" = 3; # Open the last session.
    "browser.shell.checkDefaultBrowser" = false;

    # Home page and bookmarks settings.
    "browser.startup.homepage" = "about:home";
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.toolbars.bookmarks.visibility" = "always";

    # Sync settings.
    "services.sync.engine.passwords" = true;
    "services.sync.engine.tabs" = true;
    "services.sync.engine.history" = true;

    # Don't warn on quitting the browser.
    "browser.warnOnQuit" = false;
    "browser.warnOnQuitShortcut" = false;
  };
  extraConfig = "";

  # User Chrome and content CSS.
  userChrome = "";
  userContent = "";
}
