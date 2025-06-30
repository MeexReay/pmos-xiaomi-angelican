let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  pkgs = import unstableTarball {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      pmbootstrap
      android-tools
      git
      less
    ];
  }
