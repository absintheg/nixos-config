{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  shellAliases = {
    rs = "sudo nixos-rebuild switch --flake /etc/nixos";
    rb = "sudo nixos-rebuild boot --flake /etc/nixos";
    rt = "sudo nixos-rebuild test --flake /etc/nixos";

    fwo = "sudo nixos-firewall-tool open";
    fwr = "sudo nixos-firewall-tool reset";
  };
in
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages =
    (import inputs.nixpkgs-kernel {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    }).linuxPackages_latest;

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
      ripgrep
      fastfetch
      fzf
      killall
      btop
      lazygit
      stow
      tree-sitter
      nixfmt
      nixd
      nil
      unzip
      unar
      wget
      gcc
      gnumake
      gnupg
      tmux
      vim
      cargo
      devenv
      python3
      gh
      git
      pv
    ]
    ++ (with pkgs-unstable; [
      neovim
      yazi
      opencode
      perf
    ]);

  programs.users.users.me = {
    isNormalUser = true;
    description = "Myself";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    home = "/home/me";
  };

  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
    firejail.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-all;
    };
  };

  security.sudo.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  system.stateVersion = "26.05";
}
