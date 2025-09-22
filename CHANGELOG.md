# Changelog

All notable changes to this project will be documented in this file.

Each stable version of the dotfiles repository is tagged with a date in the
format `YYYY.MM.DD(.P)`, where `P` is an optional patch version separated by a
dot if more than one version was released in the same day.

## [2025.09.22](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.09.22)

### ⛰️ Added

- *(config)* Disable Yabai and Yankyborders for macOS - ([6c72266](https://github.com/mariovagomarzal/dotfiles/commit/6c722665ab592e24b2622e765a86d78a5af643f5))
- *(darwin)* Change `Launchpad.app` to `Apps.app` - ([15e0650](https://github.com/mariovagomarzal/dotfiles/commit/15e0650d975ef1504e043730cf67ee5f8d76983a))
### 🔧 Chore

- Properly ignore the `result` Nix directory - ([d9e189a](https://github.com/mariovagomarzal/dotfiles/commit/d9e189a1974c2a9c9b83b5ca5ea4a98a83c3c711))

## [2025.09.17.3](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.09.17.3)

### 🐛 Fixed

- Prevent empty group sections in changelog - ([41ad41c](https://github.com/mariovagomarzal/dotfiles/commit/41ad41c4e2a1f6c5e096052a986794b98d57edf0))

## [2025.09.17.2](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.09.17.2)

### ⛰️ Added

- *(darwin)* Add Discord and Telegram casks - ([922d582](https://github.com/mariovagomarzal/dotfiles/commit/922d582f06d62464ffbece9f856d0cf60c0ad3bb))
### 🐛 Fixed

- Fix git-cliff recognition of update changelog commits - ([2722caf](https://github.com/mariovagomarzal/dotfiles/commit/2722caffc5af6f8d2c224eacbf6bc6c06eaf35d1))

## [2025.09.17.1](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.09.17.1)

### 🐛 Fixed

- Correct the commit message for updating the changelog - ([ef90d1c](https://github.com/mariovagomarzal/dotfiles/commit/ef90d1c4222a196eb197106efe1fffdad3e8fa29))

## [2025.09.17](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.09.17)

### ⛰️ Added

- *(config)* [**breaking**] Restructure repository following Snowfall Lib conventions - ([ee5c29f](https://github.com/mariovagomarzal/dotfiles/commit/ee5c29fe4c9c2bb4992291030b1e19a042676982))
- Add support for changelog generation with git-cliff - ([95573f8](https://github.com/mariovagomarzal/dotfiles/commit/95573f8e9ba5ccafb48f7b8cc7f3e5d812c2c506))
### 🔧 Chore

- Allow commit messages without a body - ([ec83664](https://github.com/mariovagomarzal/dotfiles/commit/ec8366480c61d43c3c6714c0ca07c0cd22780229))
- Add a tag creation recipe to the `Justfile` - ([4ca29ea](https://github.com/mariovagomarzal/dotfiles/commit/4ca29eab3ef11f626a483f0318c6bea21cf1668b))
- Ignore the changelog update commits for changelog generation - ([7021cd0](https://github.com/mariovagomarzal/dotfiles/commit/7021cd05d85cb030c35df224f86e031858e5bd82))

## [2025.08.14](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.08.14)

### 💼 Other

- Remove the Kitty cask for Marios-MacBook-Pro - ([9e57bf6](https://github.com/mariovagomarzal/dotfiles/commit/9e57bf68d8f8494d6372fb3772ed9a77cd150404))
- Fix the Fish path for Alacritty - ([4a8ed0c](https://github.com/mariovagomarzal/dotfiles/commit/4a8ed0c46adf29ce7864409d65e6e5a1df649a12))
- Add a home-manager module for JankyBorders for 'mariovagomarzal@Marios-MacBook-Pro' - ([7203392](https://github.com/mariovagomarzal/dotfiles/commit/72033929b61a5e73ae16222b52f2f3fb97b11e4c))
- Remove the Yabai and Skhd home-manager modules for 'mariovagomarzal@Marios-MacBook-Pro' - ([016eac0](https://github.com/mariovagomarzal/dotfiles/commit/016eac0067eae5494d087f86f5804d4ae56a8df4))
- Move user-specific Catppuccin configuration to a home-manager shared module - ([47308ac](https://github.com/mariovagomarzal/dotfiles/commit/47308acb55cc53243db881b0b0a6b2ef2a1f4b8f))
- Fix a missing input in the Catppuccin home-manager shared module - ([5a74687](https://github.com/mariovagomarzal/dotfiles/commit/5a74687ad9caf9118ed92ff355535dabd2ec7c42))
- Add the 'Even Better TOML' extension for Visual Studio Code - ([fe24c4a](https://github.com/mariovagomarzal/dotfiles/commit/fe24c4ab8025bd569b5a545d90b42b003b3c150a))
- Add the Lua package for shared home-manager - ([11db27d](https://github.com/mariovagomarzal/dotfiles/commit/11db27d6d5e116b53f0334bfd72493834442e475))
- Add a custom home-manager module for configuring Lua - ([daf3c49](https://github.com/mariovagomarzal/dotfiles/commit/daf3c49c4d213267dcc99df315fa0130e8935922))
- Add a custom overlay for the SbarLua Lua module - ([d59c3fc](https://github.com/mariovagomarzal/dotfiles/commit/d59c3fc3dc66da9cdcf2cf1553e11d0a4d52e2cf))
- Add some comments to the custom home-manager Lua module - ([51abec5](https://github.com/mariovagomarzal/dotfiles/commit/51abec5c5b81ab1b130cb2bc0b1cfc17d08744ae))
- Modify the header comments of 'Marios-MacBook-Pro' modules - ([5055860](https://github.com/mariovagomarzal/dotfiles/commit/505586094e6ae1aef2e6e00a595dd79f19d63329))
- Add some settings for Visual Studio Code - ([a5599fb](https://github.com/mariovagomarzal/dotfiles/commit/a5599fbbc5c14e65b1b0d02411c826cc60178199))
- Add custom nix-darwin and home-manager modules for configuring Yabai - ([3cf897d](https://github.com/mariovagomarzal/dotfiles/commit/3cf897dc649f07ca295678d76c93efab1b9db4a0))
- Add a home-manager module for Yabai for 'mariovagomarzal@Marios-MacBook-Pro' - ([a21c0db](https://github.com/mariovagomarzal/dotfiles/commit/a21c0db97d3505a2f051e1db4b9be4bb38a0d0fd))
- Fix a code style issue - ([425c353](https://github.com/mariovagomarzal/dotfiles/commit/425c353965de6ffe2b56c16667ba268b7f7d79b1))
- Add a custom home-manager module for Skhd - ([827c7d0](https://github.com/mariovagomarzal/dotfiles/commit/827c7d02d3d73a842731c5b64e2cfe822a49156d))
- Add custom paths for Yabai and Skhd processes standard outputs - ([53f6c8b](https://github.com/mariovagomarzal/dotfiles/commit/53f6c8b6e2601f4bf47cd62b5041d90cc386156e))
- Set a working directory for the Skhd launchd agent - ([19e7a8c](https://github.com/mariovagomarzal/dotfiles/commit/19e7a8ce020058c59e9bafeae596ec281b5b163f))
- Set Yabai and Skhd processes type to 'Interactive' - ([874a8c7](https://github.com/mariovagomarzal/dotfiles/commit/874a8c7bf4b56b8a1128ad63e7e20ef702f3b2be))
- Set the `SHELL` environment variable for the Skhd launchd agent - ([9e4879d](https://github.com/mariovagomarzal/dotfiles/commit/9e4879d7a093ba8c935dc52f1c26e8d8a403c31f))
- Remove the `SHELL` environment variable definition for the Skhd launchd agent - ([c5bb92b](https://github.com/mariovagomarzal/dotfiles/commit/c5bb92ba173f693cfe248f9ba4b4aca4b8546557))
- Add a home-manager module for Skhd for 'mariovagomarzal@Marios-MacBook-Pro' - ([d14e0e4](https://github.com/mariovagomarzal/dotfiles/commit/d14e0e49ba2a024330925c06a72fb6787b702099))
- Remove a TODO comment - ([1fee295](https://github.com/mariovagomarzal/dotfiles/commit/1fee295505cbd48fa3d01d1addba7f8a4458f8b7))
- Add a custom home-manager module for JankyBorders - ([bf1acec](https://github.com/mariovagomarzal/dotfiles/commit/bf1acec01196c48ba510ec8c5628f9ad3ba8494d))
- Use the custom home-manager module to configure JankyBorders - ([346e912](https://github.com/mariovagomarzal/dotfiles/commit/346e9126ac63c18199a1cf5a3bb0f92223c61f3a))
- Define the username variable for the launchd config attribute - ([3f42225](https://github.com/mariovagomarzal/dotfiles/commit/3f422250a000d372f2dac5f219aa396067a9feb4))
- Add a custom home-manager module for Sketchybar - ([aef9657](https://github.com/mariovagomarzal/dotfiles/commit/aef965729f262d404b32d6882cb5873f7b167bf7))
- Change the PATH order for the Yabai, Skhd, and Sketchybar launch agents - ([68b5ef7](https://github.com/mariovagomarzal/dotfiles/commit/68b5ef7931866500eca645e7de129bf9716335a3))
- Remove the Lua overlays - ([7a9101a](https://github.com/mariovagomarzal/dotfiles/commit/7a9101a91bb1eb2405fa98cb34acdf68df993a33))
- Refactor the custom home-manager Lua module - ([3fb6579](https://github.com/mariovagomarzal/dotfiles/commit/3fb6579fa98d36b692ecaddf206692e587114d06))
- Set the rendering order for window borders with JankyBorders - ([0c3ee82](https://github.com/mariovagomarzal/dotfiles/commit/0c3ee82781fc23e7cca73903302e06e07374d49b))
- Change the JankyBorders borders color - ([c92b60e](https://github.com/mariovagomarzal/dotfiles/commit/c92b60e5acf7c7b0ec5b34e967941636194fb009))
- Change the Lua package version to 5.4 - ([9cc46ae](https://github.com/mariovagomarzal/dotfiles/commit/9cc46ae3b94fecc8ba728dee671219632a5d7470))
- Add the Whisky cask for Marios-MacBook-Pro - ([56f7699](https://github.com/mariovagomarzal/dotfiles/commit/56f7699c1d1b56218990c77249ca00c2ab8ef634))
- Add configuration elements for Godot - ([337362e](https://github.com/mariovagomarzal/dotfiles/commit/337362ee282ce68b16b82e9a46f1a2ffc3d03084))
- Format the `jankyborders.nix` file - ([0d0e6b9](https://github.com/mariovagomarzal/dotfiles/commit/0d0e6b9dc093d2266ebfa30db5f9dca1bdf98967))
- Update flake dependencies - ([53d2fe4](https://github.com/mariovagomarzal/dotfiles/commit/53d2fe45ca65919b19e48c9ab9f191790ab92b6e))
- Update Darwin configurations code to meet latest specifications - ([db3ff5b](https://github.com/mariovagomarzal/dotfiles/commit/db3ff5bcd0faccbc28adc017f70e834fcacd8cbd))
- Add a `isPrimaryUser` attribute to user definitions - ([772da97](https://github.com/mariovagomarzal/dotfiles/commit/772da979920583c9dd77ccf9828289a78f2c835e))
- Remove the old VSCode Typst extension and add a new one - ([6f3f40a](https://github.com/mariovagomarzal/dotfiles/commit/6f3f40a1718ecd0c8269eb5d9cce1badffbaa131))
- Update the name of the Home-Manager Catppuccin module - ([608a42c](https://github.com/mariovagomarzal/dotfiles/commit/608a42c60fe52bd3f94300a5cf7c2825d9c6a340))
- Update Firefox bookmarks option to meet a new specification - ([a1a40dd](https://github.com/mariovagomarzal/dotfiles/commit/a1a40dd92aee9ec2cb27ede6685d3db813a0e2b7))
- Rename the custom Skhd module options - ([12c8920](https://github.com/mariovagomarzal/dotfiles/commit/12c8920552fb4774b6a5de50156489e2242485f7))
- Remove the custom Home-Manager Jankyborders module - ([24940aa](https://github.com/mariovagomarzal/dotfiles/commit/24940aae368b6cba63e1de062d6d9b4331424e38))
- Update Firefox search and extensions options to meet a new specification - ([7d16e52](https://github.com/mariovagomarzal/dotfiles/commit/7d16e5219a4193994c23dd5f12fac70c8b3ba41d))
- Update how shell-specific integrations are enabled in the LSD Home-Manager mdoule - ([49d4e80](https://github.com/mariovagomarzal/dotfiles/commit/49d4e80a3c13b12c0385bd9d7fc16743eb472863))
- Define most of the Home-Manager VSCode options under a `profile` namespace - ([cba2164](https://github.com/mariovagomarzal/dotfiles/commit/cba2164069c7dfb364b1fcb7271153fdf4fc8372))
- Use `sudo` when running `darwin-rebuild` commands - ([7991afa](https://github.com/mariovagomarzal/dotfiles/commit/7991afac1f29a751ee26e9778f1cc18a2d9b3196))
- Fix the Home-Manager Firefox configuration - ([5f3ec78](https://github.com/mariovagomarzal/dotfiles/commit/5f3ec78883ccf32f6e4a0e6f1c4973370a19c2b2))
- Add some AI tools and applications - ([0e2bcd3](https://github.com/mariovagomarzal/dotfiles/commit/0e2bcd3e83855c9b7d0f2088a16b8236fe845049))
- Remove Home-Manager VSCode theme-specific options - ([ebae69c](https://github.com/mariovagomarzal/dotfiles/commit/ebae69cb8865259cd170e01f7cce55b40815737f))
- Remove the custom Home-Manager Sketchybar module - ([ea1c183](https://github.com/mariovagomarzal/dotfiles/commit/ea1c1832dd58794538a968c4cb2e8c3f6b8086fb))
- Add Home-Manager Direnv configuration - ([fe442cf](https://github.com/mariovagomarzal/dotfiles/commit/fe442cf77f2f018ad3a3978450332f46f91febf9))
- Add core development tools to Home-Manager - ([3bc1935](https://github.com/mariovagomarzal/dotfiles/commit/3bc1935777a1d0c24b9a5bfd9de280b964b93813))
- Set Fish as default terminal in VSCode - ([69f16a0](https://github.com/mariovagomarzal/dotfiles/commit/69f16a013c7087e2ec92405de46a6a8e98c79e64))
- Update the Catppuccin flake input - ([023b34c](https://github.com/mariovagomarzal/dotfiles/commit/023b34c4357646bd3d2d7f59835bc1664cba94fb))
- Enable most recent use ordering for Spaces in Dock - ([ed3bbfe](https://github.com/mariovagomarzal/dotfiles/commit/ed3bbfe72ab1340b9c30f29ff45bbb85374c6cb9))
- Simplify skhd fullscreen window functionality - ([ab37bc7](https://github.com/mariovagomarzal/dotfiles/commit/ab37bc7dd80b6cbe2503562565a9564029fc9d2a))
- Add GitHub CLI to core packages - ([bd4e34c](https://github.com/mariovagomarzal/dotfiles/commit/bd4e34c9349acadb0de3203720e4bf0c9ad83425))
- Remove the file tree structure section from the README file - ([78f664b](https://github.com/mariovagomarzal/dotfiles/commit/78f664baf48c923bff80df83f3deab8474a71756))
- Update CHANGELOG.md with unreleased changes - ([008fcc9](https://github.com/mariovagomarzal/dotfiles/commit/008fcc9da016939918c6e66504adb9cd74987f39))
- Restructure the VSCode configuration files - ([87c6dea](https://github.com/mariovagomarzal/dotfiles/commit/87c6dea6f3373dcd8e66e43c87315ad359150680))
- Update the CHANGELOG version date - ([fb53372](https://github.com/mariovagomarzal/dotfiles/commit/fb533728e4f67e1a39c10bd77a518114eb776020))

## [2025.01.14](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.14)

### 💼 Other

- Include the hostname in the user directory names - ([dcad986](https://github.com/mariovagomarzal/dotfiles/commit/dcad98629313cd12e293a6b914fa9e2448d95557))
- Document the changes in the README and CHANGELOG files - ([e67dc16](https://github.com/mariovagomarzal/dotfiles/commit/e67dc162794a630729362652404d1b3a19c7d524))

## [2025.01.11.1](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.11.1)

### 💼 Other

- Fix the logo URL in the README - ([6c021a4](https://github.com/mariovagomarzal/dotfiles/commit/6c021a4304501c3b48a64dcedc70ddb8614c63a4))
- Add a missing closing quote in the logo URL in the README - ([b599321](https://github.com/mariovagomarzal/dotfiles/commit/b5993211b7b58b80c93603387d0dad0ffff85c39))
- Resize the logo in the README - ([dc824f0](https://github.com/mariovagomarzal/dotfiles/commit/dc824f087d60f6d5fda47b304655f2619929c6a5))
- Document the changes in the CHANGELOG file - ([e1cb21a](https://github.com/mariovagomarzal/dotfiles/commit/e1cb21a6cc64793019b669484b59db29fadcc31c))

## [2025.01.11](https://github.com/mariovagomarzal/dotfiles/releases/tag/2025.01.11)

### 💼 Other

- Generalize the behavior of the current Darwin shared modules - ([fb4fb60](https://github.com/mariovagomarzal/dotfiles/commit/fb4fb60c22fea9617bb9bc476f0bc5c6990cd3ed))
- Fix a typo - ([002bec8](https://github.com/mariovagomarzal/dotfiles/commit/002bec8a07aa8d1e05836d8114e3a7093fc2e40b))
- Remove the `users.knownUsers` option for Darwin configurations - ([74a8333](https://github.com/mariovagomarzal/dotfiles/commit/74a83338236bac530e247ecdeff8fba109a2a497))
- Add more system settings options for 'Marios-MacBook-Pro' Darwin configuration - ([78c44de](https://github.com/mariovagomarzal/dotfiles/commit/78c44de8874ad3fc8fb2a7be02f31e7415a72169))
- Edit some system settings of 'Marios-MacBook-Pro' - ([08674c4](https://github.com/mariovagomarzal/dotfiles/commit/08674c43ced1f575c8a30dd5bfb5cdc52c60ac04))
- Reorganize packages installation options - ([b53894e](https://github.com/mariovagomarzal/dotfiles/commit/b53894e493d142a3ab3c9cf8b0ce9fca4a7e93a5))
- Add the 'Catppuccin for Nix' Home-Manager module - ([89b9ff1](https://github.com/mariovagomarzal/dotfiles/commit/89b9ff1f5bd131ab09a89256e7fa5e0aed9856c2))
- Update flake inputs - ([4481adb](https://github.com/mariovagomarzal/dotfiles/commit/4481adb81cf1304e09a48e9ef35bec406ea12e2e))
- Add 'catppuccin' support for the current Home-Manager programs - ([6ad14b5](https://github.com/mariovagomarzal/dotfiles/commit/6ad14b5fa174eb574d592ae66c475f9afb8ef3a7))
- Split the `core.nix` file into two files - ([528004f](https://github.com/mariovagomarzal/dotfiles/commit/528004f32582eef3c9071798ec51ec30c84bdc46))
- Add a home-manager shared module for LSD - ([40b87e5](https://github.com/mariovagomarzal/dotfiles/commit/40b87e5b086794c40eff42293b8d7d14df2b8ab7))
- Add a home-manager shared module for Bat - ([71c438f](https://github.com/mariovagomarzal/dotfiles/commit/71c438ff44fe4891f740e8ce5566e9479c380f3c))
- Change some home-manager module headers - ([c9315e0](https://github.com/mariovagomarzal/dotfiles/commit/c9315e096c1e10eaa63567d39eb16a2545704467))
- Split the git home-manager configuration into two files - ([dc0aa6f](https://github.com/mariovagomarzal/dotfiles/commit/dc0aa6f965aee36279b7f65ddba669078ecc2d3a))
- Add a home-manager shared module for Visual Studio Code - ([76c5556](https://github.com/mariovagomarzal/dotfiles/commit/76c55564ad389eafa4a4921c94a71466ff24d1b2))
- Change the mouse tracking speed for 'Marios-MacBook-Pro' - ([d5129e8](https://github.com/mariovagomarzal/dotfiles/commit/d5129e8355f926333c6f723a919b79ce7720d7d2))
- Add the TexLive package to the shared home-manager packages - ([f9eaf3d](https://github.com/mariovagomarzal/dotfiles/commit/f9eaf3d17b3a069a500427dd0b2fde116b142f44))
- Add a home-manager shared module for Firefox - ([1fe3680](https://github.com/mariovagomarzal/dotfiles/commit/1fe36805543774948c843b84c8aaf882d547c1c0))
- Fix a Firefox bookmark URL - ([981434e](https://github.com/mariovagomarzal/dotfiles/commit/981434ebb924545296d2b27b8bb21c6e93c22a5b))
- Add some settings for Visual Studio Code - ([0b3a9ff](https://github.com/mariovagomarzal/dotfiles/commit/0b3a9ff53633dff693b86ba948565386300b43f1))
- Add some Git aliases - ([ea603e0](https://github.com/mariovagomarzal/dotfiles/commit/ea603e042caac07b13a7e0fd6fb3b4d29c580041))
- Disable some Markdownlint rules - ([942fdfd](https://github.com/mariovagomarzal/dotfiles/commit/942fdfd87d8aa873e87862e8df2f6113769afd52))
- Update the README style - ([cdc6590](https://github.com/mariovagomarzal/dotfiles/commit/cdc6590a50e0d7084971e779bee77db0c4a84321))
- Fix README GitHub style-related issues - ([5c2cf6f](https://github.com/mariovagomarzal/dotfiles/commit/5c2cf6f0d0fbbcd07bd55916ee40f5981a4199a3))
- Remove Nerd Font icons from the README - ([07a2edd](https://github.com/mariovagomarzal/dotfiles/commit/07a2edd40277fe2f012d6d8f8be287acb43d78d6))
- Document the changes in the CHANGELOG file - ([853c752](https://github.com/mariovagomarzal/dotfiles/commit/853c752081a62c7ae1d6973c903e1bcea58ede3f))

## [2024.12.28](https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.12.28)

### 💼 Other

- Remove some unnecessary comments from the development module - ([260c3af](https://github.com/mariovagomarzal/dotfiles/commit/260c3af86aaa7315ae157490d991f0c4ee1cea0e))
- Create a separate module for defining system configurations - ([5bad4f7](https://github.com/mariovagomarzal/dotfiles/commit/5bad4f7495ca9ad44e6929e0586c1b83998ea229))
- Reorganize the structure of the configurations related files - ([93bff50](https://github.com/mariovagomarzal/dotfiles/commit/93bff50a7cd38203d422e25dcb64a6b8e03e4f5e))
- Add an initial version of the 'configurations-manager' library - ([2d5a9a3](https://github.com/mariovagomarzal/dotfiles/commit/2d5a9a3bc20c4994db36cd9b1205ca8e671a8609))
- Restructure and document the 'configurations-manager' library - ([dd43ac2](https://github.com/mariovagomarzal/dotfiles/commit/dd43ac2995a9f7c01d1b1e3c7f29a930b3372b5e))
- Change the comments style in the 'configurations-manager' library - ([a2c67a1](https://github.com/mariovagomarzal/dotfiles/commit/a2c67a1e683645f4562753dc27d2e561c450168b))
- Implement the `mkHomeConfigurations` function - ([c392bbb](https://github.com/mariovagomarzal/dotfiles/commit/c392bbb90dc7a1f4f1a47c084a44c2fa1d14484d))
- Fix some typos (and small bugs) in the 'configurations-manager' library - ([3257417](https://github.com/mariovagomarzal/dotfiles/commit/32574174742403a1a1f90c004f61b6bd41a38745))
- Change some names in the 'configurations-manager' library - ([50e075b](https://github.com/mariovagomarzal/dotfiles/commit/50e075b4d78058c98ecb45eac0cbe3432c4b142b))
- Add a new `usersInfo` function for home-manager extra special arguments - ([87ceed3](https://github.com/mariovagomarzal/dotfiles/commit/87ceed316aec2eb9db243022da01885eea41bdc2))
- Document the main functions of the 'configurations-manager' library - ([8ce7a8b](https://github.com/mariovagomarzal/dotfiles/commit/8ce7a8b6b888ac69827c5bd45329b1b4f5967e0d))
- Use the 'configurations-manager' library to define the system configurations - ([7b3266b](https://github.com/mariovagomarzal/dotfiles/commit/7b3266b1809a5f09e5b40508736928fb28860c60))
- Remove the `_pre-commit-install` internal command - ([0a37afd](https://github.com/mariovagomarzal/dotfiles/commit/0a37afd80e1f8607f0488b73221e3dfe4b9f4d95))
- Document the changes in the README and CHANGELOG files - ([dd3b3c8](https://github.com/mariovagomarzal/dotfiles/commit/dd3b3c8e18a59c48bc2296135ab26413126d70ac))

## [2024.12.12](https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.12.12)

### 💼 Other

- Remove `dotbot` support and Python development dependencies - ([5bb034a](https://github.com/mariovagomarzal/dotfiles/commit/5bb034ae67698c45f19e01e9ca259bca887ea379))
- Add the development dependencies with Nix - ([96a980e](https://github.com/mariovagomarzal/dotfiles/commit/96a980e7ac9ee06bd53e40dc90e9450b8c907ef1))
- Define the new README structure and add some content - ([c1eeac4](https://github.com/mariovagomarzal/dotfiles/commit/c1eeac4f4e36711c81967ab944fb345def017e98))
- Add the basic structure to manage Darwin configurations - ([4b1732b](https://github.com/mariovagomarzal/dotfiles/commit/4b1732bf1bec621344921e0d6d061f21b10dcaaf))
- Add a header comment to the `marios-macbook-pro.nix` file - ([d75c016](https://github.com/mariovagomarzal/dotfiles/commit/d75c016da8f45bcbe258d924ccc54ce43a723c97))
- Remove the `sudo` command from the `darwin-rebuild` recipe - ([dd488e3](https://github.com/mariovagomarzal/dotfiles/commit/dd488e32eb1d22021b9c375887de4302662785e0))
- Fix format for GitHub admonitions - ([fe354e0](https://github.com/mariovagomarzal/dotfiles/commit/fe354e04b3a8411093f248a949947369985e622c))
- Add the `nix-core.nix` Darwin module - ([3068a5f](https://github.com/mariovagomarzal/dotfiles/commit/3068a5f7ec0333f9f629736904520a05717ba174))
- Add the `host-users.nix` Darwin module - ([29b5f50](https://github.com/mariovagomarzal/dotfiles/commit/29b5f507228298443bda9bb9de6f437ce2224a53))
- Fix the import path of the `host-users.nix` module - ([2e0b15d](https://github.com/mariovagomarzal/dotfiles/commit/2e0b15d49cf38cc118b607b75155783d791e92fb))
- Fix the `host-users.nix` module - ([88f97b7](https://github.com/mariovagomarzal/dotfiles/commit/88f97b78124dc057b43d2bec3ccd8ec049788ec4))
- Add the `packages.nix` Darwin module - ([63c31c6](https://github.com/mariovagomarzal/dotfiles/commit/63c31c667243cf0b8fd32c563dde08c5dadc762d))
- Remove the `karabiner-elements` cask - ([a72f0a8](https://github.com/mariovagomarzal/dotfiles/commit/a72f0a87688b59250ae8029dd1472d4c57d38e74))
- Add the `system.nix` Darwin module - ([deda91a](https://github.com/mariovagomarzal/dotfiles/commit/deda91a121f087553903c6b30f48676a7d1043f1))
- Update the information message of the `darwin-rebuild` recipe - ([dfdfee1](https://github.com/mariovagomarzal/dotfiles/commit/dfdfee1ea2d2413cdc4e529fc000ced7e61ea5de))
- Disable Homebrew autoupdate and autoupgrade explicitly - ([1535d20](https://github.com/mariovagomarzal/dotfiles/commit/1535d20635744227a93ed5c6561fbe3eb515cf8a))
- Add basic support for home-manager - ([12f97db](https://github.com/mariovagomarzal/dotfiles/commit/12f97db2257c89c39223ec9d3964ec804ef42e94))
- Add the `core.nix` homa-manager module - ([c97691e](https://github.com/mariovagomarzal/dotfiles/commit/c97691e1765f696ed92ecba71c556d7ff59d884d))
- Fix the `homebrew.onActivation.upgrade` attribute name - ([7905682](https://github.com/mariovagomarzal/dotfiles/commit/7905682f2100d78befdac724514909c4f91906b9))
- Add the `ssh.nix` home-manager module - ([fabe564](https://github.com/mariovagomarzal/dotfiles/commit/fabe564653b8d48fcb33472923a9045d66c5591b))
- Add comments to the `ssh.nix` home-manager module - ([69b3b23](https://github.com/mariovagomarzal/dotfiles/commit/69b3b238037eadf1801415b5076d9e7a5860afad))
- Add the `fish.nix` home-manager module - ([d3a353b](https://github.com/mariovagomarzal/dotfiles/commit/d3a353b628d3428a0b570fe5bc7f4ac4f642b04e))
- Remove some of the shell initialization commands - ([85d2ff3](https://github.com/mariovagomarzal/dotfiles/commit/85d2ff3c50d950b121d49beca2ddb2d61b526e8a))
- Add the `starship.nix` home-manager module - ([3b310c2](https://github.com/mariovagomarzal/dotfiles/commit/3b310c291d5e730e7b687fb848a974c4ac196886))
- Remove the `system` attribute from `specialArgs` - ([360a50e](https://github.com/mariovagomarzal/dotfiles/commit/360a50e2bd988686c11f5e4950e2ad3a038fcbbf))
- Add the `alacritty.nix` home-manager module - ([daae3a4](https://github.com/mariovagomarzal/dotfiles/commit/daae3a472d393b44b3b2ab5514e304cffde2b884))
- Remove the `delta` package - ([546b275](https://github.com/mariovagomarzal/dotfiles/commit/546b2752327f203b637e651dab65371b997a6ef7))
- Add the `git.nix` home-manager module - ([4573b49](https://github.com/mariovagomarzal/dotfiles/commit/4573b49ac65964bdc078fd0700edeca26a7c57c3))
- Add some packages to the `core.nix` home-manager module - ([241cf15](https://github.com/mariovagomarzal/dotfiles/commit/241cf1540d14e4b4fc8cb03ba0201d946fcbd9f4))
- Add and fix some system configuration options - ([22d9fde](https://github.com/mariovagomarzal/dotfiles/commit/22d9fde87c7453094742a4b147c4edcff4931bc9))
- Add some Python packages to the core module - ([0e299ca](https://github.com/mariovagomarzal/dotfiles/commit/0e299caf14408af553347c03bb065e3fbaa5c03a))
- Add the OpenEmu cask - ([98ba3c3](https://github.com/mariovagomarzal/dotfiles/commit/98ba3c35fbc60a668fc309880282c40b193cef5e))
- Add some system-wide packages and casks - ([3008dcb](https://github.com/mariovagomarzal/dotfiles/commit/3008dcb16cd8ab529609b35694d13342cfcb838b))
- Add some system-wide packages and casks - ([e0683f3](https://github.com/mariovagomarzal/dotfiles/commit/e0683f3ad1b025efe63412de0cbd08938966eb8e))
- Update flake dependencies and add support for macOS Sequoia - ([9635a7a](https://github.com/mariovagomarzal/dotfiles/commit/9635a7ad11a70cdd5d7a602374d5f9704ba0c433))
- Add some system-wide packages and casks - ([504d12b](https://github.com/mariovagomarzal/dotfiles/commit/504d12bbd8b4ad0d756da16e2267e7581593981d))
- Add the `yabai.nix` and `skhd.nix` home-manager modules - ([433b7a0](https://github.com/mariovagomarzal/dotfiles/commit/433b7a00e998cebb845e1fd401c81d8b25537530))
- Fix a typo - ([92cecf4](https://github.com/mariovagomarzal/dotfiles/commit/92cecf45e740da2dc984594e95c786c260c8e59c))
- Add a startup command to setup the environment when entering the 'devshell' - ([ec7fbb1](https://github.com/mariovagomarzal/dotfiles/commit/ec7fbb1e8e0f840480e8a2f36b1ea98fdecc7a15))
- Improve the `Justfile` organization - ([d982c1f](https://github.com/mariovagomarzal/dotfiles/commit/d982c1f1905c00bc4d829434555b9f2a1997a4a2))
- Change the CHANGELOG format - ([8608ca8](https://github.com/mariovagomarzal/dotfiles/commit/8608ca820be66f3c7afe928f36173aad81eea098))
- Add the missing parts of the README - ([ffdabff](https://github.com/mariovagomarzal/dotfiles/commit/ffdabff75c83e7a4dbf92a8d2aad72d96d148b2c))
- Update the release title in the CHANGELOG - ([b0efad8](https://github.com/mariovagomarzal/dotfiles/commit/b0efad864f8e36c5dd21bbdbf563eb788f4fd061))

## [2024.03.19](https://github.com/mariovagomarzal/dotfiles/releases/tag/2024.03.19)

### 💼 Other

- Initial commit - ([7d38cf2](https://github.com/mariovagomarzal/dotfiles/commit/7d38cf2df1ab946788b8adc0cfcb913aa70b0345))
- Add some base files and dependencies - ([b30c036](https://github.com/mariovagomarzal/dotfiles/commit/b30c03627f61853b9978947e57f436ed8fd1f1fe))
- Add Python dependencies for the development environment - ([3ed2cf8](https://github.com/mariovagomarzal/dotfiles/commit/3ed2cf82d575469b22e826621eaa5255ca9159b8))
- Add the `dotbot-brew` plugin - ([f55c362](https://github.com/mariovagomarzal/dotfiles/commit/f55c36236fa0426dc3aa358e3736b9be49126dc6))
- Add some base content to the README file - ([21d00ac](https://github.com/mariovagomarzal/dotfiles/commit/21d00ac529fb9e6a5aa7e21fb5f2870637b136a9))
- Add the Homebrew installation step to the install process - ([ecf01a1](https://github.com/mariovagomarzal/dotfiles/commit/ecf01a12edd1d95a48a68af035a900693231fe8f))
- Add the Fish package - ([1e093dc](https://github.com/mariovagomarzal/dotfiles/commit/1e093dc3fe44408117220d11e9e6f35091092c77))
- Fix the task that makes fish the default shell - ([dacbd06](https://github.com/mariovagomarzal/dotfiles/commit/dacbd066a89e1b267c463f3016854281e9eb8715))
- Add the Starship package - ([be251db](https://github.com/mariovagomarzal/dotfiles/commit/be251dbf6ee0d177b1a17b6c0d73ed31e72b28dd))
- Change the foreground color in most of the Starship styles - ([733e2c9](https://github.com/mariovagomarzal/dotfiles/commit/733e2c9f66f553c2a255e64bc08e6a7e6bfc7a80))
- Add the Git package along with GPG and Delta - ([d078838](https://github.com/mariovagomarzal/dotfiles/commit/d078838bda180ad76c127486169b2fcc930ebe70))
- Add the Pyenv package - ([87fecaa](https://github.com/mariovagomarzal/dotfiles/commit/87fecaa0f69a48083652c1af21992b6590ef3baf))
- Add the Juliaup package - ([9636be9](https://github.com/mariovagomarzal/dotfiles/commit/9636be9cb6c018a80504b58bd01f45559fa43d42))
- Add the MacTeX package - ([f67f3de](https://github.com/mariovagomarzal/dotfiles/commit/f67f3de2a1e312fb218461252b61bf7a12b7c334))
- Add the Typst package - ([e1ab646](https://github.com/mariovagomarzal/dotfiles/commit/e1ab6462aa2d0c2d58024026425da86ff2b70252))
- Add the Alacritty package - ([283f01e](https://github.com/mariovagomarzal/dotfiles/commit/283f01e6f2d51c434208c4a8e4c3a6a8d441ceb2))
- Add the `defaultBranch` configuration option for Git - ([f498fbd](https://github.com/mariovagomarzal/dotfiles/commit/f498fbda0a0fc8fa62477ab77d6493da9efba1e2))
- Add the Visual Studio Code package - ([d0ad443](https://github.com/mariovagomarzal/dotfiles/commit/d0ad4435aae26733bf27e40e274ba81f2c538149))
- Add extra spaces at the end of the directory substitutions icons - ([fb57efb](https://github.com/mariovagomarzal/dotfiles/commit/fb57efb0f9a002714c1c918d696760e011d49b5d))
- Ignore the timeout of the `custom.python` module - ([a3cfc2f](https://github.com/mariovagomarzal/dotfiles/commit/a3cfc2f81846b893b065252c0ae84ddd7c0113e6))
- Remove the `wren/dotbot-brew` submodule - ([d0d0206](https://github.com/mariovagomarzal/dotfiles/commit/d0d0206719b241edf3fe9ccc1e774ad3413ebdd5))
- Add the new `dotbot-brew` submodule by @d12frosted - ([0a11d90](https://github.com/mariovagomarzal/dotfiles/commit/0a11d903cb6bf892a735edcc557406d38723adaf))
- Update the directives to fit the new `dotbot-brew` plugin - ([35b92b2](https://github.com/mariovagomarzal/dotfiles/commit/35b92b2baec0a18ff3506349b25bcd49a32a4d4c))
- Change the `mactex` cask to `mactex-no-gui` cask - ([1059015](https://github.com/mariovagomarzal/dotfiles/commit/1059015dd2da87a77067658fc7339d80d5621487))
- Add necessary files for SSH keys management - ([44bfc3a](https://github.com/mariovagomarzal/dotfiles/commit/44bfc3abf4bc1729eb04fbb635efb378c854f4f3))
- Change the README format - ([8a7c877](https://github.com/mariovagomarzal/dotfiles/commit/8a7c8777b994461126bfae42ae1d9f36a3da24ed))
- Add the Maccy application - ([16eb961](https://github.com/mariovagomarzal/dotfiles/commit/16eb96173179eed09440d2d00604d6f746a63143))
- Add the IINA application - ([ca03098](https://github.com/mariovagomarzal/dotfiles/commit/ca030986dbefb276f7c49ea3e60783a3798a23be))
- Add the Calibre application - ([8e6be33](https://github.com/mariovagomarzal/dotfiles/commit/8e6be338363d6619fb0156b193d99be230c52e15))
- Add the Google Drive application - ([3d104f5](https://github.com/mariovagomarzal/dotfiles/commit/3d104f519c227ab2768dad1843291efb1f20dea4))
- Rewrite the description of the Visual Studio Code package - ([dd495da](https://github.com/mariovagomarzal/dotfiles/commit/dd495da211ced64cc4e7d2cec08e62c837f3edb1))
- Remove an extra blank line - ([044dcc6](https://github.com/mariovagomarzal/dotfiles/commit/044dcc63387ac75eb568d842a05ef5a875433576))
- Add the Kerabiner-Elements package - ([e860f38](https://github.com/mariovagomarzal/dotfiles/commit/e860f3812b4c1631a43fc9ebb259d0eec10ab77b))
- Remove the `d12frosted/dotbot-brew` submodule - ([5f29872](https://github.com/mariovagomarzal/dotfiles/commit/5f29872dbe78c279afff20036784a41fb206dffb))
- Add the new `dotbot-brew` submodule by @mariovagomarzal - ([aa2c6a1](https://github.com/mariovagomarzal/dotfiles/commit/aa2c6a12b9ffa7a81d7c75aa93ee6e887802eaeb))
- Add the `install-brew` directive - ([d5f27f3](https://github.com/mariovagomarzal/dotfiles/commit/d5f27f3ad42b6096bddedb9d4bd3cfb438c9c8ae))
- Update the `dotbot-brew` submodule to the last version - ([917abe8](https://github.com/mariovagomarzal/dotfiles/commit/917abe804ec09040b1894a87414feedaebee3244))
- Update the link to the `dotbot-brew` GitHub page - ([192e134](https://github.com/mariovagomarzal/dotfiles/commit/192e134f2844603de063178e3adef1707448e4e7))
- Remove an extra blank line - ([38a99d1](https://github.com/mariovagomarzal/dotfiles/commit/38a99d1c26cbf45847fcfdc7c5cdacb1d948ee73))
- Change the `gpg` package name to `gnupg` - ([5c5dcc1](https://github.com/mariovagomarzal/dotfiles/commit/5c5dcc189ed5a22bb7e1304f395cba851af32864))
- Add the Homebrew's path to the PATH variable in fish - ([07bf3c5](https://github.com/mariovagomarzal/dotfiles/commit/07bf3c5b253ef732eda02f9d40dd5f72a8aefcda))
- Add `poetry` and `cookiecutter` as Python system dependencies - ([fffcd59](https://github.com/mariovagomarzal/dotfiles/commit/fffcd59ab73e2e4fa533da9d1fefc68c622faedd))
- Update the `dotbot-brew` submodule to the last version - ([1f968ec](https://github.com/mariovagomarzal/dotfiles/commit/1f968ec0b76b0f19436f251dc6691ef879591446))
- Add a script to setup Fish shell - ([7ed6022](https://github.com/mariovagomarzal/dotfiles/commit/7ed6022b49749904bc75d787365ca29e2eb6d359))
- Update the `dotbot-brew` submodule to the last version - ([5a347d8](https://github.com/mariovagomarzal/dotfiles/commit/5a347d80c71d3988aa47ef7dc2cc176c81e433fb))
- Add the `CHANGELOG.md` file - ([3d951af](https://github.com/mariovagomarzal/dotfiles/commit/3d951af6e214f956e712d46594e5d24d02c5845f))
- Change the version number format - ([2daa0d2](https://github.com/mariovagomarzal/dotfiles/commit/2daa0d29f7a67db4beb8c776040dc50eafb9d79a))
- Change the unreleased section to the new version number - ([372ce34](https://github.com/mariovagomarzal/dotfiles/commit/372ce346fa721ab0961d1c0114ce5157f2f58eb1))

<!-- generated by git-cliff -->
