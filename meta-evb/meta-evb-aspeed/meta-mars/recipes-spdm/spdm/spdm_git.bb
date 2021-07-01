LICENSE = "Unknown"
LIC_FILES_CHKSUM = "file://License.txt;md5=60ffa8c1c23c070f095e640d3490e8fb"

PV = "1.0+git${SRCPV}"

SRC_URI = "git://git@github.com/jyao1/openspdm.git;protocol=ssh \
           file://0001-fix-the-build-error-add-include-file-and-library-pa.patch \
           file://0001-add-install-target.patch \
           file://0002-build-the-sharelibray-for-linux.patch \
           "
SRCREV = "453ef6cc1cb975182c37d866c08e5edd75484b17"

S = "${WORKDIR}/git"
inherit cmake


EXTRA_OECMAKE = "-DARCH=ARM -DTOOLCHAIN=ARM_GCC  -DTARGET=Debug -DCRYPTO=Openssl -DTESTTYPE=SpdmEmu"
DEPENDS = "openssl"
