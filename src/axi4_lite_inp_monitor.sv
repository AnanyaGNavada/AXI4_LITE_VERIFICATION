class axi4_lite_inp_monitor extends uvm_monitor;
`uvm_component_utils(axi4_lite_inp_monitor)
virtual axi4_lite_interface.inp_mon vif;
axi4_lite_seq_item ims;
uvm_analysis_port #(axi4_lite_seq_item) inp_mon_port;

function new(string name="axi4_lite_inp_monitor", uvm_component parent);
	super.new(name,parent);
	inp_mon_port=new("inp_mon_port",this);
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface.inp_mon) ::get(this, "", "vif", vif))
	`uvm_fatal(get_type_name(), "Input Monitor get failed")
endfunction

task run_phase(uvm_phase phase);
  bit aw, w;
   		ims=axi4_lite_seq_item::type_id::create("ims");
  forever begin
    @(vif.inp_mon_cb);
    if(vif.inp_mon_cb.AWVALID && vif.inp_mon_cb.AWREADY) begin
      ims.AWADDR = vif.inp_mon_cb.AWADDR;
      ims.AWPROT = vif.inp_mon_cb.AWPROT;
      aw=1;
    end
    if(vif.inp_mon_cb.WVALID && vif.inp_mon_cb.WREADY) begin
      ims.WDATA = vif.inp_mon_cb.WDATA;
      ims.WSTRB = vif.inp_mon_cb.WSTRB;
      w=1;
    end
    if (vif.inp_mon_cb.ARVALID && vif.inp_mon_cb.ARREADY) begin
      ims.ARADDR = vif.inp_mon_cb.ARADDR;
      ims.ARPROT = vif.inp_mon_cb.ARPROT;
      ims.read=1;
      inp_mon_port.write(ims);
      `uvm_info("INPUT MONITOR", $sformatf("READ araddr=%h", ims.ARADDR), UVM_NONE)
      ims = axi4_lite_seq_item::type_id::create("ims");
    end
    if(aw && w) begin
      ims.write=1;
 		inp_mon_port.write(ims);
      `uvm_info("INPUT MONITOR", $sformatf(" WRITE awaddr=%h wdata=%h wstrb=%b ", ims.AWADDR, ims.WDATA, ims.WSTRB), UVM_NONE)
      ims = axi4_lite_seq_item::type_id::create("ims");
      w=0;
      aw=0;
    end  
 	end
endtask
endclass
