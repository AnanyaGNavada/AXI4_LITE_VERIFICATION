interface axi4_lite_interface(input bit clk, rst);
	logic [`ADDR_WIDTH-1:0] AWADDR, ARADDR;
	logic [`DEFAULT_PROT-1:0] AWPROT, ARPROT;
	logic AWVALID, AWREADY, WVALID, WREADY, BVALID, BREADY, ARVALID, ARREADY, RVALID, RREADY;
	logic [1:0] BRESP, RRESP;
	logic [`DATA_WIDTH-1:0] WDATA, RDATA;
	logic [(`DATA_WIDTH/8)-1:0] WSTRB;

	clocking drv_cb @(posedge clk);
		default input #1 output #1;
		output AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID, RREADY;
		input AWREADY, WREADY, BVALID, ARREADY, RVALID;
	endclocking

	clocking inp_mon_cb @(posedge clk);
		default input #1 output #1;
		input AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID;
		input  AWREADY, WREADY,  ARREADY;
	endclocking

	clocking out_mon_cb @(posedge clk);
		default input #1 output #1;
		input  AWREADY, AWVALID, WREADY, WVALID, BRESP, BVALID, BREADY, ARREADY, ARVALID, RDATA, RRESP, RVALID,RREADY;
		
	endclocking

	modport drv (clocking drv_cb);
	modport inp_mon (clocking inp_mon_cb);
	modport out_mon (clocking out_mon_cb);
	
	property p1;
	@(posedge clk) AWVALID && !AWREADY |=>$stable(AWADDR);
	endproperty
	assert property(p1)
	else
		$error("P1","Address not stable");
		
	property p2;
	@(posedge clk) WVALID && !WREADY |=>$stable(WDATA);
	endproperty
	assert property(p2)
	else
		$error ("P2","Data not stable");
	
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
		$error ("P2","wstrb not stable");
		
	property p5;
	@(posedge clk) ARVALID && !ARREADY |=>$stable(ARADDR);
	endproperty
	assert property(p5)
	else
		$error ("P5","read address  not stable");
		
	property p6;
	@(posedge clk) ARVALID && !ARREADY |=>$stable(RDATA);
	endproperty
	assert property(p6)
	else
		$error ("P6","read data  not stable");
		
	property p7;
	@(posedge clk) BVALID && !BRESP |=>$stable(BRESP);
	endproperty
	assert property(p7)
	else
		$error("P7","Bresp not stable");
		
	property p8;
	@(posedge clk )ARVALID && ARREADY |->##[0:$] RVALID;
	endproperty
	assert property (p8)
	else
		$error("P8","rvalid came before");

endinterface
