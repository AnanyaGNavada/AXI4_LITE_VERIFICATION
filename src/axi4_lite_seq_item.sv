class axi4_lite_seq_item extends uvm_sequence_item;
rand bit [`ADDR_WIDTH-1:0] AWADDR, ARADDR;
rand bit [`DEFAULT_PROT-1:0] AWPROT, ARPROT;
rand bit AWVALID,  WVALID, BREADY, ARVALID, RREADY;
rand bit [(`DATA_WIDTH/8)-1:0] WSTRB;
rand bit [`DATA_WIDTH-1:0] WDATA;
rand bit write, read;
  rand bit [2:0] d1, d2;
bit AWREADY, WREADY, BVALID, ARREADY, RVALID;
bit [`DATA_WIDTH-1:0] RDATA;
bit [1:0] BRESP, RRESP;
  
//constraint c0 {AWADDR[1:0] ==2'b00; ARADDR[1:0] ==2'b00;}
`uvm_object_utils_begin(axi4_lite_seq_item)
`uvm_field_int(AWADDR, UVM_ALL_ON)
  `uvm_field_int(write, UVM_ALL_ON)
  `uvm_field_int(read, UVM_ALL_ON)
`uvm_field_int(ARADDR, UVM_ALL_ON)
`uvm_field_int(AWPROT, UVM_ALL_ON)
`uvm_field_int(ARPROT, UVM_ALL_ON)
`uvm_field_int(BREADY, UVM_ALL_ON)
`uvm_field_int(AWVALID, UVM_ALL_ON)
`uvm_field_int(WVALID, UVM_ALL_ON)
`uvm_field_int(ARVALID, UVM_ALL_ON)
`uvm_field_int(RREADY, UVM_ALL_ON)
`uvm_field_int(WSTRB, UVM_ALL_ON)
`uvm_field_int(WDATA, UVM_ALL_ON)
`uvm_field_int(AWREADY, UVM_ALL_ON)
`uvm_field_int(WREADY, UVM_ALL_ON)
`uvm_field_int(BVALID, UVM_ALL_ON)
`uvm_field_int(ARREADY, UVM_ALL_ON)
`uvm_field_int(RVALID, UVM_ALL_ON)
`uvm_field_int(RDATA, UVM_ALL_ON)
`uvm_field_int(BRESP, UVM_ALL_ON)
`uvm_field_int(RRESP, UVM_ALL_ON)
`uvm_object_utils_end
function new(string name = "axi4_lite_seq_item");
	super.new(name);
endfunction
endclass
