`uvm_analysis_imp_decl(_in)
`uvm_analysis_imp_decl(_out)
class axi4_lite_scoreboard extends uvm_scoreboard;
`uvm_component_utils(axi4_lite_scoreboard)
//virtual axi4_lite_interface vif;
axi4_lite_seq_item inp[$];
axi4_lite_seq_item out[$];
bit [`DATA_WIDTH-1:0] exp_rdata;
bit [1:0] exp_bresp, exp_rresp;
  bit [`DATA_WIDTH-1:0] mem[bit[`MEM_DEPTH-1:0]];
uvm_analysis_imp_in #(axi4_lite_seq_item, axi4_lite_scoreboard) inp_port;
uvm_analysis_imp_out #(axi4_lite_seq_item, axi4_lite_scoreboard) out_port;
function new(string name="axi4_lite_scoreboard", uvm_component parent);
	super.new(name,parent);
	inp_port=new("inp_port",this);
	out_port=new("out_port",this);
endfunction
/*function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(virtual axi4_lite_interface)::get(this, "","vif", vif))
	`uvm_fatal(get_type_name(),"Scoreboard get failed")
endfunction*/
function void write_in (axi4_lite_seq_item t);
	inp.push_back(t);
endfunction
function void write_out(axi4_lite_seq_item t);
	out.push_back(t);
endfunction
task run_phase(uvm_phase phase);
	axi4_lite_seq_item t1,t2;
	forever begin
      wait(inp.size>0 && out.size>0);
			t1=inp.pop_front();
			t2=out.pop_front();
		compare_data(t1,t2);
	end
endtask
task compare_data (axi4_lite_seq_item t1,axi4_lite_seq_item t2);
	if(t1.write) begin
      if (t1.AWADDR > 32'h3C)
			exp_bresp=2'b11;
      else if(t1.AWADDR[1:0] !=0 || (t1.AWADDR>=32'h28 && t1.AWADDR<=32'h30))
			exp_bresp=2'b10;
		else begin
			exp_bresp=2'b00;
			for(int i=0;i<`ADDR_WIDTH/8;i++) begin
              if(t1.WSTRB[i]) 
                mem[t1.AWADDR/4][i*8+:8]=t1.WDATA[i*8+:8];
       		end
		end
	if(exp_bresp==t2.BRESP)
      `uvm_info("BRESP",$sformatf("Matched : exp_bresp= %h actual_bresp=%h write = %h read = %h",exp_bresp,t2.BRESP,t1.write,t1.read),UVM_NONE)
	else
      `uvm_error("BRESP",$sformatf("Mismatched : exp_bresp= %h actual_bresp=%h ",exp_bresp,t2.BRESP))
	end
	 if(t1.read) begin
       if(t1.ARADDR > 32'h3C)begin
			exp_rresp=2'b11;
         	exp_rdata=0;
       end
      else if(t1.ARADDR[1:0] !=0 || (t1.ARADDR>=32'h34 && t1.ARADDR<=32'h38))
			exp_rresp=2'b10;
		else begin
			exp_rresp=2'b00;
          exp_rdata=mem[t1.ARADDR/4];
		end
	if(exp_rresp==t2.RRESP)
      `uvm_info("RRESP",$sformatf("Matched : exp_rresp=%h actual_rresp =%h write = %h read = %h",exp_rresp,t2.RRESP,t1.write,t1.read),UVM_NONE)
	else
      `uvm_error("RRESP",$sformatf("Mismatched : exp_rresp= %h actual_rresp=%h ",exp_rresp,t2.RRESP))
		if(exp_rdata==t2.RDATA)
          `uvm_info("RDATA",$sformatf("Matched : exp_rdata=%h actual_rdata =%h",exp_rdata,t2.RDATA),UVM_NONE)
		else
          `uvm_error("RDATA",$sformatf("Mismatched : exp_rdata= %h actual_rdata=%h ",exp_rdata,t2.RDATA))
	end
endtask
endclass
