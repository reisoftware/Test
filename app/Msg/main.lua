_ENV=module_seeall(...,package.seeall)

function on_load()
	_G.package.loaded["app.Msg.function"] = nil;
	require"app.Msg.function".load();
end

function on_init()
end

