_ENV=module_seeall(...,package.seeall)

function on_load()
	_G.package.loaded["app.Wise.function"] = nil;
	require"app.Wise.function".load();
end

function on_init()
end

