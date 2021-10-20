FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://ast2600_nfs.cfg \
            file://openbmc-flash-layout-64.dtsi \
            file://0001-remove-wp-inverted.patch \
            "

do_patch:append() {
    for DTB in "${KERNEL_DEVICETREE}"; do
        DT=`basename ${DTB} .dtb`
        if [ -r "${WORKDIR}/${DT}.dts" ]; then
            cp ${WORKDIR}/${DT}.dts \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts
        fi
    done
}
