{
  pkgs,
  pkgs-unstable,
  ...
}:
let
  shellAliases = {
    rs = "sudo nixos-rebuild switch --flake /etc/nixos";
    rb = "sudo nixos-rebuild boot --flake /etc/nixos";
    rt = "sudo nixos-rebuild test --flake /etc/nixos";

    fws = "sudo nixos-firewall-tool show";
    fwo = "sudo nixos-firewall-tool open";
    fwc = "sudo nixos-firewall-tool close";
    fwr = "sudo nixos-firewall-tool reset";
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
      ripgrep
      fastfetch
      fzf
      killall
      btop
      stow
      unzip
      unar
      wget
      gnumake
      gnupg
      tmux
      vim
      gh
      git
      pv

      man-pages
      man-pages-posix
    ]
    ++ (with pkgs-unstable; [
      opencode
      neovim
      yazi
    ]);

  documentation.dev.enable = true;

  users.users.me = {
    isNormalUser = true;
    description = "Myself";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    home = "/home/me";
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  security.sudo.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
