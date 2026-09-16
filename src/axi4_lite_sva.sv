`include "uvm_macros.svh"
import uvm_pkg::*;
interface axi4_lite_sva (
    clk,rst,
	AWADDR, ARADDR,
	AWPROT, ARPROT,
	AWVALID, AWREADY, WVALID, WREADY, BVALID, BREADY, ARVALID, ARREADY, RVALID, RREADY,
	BRESP, RRESP,
	WDATA, RDATA,
	WSTRB
);
    input bit clk,rst;
	input bit [`ADDR_WIDTH-1:0] AWADDR, ARADDR;
	input bit [`DEFAULT_PROT-1:0] AWPROT, ARPROT;
	input bit AWVALID, AWREADY, WVALID, WREADY, BVALID, BREADY, ARVALID, ARREADY, RVALID, RREADY;
	input bit [1:0] BRESP, RRESP;
	input bit [`DATA_WIDTH-1:0] WDATA, RDATA;
	input bit [(`DATA_WIDTH/8)-1:0] WSTRB;
	property p1;
	@(posedge clk) AWVALID && !AWREADY |=>$stable(AWADDR);
	endproperty
	assert property(p1)
	else
		`uvm_error("P1","Address not stable")
		
	property p2;
	@(posedge clk) WVALID && !WREADY |=>$stable(WDATA);
	endproperty
	assert property(p2)
	else
		`uvm_error ("P2","Data not stable")
	
	/*property p3;
	@(posedge clk) bvalid && !bready |=> $stable(awaddr && wdata);
	endproperty
	assert property(p3)
	else
		`uvm_error("P3","Address and data not stable")*/
		
	property p4;
	@(posedge clk) WVALID && !WREADY |=>$stable(WSTRB);
	endproperty
	assert property(p4)
	else
		`uvm_error ("P2","wstrb not stable")
		
	property p5;
	@(posedge clk) ARVALID && !ARREADY |=>$stable(ARADDR);
	endproperty
	assert property(p5)
	else
		`uvm_error ("P5","read address  not stable")
		
	property p6;
	@(posedge clk) ARVALID && !ARREADY |=>$stable(RDATA);
	endproperty
	assert property(p6)
	else
		`uvm_error ("P6","read data  not stable")
		
	property p7;
	@(posedge clk) BVALID && !BRESP |=>$stable(BRESP);
	endproperty
	assert property(p7)
	else
		`uvm_error("P7","Bresp not stable")
		
	property p8;
	@(posedge clk )ARVALID && ARREADY |->##[0:$] RVALID;
	endproperty
	assert property (p8)
	else
		`uvm_error("P8","rvalid came before")
		
endinterface
