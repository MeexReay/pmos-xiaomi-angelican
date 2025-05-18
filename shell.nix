{ pkgs ? import (builtins.fetchTarball {
  name = "nixos-unstable-2025-05-18";
  url = "https://github.com/nixos/nixpkgs/archive/10862bc5b70821539abbe4ed885fdd7070675143.tar.gz";
  sha256 = "0m40jd2q7s10z321hqirvd8dz4ipaawqpwpa0g7v8yys5z8hyix0";
}) {} }: 
pkgs.mkShell {
  buildInputs = with pkgs; [
    pmbootstrap
    android-tools
    git
  ];

  shellHook = ''
#     export PMWORK=$PWD/.pmbootstrap
#     export PMAPORTS=$PMWORK/cache_git/pmaports
#     mkdir -p $PMWORK
#     if [ ! -d $PMAPORTS ]; then
#       mkdir -p $PMWORK/cache_git
#       git clone https://gitlab.postmarketos.org/postmarketOS/pmaports.git $PMAPORTS
#     fi
    source extract-paths.sh
    if [ ! -L $PMAPORTS/device/testing/linux-xiaomi-angelican ]; then
      ln -s $PWD/linux-xiaomi-angelican $PMAPORTS/device/testing
    fi
    if [ ! -L $PMAPORTS/device/testing/device-xiaomi-angelican ]; then
      ln -s $PWD/device-xiaomi-angelican $PMAPORTS/device/testing
    fi
#     if [ ! -f $PMWORK/pmbootstrap.conf ]; then
#       cat > $PMWORK/pmbootstrap.conf <<EOF
# [pmbootstrap]
# device = xiaomi-angelican
# hostname = xiaomi-angelican
# systemd = never

# [providers]

# [mirrors]
# EOF
#     fi
#     if [ ! -f $PMWORK/version ]; then
#       echo "8" > $PMWORK/version
#     fi
#     alias pmbootstrap="\
#       \pmbootstrap \
#         --aports $PMAPORTS \
#         --work $PMWORK \
#     "
  '';
}
