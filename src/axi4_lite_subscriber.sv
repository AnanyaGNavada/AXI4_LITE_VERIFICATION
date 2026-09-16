class axi4_lite_subscriber extends uvm_subscriber #(axi4_lite_seq_item);
`uvm_component_utils(axi4_lite_subscriber)
axi4_lite_seq_item sub;
covergroup axi4_lite_cg;
awaddr_cp : coverpoint sub.AWADDR {
	bins aw1 ={[32'h0:32'h24]};
	 bins aw2 = {[32'h28:32'h30]};
	 bins aw3 = {[32'h34:32'h3C]};
}
  wstrb_cp:coverpoint sub.WSTRB{
    bins strb[]={4'b0000,4'b0001,4'b0010,4'b0100,4'b1000,4'b0011,4'b1100,4'b1111}; 
  }
/*awready_cp : coverpoint sub.AWREADY {
	bins awr_low={0};
	bins awr_high ={1};
}*/
wdata_cp : coverpoint sub.WDATA {
	bins wd1={[32'h0:32'h55555554]};
	bins wd2 = {[32'h55555555:32'hAAAAAAA9]};
	bins wd3 = {[32'hAAAAAAAA:32'hFFFFFFFF]};
}
/*wready_cp : coverpoint sub.WREADY {
	bins wr_low={0};
	bins wr_high ={1};
}*/

araddr_cp :coverpoint sub.ARADDR {
	bins ar1 ={[32'h0:32'h24]};
	 bins ar2 = {[32'h28:32'h30]};
	 bins ar3 = {[32'h34:32'h3C]};
}

endgroup
function new(string name ="axi4_lite_subscriber", uvm_component parent);
	super.new(name,parent);
	axi4_lite_cg=new();
endfunction
virtual function void write (axi4_lite_seq_item t);
	sub=t;
	axi4_lite_cg.sample();
`uvm_info(get_name(),$sformatf("INPUT COVERAGE = %0.2f %%", axi4_lite_cg.get_coverage()),UVM_NONE) 
endfunction
endclass
