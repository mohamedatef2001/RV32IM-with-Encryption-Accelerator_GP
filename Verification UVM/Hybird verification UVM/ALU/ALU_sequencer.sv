//alu of RV32IM verification uvm
//Author: Reem Ahmed & Nada Ayman
// ALU sequencer

package ALU_sequencer;
	import ALU_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class alu_sequencer extends uvm_sequencer #(alu_seq_item);
		`uvm_component_utils(alu_sequencer)
//constructor
function new (string name = "alu_sequencer", uvm_component parent = null);
	super.new(name, parent);
endfunction

	endclass : alu_sequencer
endpackage