`include "defines.svh"
`include "axi4_lite_pkgs.sv"
`include "axi4_lite_interface.sv"
//`include "axi4_lite_sva.sv"
`include "axi4_lite_slave.v"
module axi4_lite_top;
import uvm_pkg::*;
import axi4_lite_pkgs::*;
bit clk, rst;
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 0;
    #1;
    rst = 1;
    #1;
    rst=0;
    #1;
    rst=1;
end
axi4_lite_interface vif(clk,rst);

//bind vif axi4_lite_sva ASSERT(.*);

axi4_lite_slave #(.DATA_WIDTH(`DATA_WIDTH), .ADDR_WIDTH(`ADDR_WIDTH), .MEM_DEPTH(`MEM_DEPTH), .DEFAULT_PROT(`DEFAULT_PROT)) duv (.ACLK(clk), .ARESETn(rst), .AWADDR(vif.AWADDR), .AWPROT(vif.AWPROT), .AWVALID(vif.AWVALID), .AWREADY(vif.AWREADY), .WDATA(vif.WDATA), .WSTRB(vif.WSTRB), .WVALID(vif.WVALID),
 .WREADY(vif.WREADY), .BRESP(vif.BRESP), 
.BVALID(vif.BVALID), .BREADY(vif.BREADY), .ARADDR(vif.ARADDR), .ARPROT(vif.ARPROT), .ARVALID(vif.ARVALID), .ARREADY(vif.ARREADY), .RDATA(vif.RDATA), .RRESP(vif.RRESP), .RVALID(vif.RVALID),
 .RREADY(vif.RREADY));
initial begin
	uvm_config_db #(virtual axi4_lite_interface.drv)::set(null,"uvm_test_top.env.aa.drv","vif",vif);
	uvm_config_db #(virtual axi4_lite_interface.inp_mon):: set(null,"uvm_test_top.env.aa.inp_mon","vif",vif);
	uvm_config_db #(virtual axi4_lite_interface.out_mon):: set(null, "uvm_test_top.env.pa.out_mon","vif",vif);
	//uvm_config_db #(virtual axi4_lite_interface.out_mon):: set(null, "*","vif",vif);
	$dumpfile("dump.vcd");
	 $dumpvars;
end
initial begin
	run_test("regression_test");
end
endmodule
