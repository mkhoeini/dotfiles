input@{ ... }:

{
  zsh = import ./zsh.nix input;
  direnv = import ./direnv.nix input;
  gnupg = import ./gnupg.nix input;
  nix-index = import ./nix-index.nix input;
}
