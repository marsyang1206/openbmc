FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "file://fru.bin \
            file://0001-add-one-configuration-file-for-testing-entity-manage.patch \
        "

do_install:append(){
    install -m644 -D ${WORKDIR}/fru.bin ${D}/etc/fru/baseboard.fru.bin
}
