class axi4_lite_test extends uvm_test;
  `uvm_component_utils(axi4_lite_test)
  axi4_lite_environment env;
  function new(string name = "axi4_lite_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi4_lite_environment::type_id::create("env", this);
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass

class axi4_lite_test_write extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_write)
  axi4_lite_seq_write seq;
  function new(string name = "axi4_lite_test_write", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_write::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Write completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_read extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_read)
  axi4_lite_seq_read seq;
  function new(string name = "axi4_lite_test_read", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_read::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Read completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_write_ro extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_write_ro)
  axi4_lite_write_ro seq;
  function new(string name = "axi4_lite_test_write_ro", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_write_ro::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Write to ro completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_read_wo extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_read_wo)
  axi4_lite_seq_read_wo seq;
  function new(string name = "axi4_lite_test_read_wo", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_read_wo::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Read to wo completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_write_unaligned extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_write_unaligned)
  axi4_lite_seq_write_unaligned seq;
  function new(string name = "axi4_lite_test_write_unaligned", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_write_unaligned::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Write unaligned completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass


class axi4_lite_test_read_unaligned extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_read_unaligned)
  axi4_lite_seq_read_unaligned seq;
  function new(string name = "axi4_lite_test_read_unaligned", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_read_unaligned::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Read to unaligned completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_write_decerr extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_write_decerr)
  axi4_lite_seq_write_decerr seq;
  function new(string name = "axi4_lite_test_write_decerr", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_write_decerr::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Write decerr completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_read_decerr extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_read_decerr)
  axi4_lite_seq_read_decerr seq;
  function new(string name = "axi4_lite_test_read_decerr", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_read_decerr::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Read decerr completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_simultaneous_read_write extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_simultaneous_read_write)
  axi4_lite_simultaneous_read_write seq;
  function new(string name = "axi4_lite_test_simultaneous_read_write", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_simultaneous_read_write::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Simultaneous read write completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_addr_with_delay_data extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_addr_with_delay_data)
  axi4_lite_seq_addr_with_delay_data seq;
  function new(string name = "axi4_lite_test_addr_with_delay_data", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_addr_with_delay_data::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Addr with data delay completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class axi4_lite_test_data_with_delay_addr extends axi4_lite_test;
  `uvm_component_utils(axi4_lite_test_data_with_delay_addr)
  axi4_lite_seq_data_with_delay_addr seq;
  function new(string name = "axi4_lite_test_data_with_delay_addr", uvm_component parent);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq = axi4_lite_seq_data_with_delay_addr::type_id::create("seq");
    seq.start(env.aa.seqr);
    `uvm_info("TEST", "Data with addr delay completed", UVM_NONE)
    phase.drop_objection(this);
  endtask
endclass

class regression_test extends axi4_lite_test;
 `uvm_component_utils(regression_test)
 function new(string name ="regression_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  task run_phase(uvm_phase phase);
  axi4_lite_seq_write seq1;
axi4_lite_seq_read seq2;
axi4_lite_write_ro seq3;
axi4_lite_seq_read_wo seq4;
  axi4_lite_seq_write_unaligned seq5;
  axi4_lite_seq_read_unaligned seq6;
  axi4_lite_seq_write_decerr seq7;
  axi4_lite_seq_read_decerr seq8;
  axi4_lite_simultaneous_read_write seq9;
  axi4_lite_seq_addr_with_delay_data seq10;
  axi4_lite_seq_data_with_delay_addr seq11;
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
   seq10=axi4_lite_seq_addr_with_delay_data::type_id::create("seq10");
  seq10.start(env.aa.seqr);
   $display( "Addr with data delay completed");
     seq11 = axi4_lite_seq_data_with_delay_addr::type_id::create("seq11");
     seq11.start(env.aa.seqr);
   $display( "data with addr delay completed");
  phase.drop_objection(this);
  `uvm_info("TEST", "Testcases completed", UVM_NONE)
endtask
endclass
