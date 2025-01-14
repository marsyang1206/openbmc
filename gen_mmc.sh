#!/bin/sh

set -eu

print_help() {
    script_name=$(basename $0)
    echo NAME
    echo '\t'$script_name: Assemble an OpenBMC eMMC image that can be booted under QEMU
    echo
    echo SYNOPSYS
    echo '\t'$script_name '<TARGET>' '<BUILDDIR>' '[IMAGESIZE]'
    echo
    echo DESCRIPTION
    echo '\t''TARGET':'\t\t'The name of the target machine, used to locate the required images.
    echo '\t''BUILDDIR':'\t'The path to the OpenBMC build directory.
    echo '\t''IMAGESIZE':'\t'The output image size, may be specified with units. Defaults to 16G.
    echo
    echo EXAMPLE:
    echo '\t'$script_name 'p10bmc' '~/src/openbmc/openbmc/build/p10bmc'
}

if [ $# -eq 0 ]
then
    print_help
    exit 1
fi

if [ "$1" = "-h" -o "$1" = "--help" ]
then
    print_help
    exit 0
fi

if [ $# -lt 2 ]
then
    print_help
    exit 1
fi

set -x

target="$1"
build_dir="$2"
image_size=${3:-16G}

fw_dir=${build_dir}/tmp/deploy/images/${target}
wicxz="${fw_dir}/obmc-phosphor-image-${target}.wic.xz"
mmc="mmc-${target}.img"

dd of=$mmc if=/dev/zero bs=1M count=128
dd of=$mmc if=${fw_dir}/u-boot-spl.bin conv=notrunc
dd of=$mmc if=${fw_dir}/u-boot.bin conv=notrunc bs=1K seek=64
#dd of=$mmc if=${fw_dir}/u-boot.bin conv=notrunc
#xzdec $wicxz | dd of=$mmc conv=notrunc bs=1M seek=1
xzdec $wicxz | dd of=$mmc conv=notrunc bs=1M seek=2
truncate --size ${image_size} $mmc

set +x

echo
echo For an AST2600-based machine, invoke QEMU with the following parameters:
echo
echo '\t'-drive file=$(realpath ${mmc}),if=sd,format=raw,index=2
