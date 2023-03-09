#!/bin/sh
#===============================================
# File name: init-settings.sh
# Description: This script will be executed during the first boot
# Author: SuLingGG
# Blog: https://mlapp.cn
#===============================================

[ -f '/bin/bash' ] && sed -i "s#/bin/ash#/bin/bash#g" /etc/passwd
# [ -f '/usr/bin/zsh' ] && sed -i "s#/bin/ash#/usr/bin/zsh#g" /etc/passwd

# Set default theme to luci-theme-argon`
uci set luci.main.lang=zh_cn
uci set luci.main.mediaurlbase='/luci-static/argon'

# Disable opkg signature check
# sed -i 's/option check_signature/# option check_signature/g' /etc/opkg.conf
# Delete the line containing the keyword in distfeeds.conf
sed -i '/passwall/d' /etc/opkg/distfeeds.conf
sed -i '/helloworld/d' /etc/opkg/distfeeds.conf

# Check file system during boot
uci set fstab.@global[0].check_fs=1

# Enable dhcp force
#uci set dhcp.lan.force='1'

# Disable IPv6 DHCP, ULA
uci -q delete dhcp.lan.ra
uci -q delete dhcp.lan.ra_management
uci -q delete dhcp.lan.dhcpv6
# Disable IPV6 ula prefix
uci -q delete network.globals.ula_prefix
uci -q delete network.wan6

# disable IPV6 DNS
uci set dhcp.@dnsmasq[0].filter_aaaa='1'
uci set dhcp.@dnsmasq[0].rebind_protection='1'
uci set dhcp.@dnsmasq[0].rebind_localhost='1'

uci commit

# 启动本地内核
[ -d '/www/snapshots' ] && sed -i 's|core.*|core file:///www/snapshots/targets/x86/64/packages|' /etc/opkg/distfeeds.conf

# sirpdboy luci-app-netdata-cn 不能启动
[ -f '/etc/init.d/netdata' ] && chmod +x /etc/init.d/netdata

exit 0
