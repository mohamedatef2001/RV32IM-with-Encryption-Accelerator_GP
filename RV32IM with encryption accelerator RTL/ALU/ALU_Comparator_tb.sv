module ALU_Comparator_Testbench;
  // Parameters
  parameter data_width = 32;

  // Inputs
  logic signed [data_width-1:0] operand_A;
  logic signed [data_width-1:0] operand_B;

  // Outputs
  logic Greater;
  logic Equal;
  logic Less;

  // Instantiate the ALU_Comparator module
  ALU_Comparator #(data_width) dut(
    .operand_A(operand_A),
    .operand_B(operand_B),
    .Greater(Greater),
    .Equal(Equal),
    .Less(Less)
  );


  // Testbench logic
  initial begin
    // Initialize inputs
    operand_A = 0;
    operand_B = 0;

    // Wait for some time for stability
    #10;

    // Test case 1: directed test
    operand_A = 5;
    operand_B = 3;
    #10;
    $display("Test case 1: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);



    // Test case 2: directed test
    operand_A = -655;
    operand_B = 3;
    #10;
    $display("Test case 2: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);


    // Test case 3: directed test
    operand_A = 255;
    operand_B = -343;
    #10;
    $display("Test case 3: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);


    // Test case 4: directed test
    operand_A = -11;
    operand_B = -346;
    #10;
    $display("Test case 4: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);


    // Test case 5: directed test
    operand_A = 8995;
    operand_B = 5433;
    #10;
    $display("Test case 5: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);

    // Test case 6: randomized test
     operand_A=$random;
     operand_B=$random;
       #10;
    $display("Test case 6: operand_A = %d, operand_B = %d", operand_A, operand_B);
    $display("Greater = %b, Equal = %b, Less = %b", Greater, Equal, Less);  
 
end
endmodule