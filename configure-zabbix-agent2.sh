#!/usr/bin/env bash

CONF=/etc/zabbix/zabbix_agent2.conf
HOSTFILE=/var/lib/zabbix-agent2-hostname

# Unikátní hostname, vytvoří se jen poprvé a pak se znovu použije
[ -s $HOSTFILE ] || echo "jirmank-debian13-$(cut -c1-8 /proc/sys/kernel/random/uuid)" > $HOSTFILE
HOSTNAME_ZBX=$(cat $HOSTFILE)

# Konfigurace zabbix_agent2.conf
[ -f $CONF-orig ] || cp -v $CONF $CONF-orig
sed -i "s/^Hostname=.*/Hostname=$HOSTNAME_ZBX/" $CONF
sed -i 's/^Server=.*/Server=enceladus.pfsense.cz/' $CONF
sed -i 's/^ServerActive=.*/ServerActive=enceladus.pfsense.cz/' $CONF
sed -i 's/^#\? \?HostMetadata=.*/HostMetadata=SPOS/' $CONF
diff -u $CONF-orig $CONF

# Restart služby zabbix-agent2
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2

# EOF