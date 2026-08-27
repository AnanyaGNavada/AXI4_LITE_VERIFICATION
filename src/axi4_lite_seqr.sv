class axi4_lite_seqr extends uvm_sequencer #(axi4_lite_seq_item);
`uvm_components_utils(axi4_lite_seqr)
function new(string name = "axi4_lite_seqr", uvm_component parent);
	super.new(name,parent);
endfunction
endclass
