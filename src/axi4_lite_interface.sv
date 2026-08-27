interface axi4_lite_interface(input bit clk, rst);
	logic [`ADDR_WIDTH-1:0] AWADDR, ARADDR;
	logic [`DEFAULT_PROT-1:0] AWPROT, ARPROT;
	logic AWVALID, AWREADY, WVALID, WREADY, BVALID, BREADY, ARVALID, ARREADY, RVALID, RREADY;
	logic [1:0] BRESP, RRESP;
	logic [`DATA_WIDTH-1:0] WDATA, RDATA;
	logic [(`DATA_WIDTH/8)-1:0] WSTRB;

	clocking drv_cb @(posedge clk);
		default input #0 output #0;
		output AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID, RREADY;
		input AWREADY, WREADY, BVALID, ARREADY;
	endclocking

	clocking inp_mon_cb @(posedge clk);
		default input #0 output #0;
		input AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID, RREADY;
		input  AWREADY, WREADY, BVALID, ARREADY;
	endclocking

	clocking out_mon_cb @(posedge clk);
		default input #0 output #0;
		input  AWREADY, WREADY, BRESP, BVALID, ARREADY, RDATA, RRESP, RVALID;
		
	endclocking

	modport drv (clocking drv_cb);
	modport inp_mon (clocking inp_mon_cb);
	modport out_mon (clocking out_mon_cb);

endinterface
