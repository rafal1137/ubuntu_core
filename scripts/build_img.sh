#!/bin/sh
set -e

echo "###################################"
echo Building Ubuntu Core 22 x86_64
echo You need to manually install pulseaudio snap and manually connect it inside running VM or whatever
echo snap install pulseaudio --beta
echo "###################################"
echo Downloading snaps
snap download --target-directory=../snaps etlegacy --edge
snap download --target-directory=../snaps mesa-core22
snap download --target-directory=../snaps core20
snap download --target-directory=../snaps mir-kiosk
echo "###################################"
echo Building actual image file of 8GB size
ubuntu-image --validation=enforce --image-size 8G snap ../models/ubuntu-core-22-amd64.model --snap ../snaps/etlegacy_*.snap --snap ../snaps/mesa-core22_*.snap --snap ../snaps/core20_*.snap --snap ../snaps/mir-kiosk_*.snap --output-dir=../ubuntu-core-22-amd64


echo "###################################"
echo Building Ubuntu Core 22 aarch64
echo If you are running it on x86_64 arch you need to install snaps inside img manually
echo etlegacy
echo mesa-core22
echo core20
echo mir-kiosk
echo You need to manually install pulseaudio snap and manually connect it inside running VM or whatever
echo snap install pulseaudio --beta
echo "###################################"
echo Building actual image file of 8GB size
ubuntu-image --validation=enforce --image-size 8G snap ../models/ubuntu-core-22-arm64.model --output-dir=../ubuntu-core-22-arm64
