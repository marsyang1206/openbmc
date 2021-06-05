LICENSE = "Unknown"
LIC_FILES_CHKSUM = "file://License.txt;md5=60ffa8c1c23c070f095e640d3490e8fb"

PV = "1.0+git${SRCPV}"

SRC_URI = "git://git@github.com/jyao1/openspdm.git;protocol=ssh \
           file://0001-fix-the-build-error-add-include-file-and-library-pa.patch \
           "
SRCREV = "453ef6cc1cb975182c37d866c08e5edd75484b17"

PV = "1.0+git${SRCPV}"

inherit cmake

EXTRA_OECMAKE = "-DARCH=ARM -DTOOLCHAIN=ARM_GCC  -DTARGET=Debug -DCRYPTO=Openssl -DTESTTYPE=SpdmEmu  --debug-output "

DEPENDS = "openssl"

do_configure_prepend() {
    rm ${S}/OsStub/OpensslLib/openssl
    ln -s ${WORKDIR}/../../openssl/1.1.1j-r0/openssl-1.1.1j  ${S}/OsStub/OpensslLib/openssl
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/bin/* ${D}${bindir}
}
