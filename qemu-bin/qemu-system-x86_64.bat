qemu-system-x86_64.exe -bios ../ovmf/ovmf_x64.bin -smp 6 -m 2048 -machine q35 -global ICH9-LPC.disable_s3=1 -net nic,model=virtio -net user,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80 -drive "file=../ubuntu-core-22-amd64/pc.img",if=none,format=raw,id=disk1 -device virtio-blk-pci,drive=disk1,bootindex=1 -serial mon:stdio -vga qxl