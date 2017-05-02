_ENV=module_seeall(...,package.seeall)

function property(sc)
	require"sys.mgr".edit_property(sc);
end

function copy(sc)
	require"sys.cmd".set{command=require"app.Edit.Move".new{copy=true}};
end

function move(sc)
	require"sys.cmd".set{command=require"app.Edit.Move".new()};
end

function del(sc)
	require"sys.mgr".del_curs();
	-- local ents = require"sys.mgr".curs()
	-- for k,v in pairs(ents) do
		-- require"sys.mgr".del(v);
		-- require"sys.mgr".draw(v);
	-- end
	require"sys.mgr".update();
end


function load()
	require"sys.menu".add{name={"Edit"},pos={"Window"}};
	require"sys.menu".add{view=true,name={"Edit","Property"},f=property};
	require"sys.menu".add{view=true,name={"Edit","Copy"},f=copy};
	require"sys.menu".add{view=true,name={"Edit","Move"},f=move};
	require"sys.menu".add{view=true,name={"Edit","Delete"},f=del};
	require"sys.msg.keydown".set{key=require"sys.api.ascii".Del(),f=del};
end

