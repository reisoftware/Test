--module(...,package.seeall)
local print = print
 _ENV = module_seeall(...,package.seeall)


function open_revit(sc)
	-- sc = sc or require"sys.mgr".new_scene();
	sc = sc or require"sys.mgr".new_scene();
	local file = require"app.Revit.iupex".open_file_dlg("*");
	-- print('file = ' .. file)
	-- dofile(file)
	-- print(revit_model)
	-- require 'sys.table'.tofile{src = revit_model,tip = 'revit_model',file = file}
	require"app.Revit.import".open_model(file);
	
end
function load()
	require"sys.menu".add{frame=true,view=true,app="Revit",name={"File","Import","Revit"},pos={"File","Close"},f=open_revit};
end
