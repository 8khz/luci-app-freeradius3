local m, s, o
local sys = require "luci.sys"
require "ubus"

m = Map("radius", translate("Radius - Users"), translate("User Accounts."))
m.on_after_commit = function() luci.sys.call("/usr/lib/radius.sh rebuild") end

s = m:section(TypedSection, "user", nil)
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

o = s:option(Value, "username", translate("Username"))
o.datatype = "uciname"
o.rmempty = false

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty = false

return m
