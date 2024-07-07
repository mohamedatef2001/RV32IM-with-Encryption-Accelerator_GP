//div of RV32IM verification uvm
//Author: reem ahmed
// DIV sequence item

package DIV_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class div_seq_item extends uvm_sequence_item;
`uvm_object_utils(div_seq_item)

parameter length =32;
rand logic signed [length-1:0] oper_a,oper_b;
rand logic operation,enable_div;
logic signed [length-1:0] div_o;


constraint c1 {  
oper_a inside {[-2**(length-1):(2**length-1)-1]};}

constraint c2 { 
oper_b inside {[-2**(length-1):(2**length-1)-1]}; }



//consturctor
function new (string name = "div_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s oper_a = 0h%0h, oper_b = 0h%0h, enable_div = 0h%0h, operation= 0h%0h, div_o=0h%0h", super.convert2string, oper_a, oper_b, enable_div,operation, div_o);
endfunction : convert2string

function string convert2string_stimulus();
			return $sformatf(" oper_a= 0h%0h, oper_b= 0h%0h, enable_div=0h%0h, operation= 0h%0h, div_o=0h%0h", oper_a, oper_b, enable_div,operation, div_o);
endfunction : convert2string_stimulus

endclass : div_seq_item	

endpackage : DIV_seq_item	