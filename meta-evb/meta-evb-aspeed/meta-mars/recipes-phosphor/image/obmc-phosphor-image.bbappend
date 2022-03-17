

do_image_emmc() {
    out=${DEPLOY_DIR_IMAGE}/emmc.bin

    dd of=${out} if=/dev/zero bs=1M count=1024
    dd of=${out} if=${DEPLOY_DIR_IMAGE}/u-boot-spl.bin conv=notrunc
    dd of=${out} if=${DEPLOY_DIR_IMAGE}/u-boot.bin conv=notrunc bs=1K seek=64
    xzdec ${IMGDEPLOYDIR}/obmc-phosphor-image-evb-mars.wic.xz | dd of=${out} bs=1M seek=2 conv=notrunc
}
addtask do_image_emmc after do_image_wic before do_build
