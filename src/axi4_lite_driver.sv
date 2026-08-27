class axi4_lite_driver extends uvm_driver #(axi4_lite_seq_item);
`uvm_component_utils(axi4_lite_driver)
axi4_lite_seq_item ds;
virtual axi4_lite_interface.drv vif;
function new(string name = "axi4_lite_driver", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface) ::get(this,"", "vif",vif))
	`uvm_fatal(get_type_name(), "Driver get failed")
endfunction
task run_phase(uvm_phase phase);
	forever begin
		ds=axi4_lite_seq_item::type_id::create("ds");
		seq_item_port.get_next_item(ds);
		@(vif.drv_cb);
		if(ds.write) begin
			fork
				aw_channel(ds);
				w_channel(ds);
			join
			b_channel(ds);
		end
		if(ds.read) begin
			ar_channel(ds);
			r_channel(ds);
		end
		seq_item_port.item_done();
	end
endtask

task aw_channel (axi4_lite_seq_item aw_s);
	vif.AWVALID<=1;
	vif.AWPROT<=aw_s.AWPROT;
	vif.AWADDR<=aw_s.AWADDR;
	wait(vif.AWREADY);
	@(vif.drv_cb);
	vif.AWVALID<=0;
endtask

task w_channel (axi4_lite_seq_item w_s);
	vif.WDATA<=w_s.WDATA;
	vif.WSTRB<=w_s.WSTRB;
	vif.WVALID<=1;
	wait(vif.WREADY);
	@(vif.drv_cb);
	vif.WVALID<=0;
endtask

task b_channel (axi4_lite_seq_item b_s);
	vif.BREADY<=1;
	wait(vif.BVALID);
	@(vif.drv_cb);
	vif.BREADY<=0;
endtask

task ar_channel (axi4_lite_seq_item ar_s);
	vif.ARADDR<=ar_s.ARADDR;
	vif.ARPROT<=ar_s.ARPROT;
	vif.ARVALID<=ar_s.ARVALID;
	wait(vif.ARREADY);
	@(vif.drv_cb);
	vif.ARVALID<=0;
endtask

task r_channel(axi4_lite_seq_item r_s);
	vif.RREADY<=1;
	wait(vif.RVALID);
	@(vif.drv_cb);
	vif.RREADY<=0;
endtask

endclass
