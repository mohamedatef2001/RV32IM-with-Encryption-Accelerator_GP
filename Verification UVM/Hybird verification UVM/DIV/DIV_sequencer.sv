//div of RV32IM verification uvm
//Author: reem ahmed
// DIV sequencer

package DIV_sequencer;
	import DIV_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class div_sequencer extends uvm_sequencer #(div_seq_item);
		`uvm_component_utils(div_sequencer)
//constructor
function new (string name = "div_sequencer", uvm_component parent = null);
	super.new(name, parent);
endfunction

	endclass : div_sequencer
endpackage