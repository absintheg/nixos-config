{ pkgs, unstable, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      unityhub
      aseprite
      gimp
      krita
      blender
    ]
    ++ [
      unstable.godot
    ];
}
