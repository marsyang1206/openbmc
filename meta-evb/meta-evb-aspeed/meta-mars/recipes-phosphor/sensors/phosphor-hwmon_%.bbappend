FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"


ITEMS = " \
        bus@1e78a000/i2c-bus@12/tmp421@4c \
        "



ENVS = "obmc/hwmon/ahb/apb/{0}.conf"
SYSTEMD_ENVIRONMENT_FILE:${PN} += "${@compose_list(d, 'ENVS', 'ITEMS')}"

EXTRA_OEMESON = " -Dupdate-functional-on-fail=true"
