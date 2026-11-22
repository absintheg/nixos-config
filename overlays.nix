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
      noctalia = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
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
