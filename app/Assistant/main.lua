_ENV=module_seeall(...,package.seeall)

function on_load()
	_G.package.loaded["app.Assistant.function"] = nil;
	require"app.Assistant.function".load();
end

function on_init()
end

