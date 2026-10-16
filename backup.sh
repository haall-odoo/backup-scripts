#!/bin/bash

# This script is intended to compress files wanted to be backup in a single tar to ease the transfer of data when changing computer
# It is implemented following the brilliant idea of mbec@odoo.com
PATHS=$(ls ~)

CONFIG_PATH=./backup.conf
source $CONFIG_PATH
echo $EXCLUDED_PATHS
for excluded in $EXCLUDED_PATHS; do
    PATHS=${PATHS//$excluded/};
done

FULL_PATHS=()
for path in $PATHS; do
    FULL_PATHS+=(~/${path})
done
FULL_PATHS="${FULL_PATHS[*]}"

case $1 in
    'info')
        echo "#### Config for backup";
        echo -e "${COLOR_BLUE}Version: ${COLOR_GREEN}${VERSION}${COLOR_RESET}"
        
        echo -e "${COLOR_BLUE}Base paths: ${COLOR_GREEN}${FULL_PATHS}${COLOR_RESET}"
        echo -e "${COLOR_BLUE}Additonal Paths:\n${COLOR_GREEN}${ADDITIONAL_PATHS}${COLOR_RESET}"
    ;;
    run)
        echo "#### Backup-ing your home";
        sudo -v
        timestamp=$(date "+%Y%m%d_%H%M%S")
        serial_number=$(sudo dmidecode -s system-serial-number)
        tar cvf "/tmp/backup-${serial_number}_${timestamp}.tar.zst" ${FULL_PATHS} ${ADDITIONAL_PATHS}
    ;;
    *)
        echo "Not implemented option, available option are info and run";
    ;;
esac