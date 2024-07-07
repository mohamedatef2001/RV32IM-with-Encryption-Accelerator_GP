//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT sequencer

package MULT_sequencer;
	import MULT_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class mult_sequencer extends uvm_sequencer #(mult_seq_item);
		`uvm_component_utils(mult_sequencer)
//constructor
function new (string name = "mult_sequencer", uvm_component parent = null);
	super.new(name, parent);
endfunction

	endclass : mult_sequencer
endpackage