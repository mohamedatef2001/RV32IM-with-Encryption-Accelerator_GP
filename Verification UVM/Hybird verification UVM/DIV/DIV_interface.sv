//div of RV32IM verification uvm
//Author: reem ahmed 
// DIV interface

interface DIV_interface(input bit clk);

parameter length =32;
 logic signed [length-1:0] oper_a,oper_b;
 logic operation,enable_div;
 logic signed [length-1:0] div_o;

modport TEST (output oper_a,oper_b,operation,enable_div,input div_o);

modport DUT (input oper_a,oper_b,operation,enable_div,output div_o );

modport Monitor (input oper_a,oper_b,operation,enable_div,div_o );


endinterface 	