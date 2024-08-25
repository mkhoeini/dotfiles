{ pkgs, ... }:

with builtins;
let
  sketchyBarGit = fetchGit {
    url = "https://github.com/FelixKratz/SketchyBar.git";
    rev = "3946005f6b1f67357ed83ffc6e53eb9c6e867228";
    ref = "refs/tags/v2.21.0";
  };
  FelixKratzDotfiles = fetchGit {
    url = "https://github.com/FelixKratz/dotfiles.git";
    rev = "1589c769e28f110b1177f6a83fa145235c8f7bd6";
  };
  plugins = sketchyBarGit + /plugins;
  sketchybarrc = readFile ./sketchybarrc;
in
{
  enable = true;
  extraPackages = [ pkgs.babashka ];
  config = replaceStrings [ "$PLUGINS" ] [ plugins ] sketchybarrc;
}
