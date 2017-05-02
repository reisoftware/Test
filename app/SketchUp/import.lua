--module(...,package.seeall)
 _ENV = module_seeall(...,package.seeall)
local units = {
	mm = 1;
	m = 1000;
	km=1000000;
}
local points_ = {}
local faces_ = {}
local edges_ = {}

local function turn_points(data)
	local points = {}
	for k,v in ipairs (data) do 
		local t = points_[v]
		if not t then return false end 
		table.insert(points,t)
	end 
	return points
end 

local nums = 0
local function deal_add_face(data)
	local obj = require 'app.sketchup.objects.object'.Class:new{Type="SketchUpObject"}
	local points = turn_points(data)
	if not points then nums = nums+1 print('no points ! nums = ',nums) return end 
	obj:set_points(points)
	obj:set_loop(data.outer,data.inners)
	obj:set_mode_rendering()
	require 'sys.mgr'.add(obj)
	require"sys.mgr".draw(obj,sc)
end 


local function init()
	points_ = {}
	faces_ = {}
	-- edges_= {}
end 

--arg = {vertices,line,to_s}
local function Edge(arg)
	if type(arg) ~= 'table' then return end 
	if not arg.vertices or not arg.line then return end 
	local key = string.match(arg.vertices,'Vertex:([^%>]+)')
	
	if not points_[key] then 
		local str = string.sub(string.match(arg.line,'%b()'),2,-2)
		points_[key] ={x = tonumber(string.match(str,'[^,]+'))*unit,y = tonumber(string.match(str,',([^,]+),'))*unit,z = tonumber(string.match(str,'.+,([^,]+)'))*unit}
	end 
end

local function deal_pt(ptstr)
	local x = string.match(ptstr,'[^(^)^,]+')
	local y = string.match(ptstr,',([^,]+),')
	local z = string.match(ptstr,'.+,([^(^)^,]+)')
	local unit = string.match(x,'([^%d^%.]+)')
	unit = units[unit]
	x,y,z= tonumber(string.match(x,'[%d%.]+'))*unit,tonumber(string.match(y,'[%d%.]+'))*unit,tonumber(string.match(z,'[%d%.]+'))*unit
	return {x = x,y=y,z=z}
end 

--arg = {vertices = {"","",}}
local function Face(arg)
	if type(arg) ~= 'table' then return end 
	if not arg.loops then return end 
	local t = {}
	t.outer = {}
	t.inners = {}
	for k,v in ipairs(arg.loops) do 
		local temp ;
		if v.isouter == 'true' then
			temp = t.outer
		else 
			local  pos= #t.inners+1
			t.inners[pos] = {}
			temp = t.inners[pos] 
		end 
		for m,n in ipairs(v) do 
			local str = n.key
			str = string.match(str,'Vertex:([^%>]+)')
			if not points_[str] then points_[str] =  deal_pt(n.pt) end 
			table.insert(t,str)
			table.insert(temp,#t)
		end 
		
	end 
	table.insert(faces_,t)
end

function open_model(file)	
	init()
	local times = {}
	local time1 = os.time()
	local info = {}
	local func = loadfile(file,"bt",info)
	info.Edge = Edge
	info.Face = Face
	if func then 
		func()
	end
	local time2 = os.time()
	times.loadfiletime = time2 - time1
	print("loadfiletime = ",times.loadfiletime)
	for k,v in ipairs (faces_) do 
		deal_add_face(v)
	end 
	require"sys.mgr".update();	
	local time3 = os.time()
	times.totaltime = time3 - time1
	print("totaltime = ",times.totaltime)
end








