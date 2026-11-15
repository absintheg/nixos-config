{
  pkgs-unstable,
  ...
}:
let
  makeUnstableOverlay =
    pkgNames:
    (
      final: prev:
      builtins.listToAttrs (
        map (x: {
          name = x;
          value = pkgs-unstable.${x};
        }) pkgNames
      )
    );
in
{
  nixpkgs.overlays = [
    (makeUnstableOverlay [
      # "opencode"
      "neovim"
      "heroic"
      "nixos-firewall-tool"
    ])
    (final: prev: {
      # prismlauncher = pkgs.prismlauncher.override {
      #   prismlauncher-unwrapped = pkgs.prismlauncher-unwrapped.overrideAttrs (old: {
      #     version = "custom";
      #     src = inputs.prism-launcher;
      #   });
      # };
    })
  ];
}
