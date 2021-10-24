FILESEXTRAPATHS:append := ":${THISDIR}/files"
SRC_URI:append += "file://ast2600a1-evb.dts \
                   file://u-boot-env.txt"


do_configure:prepend (){
    dts="${UBOOT_DEVICETREE}.dts"
    cp ${WORKDIR}/$dts ${S}/arch/arm/dts/
    #cp ${WORKDIR}/u-boot-env.txt ${WORKDIR}/u-boot-env-ast2600.txt
}

do_deploy:append (){
    dd if=${DEPLOYDIR}/${UBOOT_ENV_BINARY} of=${DEPLOYDIR}/${UBOOT_IMAGE} \
        bs=1024 seek=${UBOOT_ENV_OFFSET} conv=notrunc count=64
}

do_compile:append() {
    if [ -n "${UBOOT_ENV}" ]
    then
        # Generate redundant environment image
        ${B}/tools/mkenvimage  -s ${UBOOT_ENV_SIZE} -o ${WORKDIR}/${UBOOT_ENV_BINARY} ${WORKDIR}/u-boot-env.txt
    fi
}
