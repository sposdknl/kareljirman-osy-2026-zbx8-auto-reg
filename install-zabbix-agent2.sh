#!/usr/bin/env bash
# Instalace Zabbix Agent 2 8.0 LTS na Debian 13 z oficiálního repozitáře Zabbixu.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

DEB="zabbix-release_latest_8.0+debian13_all.deb"
URL="https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/${DEB}"

# Při opakovaném provisioningu instalaci přeskoč
if dpkg -s zabbix-agent2 >/dev/null 2>&1; then
    echo "zabbix-agent2 je již nainstalován, instalaci přeskakuji."
    zabbix_agent2 -V | head -1
    exit 0
fi

# a) Zabbix repozitář
apt-get update
apt-get install -y wget ca-certificates netcat-openbsd
cd /tmp
rm -f "${DEB}"
wget -q "${URL}"
dpkg -i "${DEB}"
apt-get update

# b) Zabbix agent 2
apt-get install -y zabbix-agent2

# d) Spuštění a start po bootu
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2

zabbix_agent2 -V | head -1