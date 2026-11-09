{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    cmake
    cargo
    devenv
    python3
    tree-sitter
    perf
    nixd
    nil
    nixfmt
    lazygit

    nodejs
    typescript
    typescript-language-server
  ];

  programs.firejail.enable = true;
  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
}
