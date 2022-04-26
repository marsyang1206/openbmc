FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "file://nfs.cfg \
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
