//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT sequence item

package MULT_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_seq_item extends uvm_sequence_item;
`uvm_object_utils(mult_seq_item)

parameter length =32;
rand logic signed [length-1:0] oper_a,oper_b;
rand logic signed enable_mult,operation;
logic signed [length-1:0] mult_o;


//constraints
/*constraint funct3 { 
operation dist {0:=50, 1:=50};
}; */


//consturctor
function new (string name = "mult_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s oper_a = 0h%0h, oper_b = 0h%0h, enable_mult = 0h%0h, operation= 0h%0h, mult_o=0h%0h", super.convert2string, oper_a, oper_b, enable_mult,operation,mult_o);
endfunction : convert2string

function string convert2string_stimulus();
			return $sformatf(" oper_a = 0h%0h, oper_b = 0h%0h, enable_mult =0h%0h, operation= 0h%0h,mult_o=0h%0h", oper_a, oper_b, enable_mult,operation,mult_o);
endfunction : convert2string_stimulus

endclass : mult_seq_item	

endpackage : MULT_seq_item	