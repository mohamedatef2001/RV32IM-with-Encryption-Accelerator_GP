//comparator of ALU_RV32IM 
//Author: reem ahmed ali
// 32-Bit Magnitude Comparator Using subtraction
module ALU_Comparator #(parameter data_width = 32)
(input logic  signed [data_width-1:0] operand_A,operand_B,output logic Greater,Equal,Less);

  // Internal signals
  logic signed [31:0] difference;


  // Calculate the difference between A and B
  always_comb begin
   if(operand_A[data_width-1] && ~operand_B[data_width-1])begin
    //operand_a is negative , operand_b is posetive 
    Equal=1'b0;
    Greater=1'b0;
    Less=1'b1;    
   end

   else if(~operand_A[data_width-1] && operand_B[data_width-1])begin
    //operand_a is posetive, operand_b is negative
    Equal=1'b0;
    Greater=1'b1;
    Less=1'b0;     
   end

   else if(~operand_A[data_width-1] && ~operand_B[data_width-1]) begin
    //both positive
     difference = operand_B - operand_A;
    //outputs
    Equal = (~difference);
    Greater = (difference[31] ); //negative result, operand_A is Greater than operand_B
    Less = (~difference[31]) && (~Equal); //positive result, operand_A is Less than operand_B
   end
   else begin
     //both negative
     difference = $unsigned(operand_B) -$unsigned(operand_A);
     Equal = (~difference);
    Greater = (difference[31]); //negative result, operand_A is Greater than operand_B
    Less = (~difference[31]) && (Equal); //positive result, operand_A is Less than operand_B
   end    
  end
 endmodule   


