{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  shellAliases = {
    rebuild-switch = "sudo nixos-rebuild switch --flake";
    rebuild-boot = "sudo nixos-rebuild boot --flake";
    rebuild-test = "sudo nixos-rebuild test --flake";
  };
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enableZshIntegration = true;

  programs.bash.shellAliases = shellAliases;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = shellAliases;

    ohMyZsh = {
      enable = true;
	  theme = "essembeh";
      plugins = [
        "git"
        "sudo"
      ];
    };

    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.systemPackages =
    with pkgs;
    [
      fzf
      gh
      btop
      git
      lazygit
      stow
      fastfetch
      tree-sitter
      nixfmt
      nixd
      tmux
      unzip
      wget
      pv
      gcc
      gnupg
      vim
      killall
      ffmpeg_8
    ]
    ++ [
      pkgs-unstable.neovim
      pkgs-unstable.cargo
      pkgs-unstable.claude-code
    ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
	silent = true;
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };

  programs.firejail.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  users.users.me = {
    isNormalUser = true;
    description = "Myself";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
	uid = 4325;
    shell = pkgs.zsh;
    home = "/home/me";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
