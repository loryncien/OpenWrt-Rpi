echo 'diy-lean.sh 18.06'
pushd package
# luci-app-unblockneteasemusic
rm -rf ../feeds/luci/applications/luci-app-unblockneteasemusic
git clone --depth=1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git
# uclient-fetch Use IPv4 only
sed -i 's/uclient-fetch/uclient-fetch -4/g' luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic/update.sh
# unblockneteasemusic core
NAME=$"luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic" && mkdir -p $NAME/core
curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)">"$NAME/core_local_ver"
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o $NAME/core/app.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o $NAME/core/bridge.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o $NAME/core/ca.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o $NAME/core/server.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o $NAME/core/server.key
popd

# Modify localtime in Homepage
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm
# Shows increased compile time
#sed -i "s/<%=pcdata(ver.distversion)%>/& (By @Cheng build $(TZ=UTC-8 date "+%Y-%m-%d"))/g" package/lean/autocore/files/x86/index.htm
# Modify hostname in Homepage
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

pushd package/lean/default-settings/files
# 设置密码为空
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' zzz-default-settings
# 版本号里显示一个自己的名字
export date_version=$(TZ=UTC-8 date +'%Y-%m-%d')
sed -ri "s#(R[0-9].*[0-9])#\1 (By @Cheng build ${date_version}) #g" zzz-default-settings
popd
