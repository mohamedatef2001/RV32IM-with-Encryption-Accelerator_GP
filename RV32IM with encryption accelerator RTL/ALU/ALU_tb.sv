//ALU of RV32IM  TESTBENCH
//Author: reem ahmed ali
module ALU_tb;
  // Parameters
  parameter data_width = 32;

  logic [5:0] ALU_Control;
  logic signed [data_width-1:0] operand_A;
  logic signed [data_width-1:0] operand_B;
  logic signed [data_width-1:0] ALU_result;
  //logic is_equal,
  //logic is_greater,
  logic Branch_taken;
  logic signed [data_width-1:0] JALR_target;
  logic hold_pipeline;
  logic pc_s_a_1;
  logic ex;
  logic zero;
  //logic carry;
  //logic overflow;
  //logic negative;


// Instantiation of ALU_RV32IM module
  ALU #(data_width) dut (
    .ALU_Control(ALU_Control),
    .operand_A(operand_A),
    .operand_B(operand_B),
    .ALU_result(ALU_result),
    //.is_equal(is_equal),
    //.is_greater(is_greater),
    .Branch_taken(Branch_taken),
    .JALR_target(JALR_target),
    .hold_pipeline(hold_pipeline),
     .pc_s_a_1(pc_s_a_1),
     .ex(ex),
    .zero(zero)
   // .carry(carry),
    //.overflow(overflow),
    //.negative(negative)
  );
  

 // Stimulus
initial begin
	// Test case 1: Addition (directed)
    ALU_Control = 6'b000000; // Add
    operand_A = 10;
    operand_B = 5;
    
    // Wait for the ALU to compute the result
    #10;
    
    // Display the outputs
    $display("ALU Result: %d", ALU_result);
    $display("Zero: %b", zero);
    //$display("Carry: %b", carry);
    //$display("Overflow: %b", overflow);
    //$display("Negative: %b", negative);

// Test case 2: Subtraction (randomized)
    ALU_Control = 6'b001000; // Sub
    operand_A = $random;
    operand_B = $random;
 // Wait for the ALU to compute the result
    #10;
    
    // Display the outputs
    $display("Subtraction: %d - %d = %d", operand_A, operand_B, ALU_result);
    $display("Zero: %b", zero);
   // $display("Carry: %b", carry);
    //$display("Overflow: %b", overflow);
    //$display("Negative: %b", negative);

// Test case 3: XOR
    ALU_Control = 6'b000100; 
    operand_A = $random;
    operand_B = $random;
 // Wait for the ALU to compute the result
    #10;

    // Display the outputs
    $display("XOR: %d ^ %d = %d", operand_A, operand_B, ALU_result);
    $display("Zero: %b", zero);

//Test case 4: Logical Shift Left
    ALU_Control = 6'b000001; 
    operand_A = $random;
    operand_B = $random;
 // Wait for the ALU to compute the result
    #10;
    // Display the outputs
    $display("Logical Shift Left: %d << %d = %d", operand_A, operand_B, ALU_result);
    

//Test case 5:  Signed Less Than (SLTI, SLT) 
    ALU_Control = 6'b000010; 
    operand_A = $random;
    operand_B = $random;
  // Wait for the ALU to compute the result
    #10;     
$display("SLTI: %d  %d  %d", operand_A,ALU_result, operand_B);


//Test case 6:  Branch Operations
ALU_Control= 6'b010000;
operand_A = $random;
operand_B = $random;
#10;
$display("BEQ- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);


ALU_Control= 6'b010001;
operand_A = $random;
operand_B = $random;
#10;
$display("BNE- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);

ALU_Control= 6'b10010;
operand_A = $random;
operand_B = $random;
#10;
$display("BLT- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);

  ALU_Control= 6'b010101;
operand_A = $random;
operand_B = $random;
#10;
$display("BGE- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);

    ALU_Control= 6'b010110;
operand_A = $random;
operand_B = $random;
#10;
$display("BLTU- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);


  
ALU_Control= 6'b010111;
operand_A = $random;
operand_B = $random;
#10;
$display("BGEU- ALU control is %b",ALU_Control);
  $display("Branch_taken %d", Branch_taken);
  $display("pc_s_a_1: %b", pc_s_a_1);
  $display("ex: %b", ex);
  $display("Zero: %b", zero);


// Signed Less Than (SLTI, SLT)
  ALU_Control =6'b000010;
  operand_A = $random;
operand_B = $random;
#10;
// Display the outputs
    $display("ALU_Control: %d", ALU_Control);
    $display("operand_A: %d", operand_A);
    $display("operand_B: %d", operand_B);
    $display("ALU_result: %d", ALU_result);



//random cases 
ALU_Control= $random;
operand_A = $random;
operand_B = $random;
#10;
// Display the outputs
    $display("ALU_Control: %d", ALU_Control);
    $display("operand_A: %d", operand_A);
    $display("operand_B: %d", operand_B);
    $display("ALU_result: %d", ALU_result);
    $display("Zero: %b", zero);
    $display("Branch_taken %d", Branch_taken);
    $display("pc_s_a_1: %b", pc_s_a_1);
    $display("ex: %b", ex);
    $display("JALR_target %d", JALR_target);
    $display("hold_pipeline %d", hold_pipeline);


//random cases 
ALU_Control= $random;
operand_A = $random;
operand_B = $random;
#10;
// Display the outputs
    $display("ALU_Control: %d", ALU_Control);
    $display("operand_A: %d", operand_A);
    $display("operand_B: %d", operand_B);
    $display("ALU_result: %d", ALU_result);
    $display("Zero: %b", zero);
    $display("Branch_taken %d", Branch_taken);
    $display("pc_s_a_1: %b", pc_s_a_1);
    $display("ex: %b", ex);
    $display("JALR_target %d", JALR_target);
    $display("hold_pipeline %d", hold_pipeline);


//random cases 
ALU_Control= $random;
operand_A = $random;
operand_B = $random;
#10;
// Display the outputs
    $display("ALU_Control: %d", ALU_Control);
    $display("operand_A: %d", operand_A);
    $display("operand_B: %d", operand_B);
    $display("ALU_result: %d", ALU_result);
    $display("Zero: %b", zero);
    $display("Branch_taken %d", Branch_taken);
    $display("pc_s_a_1: %b", pc_s_a_1);
    $display("ex: %b", ex);
    $display("JALR_target %d", JALR_target);
    $display("hold_pipeline %d", hold_pipeline);





  // Signed Less Than (SLTI, SLT)
  ALU_Control =6'b000010;
  operand_A = -1246;
operand_B = 789;
#10;
// Display the outputs
    $display("ALU_Control: %d", ALU_Control);
    $display("operand_A: %d", operand_A);
    $display("operand_B: %d", operand_B);
    $display("ALU_result: %d", ALU_result);
   


end

  endmodule