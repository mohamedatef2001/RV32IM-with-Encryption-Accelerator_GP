//ALU of RV32IM verification uvm
//Author: Reem ahmed & Nada Ayman
// ALU interface

interface ALU_interface(input bit clk);
    parameter data_width=32;
  logic [5:0] ALU_Control;
  logic signed [data_width-1:0] operand_A;
  logic signed [data_width-1:0] operand_B;
  logic signed [data_width-1:0] ALU_result;
  logic Branch_taken;
  logic signed [data_width-1:0] JALR_target;
  logic hold_pipeline;
  logic pc_s_a_1;
  logic ex;  
  logic zero;

modport TEST (output ALU_Control, operand_A, operand_B ,input ALU_result, Branch_taken, JALR_target, hold_pipeline, ex, pc_s_a_1, zero);

modport DUT (input ALU_Control, operand_A, operand_B ,output ALU_result, Branch_taken, JALR_target, hold_pipeline, ex, pc_s_a_1, zero );

modport Monitor (input ALU_Control, operand_A, operand_B, ALU_result, Branch_taken, JALR_target, hold_pipeline, ex, pc_s_a_1, zero );


endinterface 	