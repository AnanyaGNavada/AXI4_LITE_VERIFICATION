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

endinterface
