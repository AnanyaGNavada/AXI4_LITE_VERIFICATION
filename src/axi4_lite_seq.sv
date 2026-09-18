class axi4_lite_seq_write extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_write)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_write");
	super.new(name);
endfunction
  task body();
    repeat(100) begin
    req=axi4_lite_seq_item::type_id::create("req");
    start_item(req);
      assert(req.randomize() with {write==1; read==0; AWADDR< 'h3C; d1<4; d2<5; d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
    finish_item(req);
    end
  endtask
endclass


class axi4_lite_seq_read extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_read)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_read");
	super.new(name);
endfunction
task body();
  repeat(100) begin
  req=axi4_lite_seq_item::type_id::create("req");
  start_item(req);
    assert(req.randomize() with {write==0; read==1; ARADDR< 'h3C; d1<4; d2<5; d1!=d2;AWADDR[1:0]==0; ARADDR[1:0]==0;})
  finish_item(req);
  end
endtask
endclass

class axi4_lite_write_ro extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_write_ro)
  function new(string name = "axi4_lite_seq_read");
	super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req=axi4_lite_seq_item::type_id::create("req");
  start_item(req);
      assert(req.randomize() with {write==1; read==0; AWADDR inside {[32'h28:32'h30]}; d1<4; d2<5; d1!=d2;AWADDR[1:0]==0; ARADDR[1:0]==0;})
  finish_item(req);
  end
endtask
endclass

class axi4_lite_seq_read_wo extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_read_wo)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_read_wo");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with { write==0; read==1;ARADDR inside {[32'h34:32'h38]};d1<4; d2<5; d1!=d2;AWADDR[1:0]==0; ARADDR[1:0]==0;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_write_unaligned extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_write_unaligned)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_write_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {write==1; read==0;  AWADDR[1:0]!=0;AWADDR<'h3c; d1<4; d2<5; d1!=d2;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_read_unaligned extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_read_unaligned)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_read_unaligned");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {write==0; read==1;  ARADDR[1:0]!=0;ARADDR<'h3c; d1<4; d2<5; d1!=d2;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_write_decerr extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_write_decerr)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_write_decerr");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {write==1; read==0;AWADDR>'h3C;d1<4; d2<5; d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_read_decerr extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_read_decerr)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_read_decerr");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {write==0; read==1;ARADDR>'h3c;d1<4; d2<5;d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_simultaneous_read_write extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_simultaneous_read_write)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_simultaneous_read_write");
    super.new(name);
  endfunction
  task body();
    repeat(100) begin
      req = axi4_lite_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {write==1; read==1;ARADDR<'h3c;d1<4; d2<5;d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
      finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_addr_with_delay_data extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_addr_with_delay_data)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_addr_with_delay_data");
	super.new(name);
endfunction
  task body();
    repeat(100) begin
    req=axi4_lite_seq_item::type_id::create("req");
    start_item(req);
      assert(req.randomize() with {write==1; read==0; AWADDR< 'h3C; d1==0; d2<5; d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
    finish_item(req);
    end
  endtask
endclass

class axi4_lite_seq_data_with_delay_addr extends uvm_sequence #(axi4_lite_seq_item);
  `uvm_object_utils(axi4_lite_seq_data_with_delay_addr)
  axi4_lite_seq_item req;
  function new(string name = "axi4_lite_seq_data_with_delay_addr");
	super.new(name);
endfunction
  task body();
    repeat(100) begin
    req=axi4_lite_seq_item::type_id::create("req");
    start_item(req);
      assert(req.randomize() with {write==1; read==0; AWADDR< 'h3C; d1<5; d2==0; d1!=d2; AWADDR[1:0]==0; ARADDR[1:0]==0;})
    finish_item(req);
    end
  endtask
endclass


