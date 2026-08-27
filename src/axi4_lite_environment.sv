class axi4_lite_environment extends uvm_env;
`uvm_component_utils(axi4_lite_environment)
axi4_lite_active_agent aa;
axi4_lite_passive_agent pa;
axi4_lite_scoreboard scb;
axi4_lite_subscriber sb;
function new(string name= "axi4_lite_environment",uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db #(uvm_active_passive_enum) :: set(this,"aa", "is_active", UVM_ACTIVE)
	uvm_config_db #(uvm_active_passive_enum) :: set(this,"pa", "is_active", UVM_PASSIVE)
	aa=axi4_lite_active_agent::type_id::create("aa",this);
	pa=axi4_lite_passive_agent::type_id::create("pa",this);
	scb=axi4_lite_scoreboard::type_id::create("scb",this);
	sb=axi4_lite_subscriber::type_id::create("sb",this);
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	aa.inp_mon.inp_mon_port.connect(scb.inp_port.analysis_export);
	pa.out_mon.out_mon_port.connect(scb.out_port.analysis_export);
	aa.inp_mon.inp_mon_port.connect(sb.analysis_export);
endfunction
endclass
