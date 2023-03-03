# Modify localtime in Homepage
echo 'Modify localtime in Homepage...'
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm
# Modify hostname in Homepage
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

pushd package/lean/default-settings/files
# 设置密码为空
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' zzz-default-settings
# 版本号里显示一个自己的名字
export date_version=$(date +'%Y.%m.%d')
sed -ri "s#(R[0-9].*[0-9])#\1 Build ${date_version} By Cheng #g" zzz-default-settings
popd