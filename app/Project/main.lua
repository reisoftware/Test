_ENV=module_seeall(...,package.seeall)


function on_load()
	require"app.Project.function".load();
end

function on_init()
	require"app.Project.function".init();
end

function on_esc()
end
