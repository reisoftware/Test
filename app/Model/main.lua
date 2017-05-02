_ENV=module_seeall(...,package.seeall)


local function add_all_group()
	local smd = require'sys.Group'.Class:new{Name="All"};
	smd:add_model_all();
	require'sys.mgr'.add(smd);
end

function on_load()
	require"app.Model.function".load();
end

function on_init()
	-- require"app.Model.submodel_page".pop();
	-- add_all_group();
end

