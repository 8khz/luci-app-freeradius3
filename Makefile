include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-freeradius3
PKG_VERSION:=0.2
PKG_RELEASE:=1
PKG_MAINTAINER:=Jason Tse <jasontsecode@gmail.com>
PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include ../../luci.mk

LUCI_TITLE:=Freeradius3 LuCI Interface
LUCI_DEPENDS:=+luci-mod-admin-full

define Package/luci-app-freeradius3
   SECTION:=luci
   CATEGORY:=LuCI
   TITLE:=Radius Server Management
   MAINTAINER:=Jason Tse <jasontsecode@gmail.com>
   PKGARCH:=all
endef

define Package/luci-app-freeradius3/description
Radius Server Management
endef

define Package/luci-app-freeradius3/conffiles
/etc/config/radius
endef

define Package/luci-app-freeradius3/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/config/radius $(1)/etc/config/radius
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/uci-defaults/luci-radius $(1)/etc/uci-defaults/luci-radius
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/controller/radius.lua $(1)/usr/lib/lua/luci/controller/radius.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/radius
	$(INSTALL_DATA) ./files/cbi/clients.lua $(1)/usr/lib/lua/luci/model/cbi/radius/clients.lua
	$(INSTALL_DATA) ./files/cbi/users.lua $(1)/usr/lib/lua/luci/model/cbi/radius/users.lua
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) ./files/lib/radius.sh $(1)/usr/lib/radius.sh
endef

define Package/luci-app-freeradius3/postinst
#!/bin/sh
[ ! -z "$${IPKG_INSTROOT}" ] && exit 0
. /etc/uci-defaults/luci-radius
rm -f /etc/uci-defaults/luci-radius
endef

define Build/Compile
endef

$(eval $(call BuildPackage,luci-app-freeradius3))
