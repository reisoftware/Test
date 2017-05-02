_ENV=module_seeall(...,package.seeall)

function on_load()
	_G.package.loaded["app.Snap.function"] = nil;
	require"app.Snap.function".load();
end

function on_init()
end

