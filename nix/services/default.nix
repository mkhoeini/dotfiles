{ ... }:

{
  imports = [ ./sketchybar ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services.ipfs.enable = true;
  services.nextdns.enable = true;

  local.services.sketchybar.enable = false;
}
