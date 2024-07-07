module mult_radix8_tb (); parameter length =32;
  
  
  reg [length-1:0] oper_a_tb,oper_b_tb;
  reg  enable_mult_tb,operation_tb;
  wire [length-1:0] mult_o_tb;
 // wire  mult_finish_tb;
  
  
  mult_radix8_top DUT (
  .oper_a(oper_a_tb),
  .oper_b(oper_b_tb),
  .enable_mult(enable_mult_tb),
  .operation(operation_tb),
  .mult_o(mult_o_tb));
  //.mult_finish(mult_finish_tb));
  
  
  
  
  initial 
  begin
    oper_a_tb='b011;
    oper_b_tb='b01000;
    enable_mult_tb='b0;
    operation_tb='b0;
    
    #5   enable_mult_tb='b1;
    #5   operation_tb='b1;
    #5 operation_tb='b0;     oper_a_tb=-'d8;      oper_b_tb=-'d3;
    #5                   oper_a_tb='d8;       oper_b_tb=-'d3;
    #5   operation_tb='b1;
    #5 operation_tb='b0;     oper_a_tb=-'d8;      oper_b_tb='d3;
    #5                   oper_a_tb='d234;     oper_b_tb='d277;
    #5                   oper_a_tb=-'d234;    oper_b_tb='d277;
  
    #5                   oper_a_tb='d555;     oper_b_tb='d555;
    #5                   oper_a_tb='h88ea7a2;     oper_b_tb='hfc44b4c2;
    #5         
  
    $finish;
  end
    
  
    
    
    
  
  
  
endmodule

