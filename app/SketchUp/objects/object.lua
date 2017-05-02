
 _ENV = module_seeall(...,package.seeall)


Class = {}

Class = {
	Classname = "app/SketchUp/objects/Object";
	-- Points = {[1],[2]};
	-- Color = {255,255,255};
};

require"sys.Entity".Class:met(Class);


function Class:set_points(points)
	self.points = points
end


function Class:set_loop(outer,inners)
	self.face_outer = outer
	self.face_inners = inners
end




function Class:init_lines_surfaces(surfaces)
	local surfaces = surfaces or {}
	local rl,gl,bl,m,n = 1,1,1,0,0 --线的rgb
	local rf,gf,bf,m,n = 1,0,0,0,0 --面的rgb
	local surface = {}
	surface.points = {}
	surface.lines = {}
	for k,v in ipairs(self.points) do 
		table.insert(surface.points,{ rl,gl,bl,m,n,v.x,v.y,v.z})
	end
	for k,v in ipairs (self.face_outer) do 
		if  k~= #self.face_outer then 
			table.insert(surface.lines,{self.face_outer[k],self.face_outer[k+1]})
		else 
			table.insert(surface.lines,{self.face_outer[k],self.face_outer[1]})
		end 
	end 
	for k,v in ipairs (self.face_inners) do 
		for m,n in ipairs(v) do 
			if  m~= #v then 
				table.insert(surface.lines,{v[m],v[m+1]})
			else 
				table.insert(surface.lines,{v[m],v[1]})
			end 
		end 
	end 
	table.insert(surfaces,surface)
	return surfaces
end 


function Class:init_surfaces()
	local rf,gf,bf,m,n = 1,0,0,0,0 --面的rgb
	local surfaces = {}
	local surface = {}
	surface.points = {}
	surface.outer = {}
	for k,v in ipairs(self.points) do 
		table.insert(surface.points,{ rf,gf,bf,m,n,v.x,v.y,v.z})
		-- table.insert(surface.outer,k)
	end
	surface.outer = self.face_outer
	surface.inners = self.face_inners
	table.insert(surfaces,surface)
	self:init_lines_surfaces(surfaces)
	return surfaces
end

function Class:on_draw_rendering()
	if type(self.points) ~= 'table' then return end 
	local obj = {}
	obj.surfaces = self:init_surfaces() or {}
	self:set_shape_rendering(obj)
end

function Class:on_draw_diagram()
	if type(self.points) ~= 'table' then return end 
	local obj = {}
	obj.surfaces = self:init_lines_surfaces() or {}
	self:set_shape_diagram(obj)
end