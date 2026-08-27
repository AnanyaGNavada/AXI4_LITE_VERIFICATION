class axi4_lite_test extends uvm_test;
`uvm_component_utils(axi4_lite_test)
axi4_lite_environment env;
axi4_lite_seq seq;
function new(string name = "axi4_lite_test", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=axi4_lite_environment::type_id::create("env",this);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction
task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq=axi4_lite_seq::type_id::create("seq");
	seq.start(env.aa.seqr);
	phase.drop_objection(this);
	`uvm_info(get_type_name(),"Testcases completed",UVM_MEDIUM)
endtask
endclass
