_ENV=module_seeall(...,package.seeall)


local function Add(sc)
	require"app.WDF.add_dlg".pop(sc);
end

function load()
	require"sys.menu".add{frame=true,view=true,app="WDF",pos={"Window"},name={"WDF","Add"},f=Add};
end
