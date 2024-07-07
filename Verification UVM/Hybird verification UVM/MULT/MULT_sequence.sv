//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT sequence
package MULT_sequence;
	import MULT_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
class mult_main_sequence extends uvm_sequence #(mult_seq_item);
 `uvm_object_utils(mult_main_sequence)
  mult_seq_item seq_item;
//constructor
function new (string name = "mult_main_sequence");
			super.new(name);
		endfunction

//body
task body();
repeat(10000) begin
	seq_item= mult_seq_item::type_id::create("seq_item");
	start_item(seq_item);
	assert(seq_item.randomize());
	finish_item(seq_item);
end
endtask : body	

endclass : mult_main_sequence	
/******************************************************************************************/

class mult_enable_sequence extends uvm_sequence #(mult_seq_item);
		`uvm_object_utils(mult_enable_sequence)
		mult_seq_item seq_item;
//constructor
function new (string name = "mult_enable_sequence");
	  super.new(name);
endfunction

//body
task body();
seq_item = mult_seq_item::type_id::create("seq_item");
start_item(seq_item);
seq_item.enable_mult = 0;
seq_item.mult_o =0;
finish_item(seq_item);
endtask : body
endclass : mult_enable_sequence

endpackage : MULT_sequence	