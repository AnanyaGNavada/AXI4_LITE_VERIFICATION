class axi4_lite_passive_agent extends uvm_agent;
`uvm_component_utils(axi4_lite_passive_agent)
axi4_lite_out_monitor out_mon;
function new(string name="axi4_lite_passive_agent", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(get_is_active==UVM_PASSIVE) begin
		out_mon=axi4_lite_out_monitor::type_id::create("out_mon",this);
	end
endfunction
endclass
