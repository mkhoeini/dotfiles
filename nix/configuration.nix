input@{
  pkgs,
  inputs,
  system,
  username,
  ...
}:

let
  programs = import ./programs input;
  services = import ./services input;
in
{
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    nil
    nixd
    nixfmt-rfc-style
  ];

  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  inherit programs services;

  security.pam.enableSudoTouchIdAuth = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;
  system.defaults.dock.autohide = true;
  system.defaults.dock.expose-animation-duration = 1.0e-3;
  system.defaults.dock.launchanim = false;
  system.defaults.dock.mru-spaces = false;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.universalaccess.reduceMotion = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  nixpkgs.config = {
    allowUnfree = true;
  };

}
