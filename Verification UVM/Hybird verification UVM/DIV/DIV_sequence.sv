//div of RV32IM verification uvm
//Author: reem ahmed
// DIV sequence
package DIV_sequence;
	import DIV_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class div_main_sequence extends uvm_sequence #(div_seq_item);
 `uvm_object_utils(div_main_sequence)
  div_seq_item seq_item;
//constructor
function new (string name = "div_main_sequence");
			super.new(name);
		endfunction

//body
task body();
repeat(10000) begin
	seq_item= div_seq_item::type_id::create("seq_item");
	start_item(seq_item);
	assert(seq_item.randomize());
	finish_item(seq_item);
end
endtask : body 
endclass : div_main_sequence

/***************************************************************/

class div_enable_sequence extends uvm_sequence #(div_seq_item);
		`uvm_object_utils(div_enable_sequence)
		div_seq_item seq_item;
//constructor
function new (string name = "div_enable_sequence");
	  super.new(name);
endfunction

//body
task body();
seq_item = div_seq_item::type_id::create("seq_item");
start_item(seq_item);
seq_item.enable_div = 0;
seq_item.div_o =0;
finish_item(seq_item);
endtask : body
endclass : div_enable_sequence


endpackage : DIV_sequence	