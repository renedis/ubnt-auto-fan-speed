#!/bin/sh
#
# This script installs fancontrol
#
set -e

# Get DataDir location
DATA_DIR="/data"
case "$(ubnt-device-info firmware || true)" in
1*)
    DATA_DIR="/mnt/data"
    INSTALL_TYPE=1
    ;;
2*)
    DATA_DIR="/data"
    INSTALL_TYPE=2
    ;;
3*)
    DATA_DIR="/data"
    INSTALL_TYPE=2
    ;;
*)
    echo "ERROR: No persistent storage found." 1>&2
    INSTALL_TYPE=99
    exit 1
    ;;
esac

GH_REPO="renedis/ubnt-auto-fan-speed"
GH_URL_BASE="https://raw.githubusercontent.com/${GH_REPO}/HEAD"

if [ $INSTALL_TYPE -eq 1 ]; then
    #
    # Firmware v1.x.x
    #
    echo "#######################################################"
    echo "# Installing ${GH_REPO}"
    echo "#  for firmware v1.x.x"
    echo "#######################################################"
    ON_BOOT_DIR="${DATA_DIR}/on_boot.d"
    [ -d $ON_BOOT_DIR ] || (echo "ERROR: ${ON_BOOT_DIR} not found." 1>&2 && exit 1)
    FAN_SPEED_SH="${ON_BOOT_DIR}/11-ubnt-auto-fan-speed.sh"
    wget --quiet -O ${FAN_SPEED_SH} "${GH_URL_BASE}/on_boot.d/11-ubnt-auto-fan-speed.sh"
    chmod +x ${FAN_SPEED_SH}
    sh ${FAN_SPEED_SH}
 
elif [ $INSTALL_TYPE -eq 2 ]; then
    #
    # Firmware v2.x.x, v3.x.x
    #
    echo "#######################################################"
    echo "# Installing ${GH_REPO}"
    echo "#  for firmware v2.x.x, v3.x.x"
    echo "#######################################################"
    # Install fancontrol if its not already done
    apt list fancontrol 2> /dev/null | grep "installed" && echo "fancontrol already installed" || (echo "Installing fancontrol" && apt install fancontrol -y)
    # Grab the config fiie from the repo 
    wget --quiet -O /etc/fancontrol ${GH_URL_BASE}/on_boot.d/fancontrol
    echo "Restarting fancontrol" && service fancontrol restart
else
    # Shouldn't ever get here
    echo "ERROR: Mystery INSTALL_TYPE value (${INSTALL_TYPE})." 1>&2
    exit 1
fi

echo "#######################################################"
echo "# Done"
echo "#######################################################"
exit 0