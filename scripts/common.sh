#!/bin/bash

## 添加package
pushd package
git clone --depth=1 https://github.com/fw876/helloworld.git
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall passwall
git clone --depth=1 -b luci https://github.com/xiaorouji/openwrt-passwall luci-app-passwall
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# luci-app-adguardhome
rm -rf ../feeds/luci/applications/luci-app-adguardhome
git clone --depth=1 https://github.com/TioaChan/luci-app-adguardhome
#https://github.com/rufengsuixing/AdGuardHome

# luci-app-unblockneteasemusic
find .. -maxdepth 4 -iname "*unblock*music*" -type d | xargs rm -rf
if [ $SOURCE_BRANCH = "openwrt-21.02" ]; then
  git clone --depth=1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
else 
  git clone --depth=1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
fi
# uclient-fetch Use IPv4 only
sed -i 's/uclient-fetch/uclient-fetch -4/g' luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic/update.sh

# luci-app-mosdns
# drop mosdns and v2ray-geodata packages that come with the source
find .. -maxdepth 4 -iname "*mosdns" -type d | xargs rm -rf
find ../ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ../ | grep Makefile | grep mosdns | xargs rm -f
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata.git v2ray-geodata

# luci-app-netdata
#find .. -maxdepth 4 -iname "*netdata" -type d | xargs rm -rf
git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata
rm -rf ../feeds/luci/applications/luci-app-netdata

# luci-app-ddns-go
git clone --depth=1 https://github.com/sirpdboy/luci-app-ddns-go.git

# luci-app-alist
find .. -maxdepth 4 -iname "*alist" -type d | xargs rm -rf
rm -rf ../feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x ../feeds/packages/lang/golang
git clone --depth=1 https://github.com/sbwml/luci-app-alist.git

# luci-app-istore
svn co https://github.com/linkease/istore/trunk/luci istore
svn co https://github.com/linkease/istore-ui/trunk/app-store-ui app-store-ui

# luci-app-ddnsto
find .. -maxdepth 4 -iname "*ddnsto" -type d | xargs rm -rf
svn co https://github.com/linkease/nas-packages/trunk/network/services/ddnsto
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-ddnsto

# luci-app-eqos
find .. -maxdepth 4 -iname "*eqos" -type d | xargs rm -rf
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-eqos

#find .. -maxdepth 4 -iname "*serverchan" -type d | xargs rm -rf
#find .. -maxdepth 4 -iname "*pushbot" -type d | xargs rm -rf
#git clone --depth=1 https://github.com/tty228/luci-app-serverchan.git
#git clone --depth=1 https://github.com/zzsj0928/luci-app-pushbot.git

find . -maxdepth 4 -iname "*autotimeset" -type d | xargs rm -rf
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset.git

find .. -maxdepth 4 -iname "miniupnpd" -type d | xargs rm -rf
svn co https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd miniupnpd

# OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git

# aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt aliyundrive
rm -rf ../feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf ../feeds/packages/multimedia/aliyundrive-webdav

# luci-app-bandwidthd
git clone https://github.com/AlexZhuo/luci-app-bandwidthd.git

# Add Theme
# luci-theme-design theme
rm -rf ../feeds/luci/themes/luci-theme-design
git clone --depth=1 https://github.com/gngpp/luci-theme-design.git
# jerrykuku Argon theme
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../feeds/luci/themes/luci-theme-argon
sed -i '/letter-spacing: 1px/{N;s#text-transform: uppercase#text-transform: none#}' luci-theme-argon/htdocs/luci-static/argon/css/cascade.css
popd

# unblockneteasemusic core
NAME=$"package/luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic" && mkdir -p $NAME/core
curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)">"$NAME/core_local_ver"
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o $NAME/core/app.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o $NAME/core/bridge.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o $NAME/core/ca.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o $NAME/core/server.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o $NAME/core/server.key

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd


# Modify default IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# Rename hostname to OpenWrt
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# Change default shell to zsh
#sed -i 's#/bin/ash#/usr/bin/zsh#g' package/base-files/files/etc/passwd

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# samba解除root限制
sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# 添加poweroff按钮
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/poweroff.htm > ./feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_system/poweroff.htm
curl -fsSL https://raw.githubusercontent.com/sirpdboy/other/master/patch/poweroff/system.lua > ./feeds/luci/modules/luci-mod-admin-full/luasrc/controller/admin/system.lua

# luci-app-wrtbwmon 5s to 2s
sed -i 's#interval: 5#interval: 2#g' $(find feeds/luci -name 'wrtbwmon.js')
sed -i 's# selected="selected"##' $(find feeds/luci -name 'wrtbwmon.htm')
sed -i 's#"2"#& selected="selected"#' $(find feeds/luci -name 'wrtbwmon.htm')
