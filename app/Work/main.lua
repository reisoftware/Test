_ENV=module_seeall(...,package.seeall)

function on_load()
	_G.package.loaded["app.Work.function"] = nil;
	require"app.Work.function".load();
end

function on_init()
end

