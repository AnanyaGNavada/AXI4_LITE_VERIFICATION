class axi4_lite_out_monitor extends uvm_monitor;
`uvm_component_utils(axi4_lite_out_monitor)
virtual axi4_lite_interface.out_mon vif;
axi4_lite_seq_item oms;
uvm_analysis_port #(axi4_lite_seq_item) out_mon_port;
function new(string name = "axi4_lite_out_monitor", uvm_component parent);
	super.new(name,parent);
	out_mon_port=new("out_mon_port",this);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface)::get(this, "", "vif", vif))
	`uvm_fatal(get_type_name(),"Output monitor get failed")
endfunction
task run_phase(uvm_phase phase);
	forever begin
		oms=axi4_lite_seq_item::type_id::create("oms");
		@(vif.out_mon_cb);
		if(vif.BREADY && vif.BVALID) begin
			oms.BRESP=vif.BRESP;
		end
		if(vif.RVALID && vif.RREADY) begin
			oms.RDATA=vif.RDATA;
			oms.RRESP=vif.RRESP;
		end
		out_mon_port.write(oms);
	end
endtask
endclass
