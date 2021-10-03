FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://ast2600_nfs.cfg \
            file://0001-change-flash-layout.patch \
            "
