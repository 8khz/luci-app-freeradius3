local m, s, o
local sys = require "luci.sys"
require "ubus"

m = Map("radius", translate("Radius - Clients"), translate("Radius Clients."))
m.apply_on_parse = true

function m.on_after_save(self)
	sys.call("/usr/lib/radius.sh rebuild") 
end

s = m:section(TypedSection, "client", nil)
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

o = s:option(Value, "name", translate("Short Name"))
o.datatype = "uciname"
o.rmempty = false

o = s:option(Value, "ipaddr", translate("IP Address"))
o.datatype = "ipaddr"
o.rmempty = false

o = s:option(Value, "secret", translate("Secret"))
o.password = true
o.rmempty = false

return m
