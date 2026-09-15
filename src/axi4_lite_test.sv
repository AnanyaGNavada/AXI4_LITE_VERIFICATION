class axi4_lite_test extends uvm_test;
`uvm_component_utils(axi4_lite_test)
  axi4_lite_environment env;
axi4_lite_seq_write seq1;
axi4_lite_seq_read seq2;
axi4_lite_write_ro seq3;
axi4_lite_seq_read_wo seq4;
  axi4_lite_seq_write_unaligned seq5;
  axi4_lite_seq_read_unaligned seq6;
  axi4_lite_seq_write_decerr seq7;
  axi4_lite_seq_read_decerr seq8;
  axi4_lite_simultaneous_read_write seq9;
function new(string name = "axi4_lite_test", uvm_component parent);
	super.new(name,parent);
endfunction
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env=axi4_lite_environment::type_id::create("env",this);
endfunction
function void end_of_elaboration_phase(uvm_phase phase);
	super.end_of_elaboration_phase(phase);
	uvm_top.print_topology();
endfunction
task run_phase(uvm_phase phase);
  phase.raise_objection(this);
  seq1 = axi4_lite_seq_write::type_id::create("seq1");
  seq1.start(env.aa.seqr);
  $display("Write completed");
  seq2 = axi4_lite_seq_read::type_id::create("seq2");
  seq2.start(env.aa.seqr);
  $display("Read completed");
  seq3 = axi4_lite_write_ro::type_id::create("seq3");
  seq3.start(env.aa.seqr);
  $display("Write to ro completed");
  seq4 = axi4_lite_seq_read_wo::type_id::create("seq4");
  seq4.start(env.aa.seqr);
  $display("Read to wo completed");
  seq5 = axi4_lite_seq_write_unaligned::type_id::create("seq5");
  seq5.start(env.aa.seqr);
  $display("Write unaligned completed");
  seq6 = axi4_lite_seq_read_unaligned::type_id::create("seq6");
  seq6.start(env.aa.seqr);
  $display("Read to unaligned completed");
  seq7 = axi4_lite_seq_write_decerr::type_id::create("seq7");
  seq7.start(env.aa.seqr);
  $display("Write decerr completed");
  seq8 = axi4_lite_seq_read_decerr::type_id::create("seq8");
  seq8.start(env.aa.seqr);
  $display("Read decerr completed");
  seq9=axi4_lite_simultaneous_read_write::type_id::create("seq9");
  seq9.start(env.aa.seqr);
  $display("Simultaneous read write completed");
  phase.drop_objection(this);
  `uvm_info("TEST", "Testcases completed", UVM_NONE)
endtask
endclass
