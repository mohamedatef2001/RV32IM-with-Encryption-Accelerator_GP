//alu of RV32IM verification uvm
//Author: Reem ahmed & Nada Ayman
// ALU sequence item

package ALU_seq_item;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alu_seq_item extends uvm_sequence_item;
`uvm_object_utils(alu_seq_item)
parameter data_width=32;
rand logic [5:0] ALU_Control;
rand logic signed [data_width-1:0] operand_A;
rand logic signed [data_width-1:0] operand_B;
logic signed [data_width-1:0] ALU_result;
logic Branch_taken;
logic signed [data_width-1:0] JALR_target;
logic hold_pipeline;
logic pc_s_a_1;
logic ex;  
logic zero;

//parameters
parameter ADD = 6'b000000;
	parameter SUB = 6'b001000;
	//bitwise
	parameter OR  = 6'b000110;
	parameter XOR = 6'b000100;
	parameter AND = 6'b000111;
	//shift
	parameter SLL = 6'b000001;
	parameter SRL = 6'b000101;
	parameter SRA = 6'b001101;
	//set less than
	parameter SLT = 6'b000010;
	//jump and link
	parameter JALR = 6'b100111;
	//branch
	parameter BEQ = 6'b010000;
	parameter BNE = 6'b010001;
	parameter BLT = 6'b000010;
	parameter BGE = 6'b010101;
	parameter BLTU = 6'b010110;
	parameter BGEU = 6'b010111;

    	localparam ZERO = 0;
    	localparam POSMAX = 32'h7fffffff;
    	localparam NEGMAX = 32'h80000000;
	//new type
	/*typedef enum {ADD, SUB, OR, XOR, AND,
              SLL, SRL, SRA, SLT, JALR, BEQ, BNE,
              BLT, BGE, BLTU, BGEU} opcode_e; */
 //constraints
        constraint c1 {
          if ( ALU_Control == (ADD||SUB)) {
          	operand_A dist {POSMAX:=60,NEGMAX:=60,ZERO:=60/*,[2147483646:1]:=30,[-1:-2147483646]:=30*/};
            operand_B dist {POSMAX:=60,NEGMAX:=60,ZERO:=60/*,[1:2147483646]:=30,[-1:-2147483646]:=30*/};
          	}	
        }

        // constraint c2 {
        //   if (ALU_Control == SLT) {
        //   	operand_A dist {[POSMAX: ZERO]:=30, [ZERO:NEGMAX]:=60};
        //   	operand_B dist {[POSMAX: ZERO]:=60, [ZERO:NEGMAX]:=30};
        //   	}
       	// }

       /* constraint c3 {
            ALU_result dist {BGEU:=10, BLTU:=10};
        } */ 	



//consturctor
function new (string name = "alu_seq_item");
	super.new(name);
endfunction

function string convert2string();
	return $sformatf("%s operand_A = 0h%0h, operand_B = 0h%0h, ALU_Control= 0h%0h, ALU_result= 0h%0h, Branch_taken=0h%0h, JALR_target=0h%0h, hold_pipeline=0h%0h, pc_s_a_1=0h%0h, zero=0h%0h, ex=0h%0h", super.convert2string(), operand_A, operand_B, ALU_Control, ALU_result, Branch_taken, JALR_target, hold_pipeline, pc_s_a_1, zero, ex);
endfunction : convert2string

// function string convert2string_stimulus();
//     return $sformatf("%s operand_A = 0h%0h, operand_B = 0h%0h, ALU_Control= 0h%0h, ALU_result= 0h%0h, Branch_taken= 0h%0h, JALR_target= 0h%0h, hold_pipeline= 0h%0h, pc_s_a_1= 0h%0h, zero= 0h%0h, ex= 0h%0h",
//                      operand_A, operand_B, ALU_Control, ALU_result, Branch_taken, JALR_target, hold_pipeline, pc_s_a_1, zero, ex);
// endfunction : convert2string_stimulus


function string convert2string_stimulus();
    string result_str;
    // Checking first part
    result_str = $sformatf("operand_A = 0h%0h, operand_B = 0h%0h, ALU_Control= 0h%0h", 
                           operand_A, operand_B, ALU_Control);
    // Adding second part
    result_str = {result_str, $sformatf(", ALU_result= 0h%0h, Branch_taken= 0b%0b", 
                                        ALU_result, Branch_taken)};
    // Adding third part
    result_str = {result_str, $sformatf(", JALR_target= 0h%0h, hold_pipeline= 0b%0b", 
                                        JALR_target, hold_pipeline)};
    // Adding final part
    result_str = {result_str, $sformatf(", pc_s_a_1= 0h%0h, zero= 0b%0b, ex= 0b%0b",
                                        pc_s_a_1, zero, ex)};
    return result_str;
endfunction : convert2string_stimulus



endclass : alu_seq_item	

endpackage : ALU_seq_item	