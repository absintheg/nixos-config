{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
let
  unstablePackages = [
    # "opencode"
    "niri"
    "neovim"
    "heroic"
    "nixos-firewall-tool"
    "jan"
  ];

  secondOverlay = (
    final: prev: {
      dms-shell = inputs.dms-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;
      bottles = pkgs-unstable.bottles.override { removeWarningPopup = true; };
    }
  );

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
    secondOverlay
    (makeUnstableOverlay unstablePackages)
  ];
}
