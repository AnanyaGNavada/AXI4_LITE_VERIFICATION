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
	if(!uvm_config_db #(virtual axi4_lite_interface.out_mon)::get(this, "", "vif", vif))
	`uvm_fatal(get_type_name(),"Output monitor get failed")
endfunction
task run_phase(uvm_phase phase);
  forever begin
		oms=axi4_lite_seq_item::type_id::create("oms");
		@(vif.out_mon_cb);
		if(vif.out_mon_cb.BREADY && vif.out_mon_cb.BVALID) begin
			oms.BRESP=vif.out_mon_cb.BRESP;
		end
		if(vif.out_mon_cb.RVALID && vif.out_mon_cb.RREADY) begin
			oms.RDATA=vif.out_mon_cb.RDATA;
			oms.RRESP=vif.out_mon_cb.RRESP;
		end
    if((vif.out_mon_cb.BREADY && vif.out_mon_cb.BVALID)||(vif.out_mon_cb.RVALID && vif.out_mon_cb.RREADY))begin
      out_mon_port.write(oms);
      `uvm_info("OUTPUT MONITOR", $sformatf("BRESP = %h RRESP = %h RDATA = %h", oms.BRESP,oms.RRESP, oms.RDATA ), UVM_NONE)
      end
	end
endtask
endclass
