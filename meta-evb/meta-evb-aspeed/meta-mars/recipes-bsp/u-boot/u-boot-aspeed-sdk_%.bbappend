FILESEXTRAPATHS:append := ":${THISDIR}/files"
SRC_URI:append += "file://ast2600a1-evb.dts \
                   file://u-boot-env.txt"


do_configure:prepend (){
    dts="${UBOOT_DEVICETREE}.dts"
    cp ${WORKDIR}/$dts ${S}/arch/arm/dts/
}

do_deploy:append (){
    #UBOOT_ENV is defined when MMC is used so it is only for SPI flash
    if [ ! -n "${UBOOT_ENV}" ]
    then
        dd if=${DEPLOYDIR}/${UBOOT_ENV_BINARY} of=${DEPLOYDIR}/${UBOOT_IMAGE} \
        bs=1024 seek=${UBOOT_ENV_OFFSET} conv=notrunc count=64
    fi
}

do_compile:append() {
    if [ ! -n "${UBOOT_ENV}" ]
    then
        ${B}/tools/mkenvimage -r -s ${UBOOT_ENV_SIZE} -o ${WORKDIR}/${UBOOT_ENV_BINARY} ${WORKDIR}/u-boot-env.txt
    fi
}
