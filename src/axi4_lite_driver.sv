class axi4_lite_driver extends uvm_driver #(axi4_lite_seq_item);
`uvm_component_utils(axi4_lite_driver)
axi4_lite_seq_item ds;
virtual axi4_lite_interface.drv vif;
function new(string name = "axi4_lite_driver", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface.drv) ::get(this, "", "vif",vif))
	`uvm_fatal(get_type_name(), "Driver get failed")
endfunction
task run_phase(uvm_phase phase);
  forever begin
		ds=axi4_lite_seq_item::type_id::create("ds");
		seq_item_port.get_next_item(ds);
		if(ds.write) begin
			fork
              begin 
               repeat(ds.d1) @(vif.drv_cb);
 				aw_channel(ds);
              end
              begin
                repeat(ds.d2) @(vif.drv_cb);
				w_channel(ds);
              end
			join
			b_channel(ds);
		end
		if(ds.read) begin
			ar_channel(ds);
			r_channel(ds);
		end
    `uvm_info("DRV", $sformatf("awaddr = %h wdata = %h wstrb = %h araddr = %h", ds.AWADDR, ds.WDATA, ds.WSTRB, ds.ARADDR), UVM_NONE)
		seq_item_port.item_done();
	end
endtask

task aw_channel (axi4_lite_seq_item aw_s);
	vif.drv_cb.AWVALID<=1;
	vif.drv_cb.AWPROT<=aw_s.AWPROT;
	vif.drv_cb.AWADDR<=aw_s.AWADDR;
  do @(vif.drv_cb);
  while (!vif.drv_cb.AWREADY);
	vif.drv_cb.AWVALID<=0;
endtask

task w_channel (axi4_lite_seq_item w_s);
	vif.drv_cb.WDATA<=w_s.WDATA;
	vif.drv_cb.WSTRB<=w_s.WSTRB;
	vif.drv_cb.WVALID<=1;
  do @(vif.drv_cb);
  while (!vif.drv_cb.WREADY);
	vif.drv_cb.WVALID<=0;
endtask

task b_channel (axi4_lite_seq_item b_s);
	vif.drv_cb.BREADY<=1;
  do @(vif.drv_cb);
  while (!vif.drv_cb.BVALID);
	vif.drv_cb.BREADY<=0;
endtask

task ar_channel (axi4_lite_seq_item ar_s);
	vif.drv_cb.ARADDR<=ar_s.ARADDR;
	vif.drv_cb.ARPROT<=ar_s.ARPROT;
	vif.drv_cb.ARVALID<=1;
  do @(vif.drv_cb);
  while (!vif.drv_cb.ARREADY);
	vif.drv_cb.ARVALID<=0;
endtask

task r_channel(axi4_lite_seq_item r_s);
	vif.drv_cb.RREADY<=1;
  do @(vif.drv_cb);
  while (!vif.drv_cb.RVALID);
	vif.drv_cb.RREADY<=0;
endtask

endclass
