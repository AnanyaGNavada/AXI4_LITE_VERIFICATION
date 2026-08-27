`include "defines.svh"
`include "axi4_lite_pkgs.sv"
`include "axi4_lite_interface.sv"
module axi4_lite_top;
import uvm_pkg::*;
import axi4_lite_pkgs::*;
bit clk, rst;
always #5 clk=~clk;
initial begin
	clk=0;
	rst=0;
	#5;
	rst=1;
end
axi4_lite_interface intf(clk,rst);
//dut instantiate
initial begin
	uvm_config_db #(virtual axi4_lite_interface)::set(null,"*","vif",intf);
	$dumpfile("dump.vcd");
	 $dumpvars;
end
initial begin
	run_test("axi4_lite_test");
end
endmodule
