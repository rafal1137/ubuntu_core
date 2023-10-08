#!/bin/sh
set -e
#sudo qemu-system-aarch64 -machine virt -cpu cortex-a72 -smp 6 -m 3G -net nic,model=virtio  -net user,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80 -drive file=/usr/share/AAVMF/AAVMF_VARS.ms.fd,if=pflash,format=raw,unit=1  -chardev socket,id=chrtpm,path="/var/snap/test-snapd-swtpm/current/swtpm-sock"  -tpmdev emulator,id=tpm0,chardev=chrtpm -drive "file=ubuntu-core-22-arm64.img",if=none,format=raw,id=disk1  -device virtio-blk-pci,drive=disk1,bootindex=1  -serial mon:stdio -vga qxl


cp /usr/share/AAVMF/AAVMF_CODE.fd firmware-code-arm64.fd
cp /usr/share/AAVMF/AAVMF_VARS.fd firmware-vars-arm64.fd

sudo qemu-system-aarch64 \
  -name arm64 \
  -machine virt \
  --accel tcg,thread=multi \
  -cpu cortex-a57 \
  -smp 6 \
  -m 2g \
  -k pt \
  -nographic \
  -drive if=pflash,file=firmware-code-arm64.fd,format=raw \
  -drive if=pflash,file=firmware-vars-arm64.fd,format=raw \
  -drive if=virtio,file=../ubuntu-core-22-arm64/pc.img,cache=unsafe,discard=unmap,id=hd0 \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device virtio-net-pci,netdev=net0 \
  -device virtio-rng-pci,rng=rng0 \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -vga qxl \
  -qmp unix:arm64.socket,server,nowait
