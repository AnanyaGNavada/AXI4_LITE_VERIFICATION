class axi4_lite_active_agent extends uvm_agent;
`uvm_component_utils(axi4_lite_active_agent)
axi4_lite_driver drv;
axi4_lite_seqr seqr;
axi4_lite_inp_monitor inp_mon;
function new(string name="axi4_lite_active_agent", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	inp_mon=axi4_lite_inp_monitor::type_id::create("inp_mon",this);
	if(get_is_active==UVM_ACTIVE) begin
		drv=axi4_lite_driver::type_id::create("drv",this);
		seqr=axi4_lite_seqr::type_id::create("seqr",this);
	end
endfunction
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	//if(get_is_active==UVM_ACTIVE) begin
		drv.seq_item_port.connect(seqr.seq_item_export);
	//end
endfunction
endclass
