_ENV = module_seeall(...,package.seeall)


local function Convert()
	local path_ = 'app.Convert.'
	local dlg_ = require (path_ .. 'dlg')
	local op_ = require (path_ .. 'op')
	op_.init()
	dlg_.pop{
		init_txt =  op_.init_txt;
		on_src =  op_.on_src;
		on_dst = op_.on_dst;
		on_ok =  op_.on_ok;
	}
end
 
function on_load()
	require"sys.menu".add{frame=true,view=true,app="Convert",name={"Tools","Convert"},pos={"Tools","Develop"},f=Convert};
end