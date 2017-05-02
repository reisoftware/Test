_ENV=module_seeall(...,package.seeall)

local function export_items(its)
	local str = require'sys.iup'.save_file_dlg{extension="LUA";directory="C:\\";};
	if not str or str=="" then return end
	if type(its)~='table' then return end
	-- require'sys.table'.tofile{src=its,file=str}
	require'app.Contacts.File.file_op'.save_table_to_file(str,its);
end

local function import_items(sc)
	sc = require'sys.mgr'.new_scene{name='Import'};
	local str = require'sys.iup'.open_file_dlg{extension="LUA";directory="C:\\";};
	if not str or str=="" then return end
	local its = require'sys.io'.read_file{file=str,key='db'};
	if type(its)~='table' then return end
	for k,v in pairs(its) do
		require'sys.mgr'.add(v);
		require'sys.mgr'.draw(v,sc);
	end
	require'sys.mgr'.update(sc);
end

function Import_Lua(sc)
	import_items(sc);
end

function Export_Lua(sc)
	export_items(require'sys.mgr'.curs());
end

function Export_All(sc)
	export_items(require'sys.mgr'.get_all());
end

function Link_Show(sc)
	require'app.Work.link_dlg'.pop();
end

local function is_link(str,f)
end

local function is_link(it,f)
end

function Link_Find(sc)
	local str = require'sys.iup'.open_file_dlg{extension='LUA';directory='C:\\';}
	if not str or str=='' then return end
	str = string.sub(str,1,-5);
	_G.package.loaded[str] = nil;
	local f = require(str);
	
	local all = require"sys.mgr".get_class_all(require"app.Work.Link".Class);
	if type(all)~='table' then return end
	
	for k,v in pairs(all) do
		if type(v.src)=='string' and string.sub(v.src,-4,-1)=='.LUA' then
			local str = string.sub(v.src,1,-5);
			_G.package.loaded[str] = nil;
			local t = require(str);
			if f(t) then
				local it = require'sys.mgr'.get_table(v.dstid);
				require'sys.mgr'.select(it,true);
				require'sys.mgr'.redraw(it);
			end
		end
	end
	require'sys.mgr'.update(sc);
end

function load()
	require"sys.menu".add{app="Work",frame=true,view=true,pos={"File","Close"},name={"File","Import","LUA"},f=Import_Lua};
	require"sys.menu".add{app="Work",frame=true,view=true,pos={"File","Close"},name={"File","Export","LUA"},f=Export_Lua};
	require"sys.menu".add{app="Work",view=true,pos={"Windows"},name={"Model","Link","Show",},f=Link_Show};
	require"sys.menu".add{app="Work",view=true,pos={"Windows"},name={"Model","Link","Find",},f=Link_Find};
end
