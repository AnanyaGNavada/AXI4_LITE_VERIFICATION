class axi4_lite_seq extends uvm_sequence #(axi4_lite_seq_item);
`uvm_object_utils(axi4_lite_seq)
function new(string name = "axi4_lite_seq");
	super.new(name);
endfunction
task body();
	req=axi4_lite_seq_item::type_id::create("req");
	start_item(req);
	req.randomize();
	finish_item(req);
endtask
endclass
