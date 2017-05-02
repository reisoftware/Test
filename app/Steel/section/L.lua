--wky 2015��4��24��13:55:08
_ENV=module_seeall(...,package.seeall)

local geo_ = require "sys.geometry"

local function get_section(szs,offset)
	if not szs[1] or not szs[2] or not szs[3]  then return require"app.Steel.section.default".get_section() end;
	offset = offset or {};
	local x = (offset.x or offset.h or offset[1] or 0)*szs[2];
	local y = (offset.y or offset.v or offset[2] or 0)*szs[1];
	
	local outer = {};
	table.insert(outer,geo_.Point:new{x-szs[2]/2, y+szs[1]/2});
	table.insert(outer,geo_.Point:new{x-szs[2]/2, y-szs[1]/2});
	table.insert(outer,geo_.Point:new{x+szs[2]/2, y-szs[1]/2});
	table.insert(outer,geo_.Point:new{x+szs[2]/2, y-szs[1]/2+szs[3]});
	table.insert(outer,geo_.Point:new{x-szs[2]/2+szs[3], y-szs[1]/2+szs[3]});
	table.insert(outer,geo_.Point:new{x-szs[2]/2+szs[3], y+szs[1]/2});
	return outer;
end

require"app.Steel.section".add_type("L",get_section);
require"app.Steel.section".add_type("BLL",get_section);