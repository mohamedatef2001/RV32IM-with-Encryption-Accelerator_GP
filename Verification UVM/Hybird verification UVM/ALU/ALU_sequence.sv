//alu of RV32IM verification uvm
//Author: Reem Ahmed & Nada Ayman
// ALU sequence
package ALU_sequence;
	import ALU_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class alu_main_sequence extends uvm_sequence #(alu_seq_item);
 `uvm_object_utils(alu_main_sequence)
  alu_seq_item seq_item;
//constructor
function new (string name = "alu_main_sequence");
			super.new(name);
		endfunction

//body
task body();
repeat(10000) begin
	seq_item= alu_seq_item::type_id::create("seq_item");
	start_item(seq_item);
	assert(seq_item.randomize());
	finish_item(seq_item);
end
endtask : body 
endclass : alu_main_sequence

/***************************************************************/

class sequence_1 extends uvm_sequence #(alu_seq_item);
		`uvm_object_utils(sequence_1)
		alu_seq_item seq_item;
//constructor
function new (string name = "sequence_1");
	  super.new(name);
endfunction

//body
task body();
seq_item = alu_seq_item::type_id::create("seq_item");
start_item(seq_item);
seq_item.operand_A=32'h5edfeab5;
seq_item.operand_B=32'ha006486c;
seq_item.ALU_Control=seq_item.OR;

finish_item(seq_item);
endtask : body
endclass 


endpackage : ALU_sequence	