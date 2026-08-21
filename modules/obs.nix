{
  # pkgs,
  ...
}:
{
  programs.obs-studio = {
    enable = true;

	# Errors after switching to unstable
    # package = (
    #   pkgs.obs-studio.override {
    #     cudaSupport = true;
    #   }
    # );
  };
}
