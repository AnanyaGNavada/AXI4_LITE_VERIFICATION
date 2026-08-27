class axi4_lite_subscriber extends uvm_subscriber #(axi4_lite_seq_item);
`uvm_component_utils(axi4_lite_subscriber)
axi4_lite_seq_item sub;
covergroup axi4_lite_cg;
awaddr_cp : coverpoint sub.AWADDR {
	bins aw1 ={[32'h0:32'h24]};
	 bins aw2 = {[32'h28:32'h30]};
	 bins aw3 = {[32'h34:32'h38]};
	 bins aw4 = {32'h3c};
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
}
bresp_cp : coverpoint sub.BRESP {
	bins br_low ={0};
	bins br_high ={1};
}
rresp_cp : coverpoint sub.RRESP {
	bins rr_low = {0};
	bins rr_high = {1};
}*/
araddr_cp :coverpoint sub.ARADDR {
	bins ar1 ={[32'h0:32'h24]};
	 bins ar2 = {[32'h28:32'h30]};
	 bins ar3 = {[32'h34:32'h38]};
	 bins ar4 = {32'h3c};
}
endgroup
function new(string name ="axi4_lite_subscriber", uvm_component parent);
	super.new(name,parent);
	axi4_lite_cg=new();
endfunction
virtual function void write (axi4_lite_seq_item t);
	sub=t;
	axi4_lite_cg.sample();
endfunction
endclass
