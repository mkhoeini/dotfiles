input@{ ... }:

let
  sketchybar = import ./sketchybar input;
in
{
  # Auto upgrade nix package and the daemon service.
  nix-daemon.enable = true;

  ipfs.enable = true;
  nextdns.enable = true;
  inherit sketchybar;
}
