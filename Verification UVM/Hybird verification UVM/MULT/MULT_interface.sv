//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT interface

interface MULT_interface(input bit clk);

parameter length =32;
logic signed [length-1:0] oper_a,oper_b;
logic  enable_mult,operation;
logic signed [length-1:0] mult_o;


modport TEST (output oper_a, oper_b, enable_mult, operation,input  mult_o);

modport DUT (input oper_a, oper_b, enable_mult, operation,output  mult_o);

modport Monitor (input oper_a, oper_b, enable_mult, operation, mult_o);


endinterface : MULT_interface	