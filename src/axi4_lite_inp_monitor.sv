class axi4_lite_inp_monitor extends uvm_monitor;
`uvm_component_utils(axi4_lite_inp_monitor)
virtual axi4_lite_inp_monitor.inp_mon vif;
axi4_lite_seq_item ims;
uvm_analysis_port #(axi_lite_seq_item) inp_mon_port;

function new(string name="axi4_lite_inp_monitor", uvm_component parent);
	super.new(name,parent);
	inp_mon_port=new("inp_mon_port",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface) ::get(this, "", "vif", vif))
	`uvm_fatal(get_type_name(), "Input Monitor get failed")
endfunction

task run_phase(uvm_phase phase);
	forever begin
		ims=axi4_lite_seq_item::type_id::create("ims");
		if(vif.AWVALID || vif.WVALID) begin
		fork
			begin
				do @(vif.inp_mon_cb);
   				while(!(vif.AWVALID && vif.AWREADY));
				ims.AWADDR=vif.AWADDR;
				ims.AWPROT=vif.AWPROT;
			end
			begin
				 do @(vif.inp_mon_cb);
    				while(!(vif.WVALID && vif.WREADY));
				ims.WDATA=vif.WDATA;
				ims.WSTRB=vif.WSTRB;
			end
		join_none
		end
		if(vif.ARREADY && vif.ARVALID) begin
			ims.ARADDR=vif.ARADDR;
			ims.ARPROT=vif.ARPROT;
			
		end
		//wait fork;
		inp_mon_port.write(ims);
	end
endtask
endclass
