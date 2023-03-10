#!/bin/bash

## 添加package
pushd package
git clone --depth=1 https://github.com/fw876/helloworld.git
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall passwall
git clone --depth=1 -b luci https://github.com/xiaorouji/openwrt-passwall luci-app-passwall
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# luci-app-unblockneteasemusic
if [ -d "../feeds/luci/applications/luci-app-unblockneteasemusic" ]; then
  pushd ../feeds/luci/applications/luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic
  # uclient-fetch Use IPv4 only
  sed -i 's/uclient-fetch/uclient-fetch -4/g' update.sh
  # unblockneteasemusic core
  mkdir -p core
  curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
  echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)" > core_local_ver
  curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o core/app.js
  curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o core/bridge.js
  curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o core/ca.crt
  curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o core/server.crt
  curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o core/server.key
  popd
fi

# luci-app-adguardhome
rm -rf ../feeds/luci/applications/luci-app-adguardhome
git clone --depth=1 https://github.com/TioaChan/luci-app-adguardhome
#https://github.com/rufengsuixing/AdGuardHome

# luci-app-mosdns
# drop mosdns and v2ray-geodata packages that come with the source
find .. -maxdepth 4 -iname "*mosdns" -type d | xargs rm -rf
find ../ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ../ | grep Makefile | grep mosdns | xargs rm -f
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns.git mosdns
git clone --depth=1 https://github.com/sbwml/v2ray-geodata.git v2ray-geodata

# luci-app-netdata
#find .. -maxdepth 4 -iname "*netdata" -type d | xargs rm -rf
rm -rf ../feeds/luci/applications/luci-app-netdata
git clone --depth=1 https://github.com/sirpdboy/luci-app-netdata

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
#rm -rf ../feeds/luci/applications/luci-app-eqos
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-eqos

#find .. -maxdepth 4 -iname "*serverchan" -type d | xargs rm -rf
#find .. -maxdepth 4 -iname "*pushbot" -type d | xargs rm -rf
#git clone --depth=1 https://github.com/tty228/luci-app-serverchan.git
#git clone --depth=1 https://github.com/zzsj0928/luci-app-pushbot.git

find . -maxdepth 4 -iname "*autotimeset" -type d | xargs rm -rf
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset.git

# OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter.git

# aliyundrive-webdav
rm -rf ../feeds/luci/applications/luci-app-aliyundrive-webdav
rm -rf ../feeds/packages/multimedia/aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt aliyundrive

# luci-app-bandwidthd
git clone https://github.com/AlexZhuo/luci-app-bandwidthd.git

# Add Theme
# luci-theme-design theme
rm -rf ../feeds/luci/themes/luci-theme-design
if [ $SOURCE_BRANCH = "openwrt-21.02" ]; then
  git clone --depth=1 -b js https://github.com/gngpp/luci-theme-design.git
else 
  git clone --depth=1 https://github.com/gngpp/luci-theme-design.git
fi
# jerrykuku Argon theme
rm -rf ../feeds/luci/themes/luci-theme-argon
if [ $SOURCE_BRANCH = "openwrt-21.02" ]; then
  git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon
else 
  git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
fi
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
sed -i '/letter-spacing: 1px/{N;s#text-transform: uppercase#text-transform: none#}' luci-theme-argon/htdocs/luci-static/argon/css/cascade.css
popd

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# 修改插件名字
sed -i 's/"解除网易云音乐播放限制"/"网易云音乐解锁"/g' `grep "解除网易云音乐播放限制" -rl ./`

# Modify default IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# Rename hostname to OpenWrt
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# Change default shell to zsh
#sed -i 's#/bin/ash#/usr/bin/zsh#g' package/base-files/files/etc/passwd

# Add date version
export DATE_VERSION=$(date -d "$(rdate -n -4 -p pool.ntp.org)" +'%Y-%m-%d')
sed -i "s/%C/%C (${DATE_VERSION})/g" package/base-files/files/etc/openwrt_release

# 修改欢迎banner
cp -f $GITHUB_WORKSPACE/data/banner package/base-files/files/etc/banner

# samba解除root限制
sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template
