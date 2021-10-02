SUMMARY = "OpenBMC - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-chassis \
        ${PN}-system \
        "

PROVIDES += "virtual/obmc-chassis-mgmt"
#PROVIDES += "virtual/obmc-fan-mgmt"
#PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES:${PN}-chassis += "virtual-obmc-chassis-mgmt"
#RPROVIDES:${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES:${PN}-system += "virtual-obmc-system-mgmt"

SUMMARY:${PN}-chassis = "Chassis"
RDEPENDS:${PN}-chassis = " \
        x86-power-control \
        obmc-host-failure-reboots \
        "


SUMMARY:${PN}-flash = "Flash"
RDEPENDS:${PN}-flash = " \
        phosphor-software-manager \
        "

SUMMARY:${PN}-system = " System"
RDEPENDS:${PN}-system = " \
        bmcweb \
        dbus-sensors \
        entity-manager \
        ipmitool \
        phosphor-hostlogger \
        webui-vue \
        "
