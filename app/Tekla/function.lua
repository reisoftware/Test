--module(...,package.seeall)
 _ENV = module_seeall(...,package.seeall)

function open_tekla(sc)
--[[
	require "app.Tekla.dlg_import_tekla".pop();
	local version = require "app.Tekla.dlg_import_tekla".return_select_tekla_version();
	
	trace_out(version .. "\n");
	if(version == "Tekla 17.0") then
		os.execute("app\\Tekla\\soft\\TeklaIO_17.0\\TeklaIO.exe");
	elseif(version == "Tekla 18.0")	then	
		os.execute("app\\Tekla\\soft\\TeklaIO_18.0\\TeklaIO.exe");
	elseif(version == "Tekla 19.0")	then	
		os.execute("app\\Tekla\\soft\\TeklaIO_19.0\\TeklaIO.exe");
	end
	]]--
	os.execute("app\\Tekla\\soft\\TeklaIO_19.0\\TeklaIO.exe");
	-- sc = require"sys.mgr".new_scene();	
	
	--local file = require"app.Tekla.iupex".open_file_dlg("*");
	local file = "model.lua";
	require"app.Tekla.import".open_model(file);
	for i=1,123456 do
-- require'sys.str'.totrace(i);
	end
	-- require"app.Model.function".Rendering();
	require'sys.statusbar'.update();
end
function open_tekla_file(sc)
	-- sc = sc or require"sys.mgr".new_scene();
	local file = require"app.Tekla.iupex".open_file_dlg("*");
	
	require"app.Tekla.import".open_model(file);
end
function load()
	require"sys.menu".add{frame=true,view=true,app="Tekla",name={"File","Import","Tekla"},pos={"File","Close"},f=open_tekla};
	require"sys.menu".add{frame=true,view=true,app="Tekla",name={"File","Import","Tekla from file"},pos={"File","Close"},f=open_tekla_file};
end
