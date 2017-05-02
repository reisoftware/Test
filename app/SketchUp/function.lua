--module(...,package.seeall)
local print = print
 _ENV = module_seeall(...,package.seeall)


function open_sketchup(sc)
	-- sc = sc or require"sys.mgr".new_scene();
	sc = sc or require"sys.mgr".new_scene();
	local file = require"app.sketchup.iupex".open_file_dlg("*");

	-- print('file = ' .. file)
	-- dofile(file)
	-- print(skp_model)
	-- require 'sys.table'.tofile{src = skp_model,tip = 'skp_model',file = file}
	require"app.sketchup.import".open_model(file);
	
end
function load()
	require"sys.menu".add{frame=true,view=true,app="sketchup",name={"File","Import","sketchup"},pos={"File","Close"},f=open_sketchup};
end
