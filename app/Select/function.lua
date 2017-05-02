_ENV=module_seeall(...,package.seeall)

function select_everything(sc)
	require"sys.cmd".set_select(sc);
end

function all(sc)
	require"sys.mgr".select_all{scene=sc,redraw=true};
	require"sys.mgr".update();
	require"sys.statusbar".show_selection_count();
end

function cancel(sc)
	require"sys.mgr".select_none{scene=sc,redraw=true};
	require"sys.mgr".update();
	require"sys.statusbar".show_selection_count();
end

function reverse(sc)
	require"sys.mgr".select_reverse{scene=sc,redraw=true};
	require"sys.mgr".update();
	require"sys.statusbar".show_selection_count();
end


function load()
	require"sys.menu".add{view=true,pos={"Window"},name={"Select","Cursor"},f=select_everything};
	require"sys.menu".add{view=true,pos={"Window"},name={"Select","All"},f=all};
	require"sys.menu".add{view=true,pos={"Window"},name={"Select","Cancel"},f=cancel};
	require"sys.menu".add{view=true,pos={"Window"},name={"Select","Reverse"},f=reverse};

	require"sys.msg.keydown".set{require"sys.msg.keydown".Ctrl(),key=string.byte('A'),f=all};
end

