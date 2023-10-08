#!/bin/sh
set -e

sudo qemu-system-x86_64  -enable-kvm  -smp 6  -m 2048  -machine q35  -cpu host  -global ICH9-LPC.disable_s3=1  -net nic,model=virtio  -net user,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80   -drive file=/usr/share/OVMF/OVMF_CODE.secboot.fd,if=pflash,format=raw,unit=0,readonly=on  -drive file=/usr/share/OVMF/OVMF_VARS.ms.fd,if=pflash,format=raw,unit=1  -chardev socket,id=chrtpm,path="/var/snap/test-snapd-swtpm/current/swtpm-sock"  -tpmdev emulator,id=tpm0,chardev=chrtpm  -device tpm-tis,tpmdev=tpm0  -drive "file=../ubuntu-core-22-amd64/pc.img",if=none,format=raw,id=disk1  -device virtio-blk-pci,drive=disk1,bootindex=1  -serial mon:stdio -vga qxl
