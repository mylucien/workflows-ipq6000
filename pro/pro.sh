#/bin/bash

sudo apt update
sudo apt install make -y
git clone -b master --single-branch https://github.com/sdf8057/ipq6000.git openwrt
cd openwrt
./scripts/feeds update -a
svn co https://github.com/coolsnowwolf/packages/trunk/net/n2n feeds/packages/net/n2n
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-n2n feeds/luci/applications/luci-app-n2n
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/other-plugins/luci-app-adguardhome
#优先安装 passwall 源
./scripts/feeds install -a -f -p passwall_packages
./scripts/feeds install -a -f -p passwall_luci
./scripts/feeds install -a
# ttyd免登陆
sed -i -r 's#/bin/login#/bin/login -f root#g' feeds/packages/utils/ttyd/files/ttyd.config
# design修改proxy链接
sed -i -r "s#navbar_proxy = 'openclash'#navbar_proxy = 'passwall'#g" feeds/luci/themes/luci-theme-design/luasrc/view/themes/design/header.htm
wget https://raw.githubusercontent.com/ppayjjk/ipq6000/main/pro/.config
make menuconfig
