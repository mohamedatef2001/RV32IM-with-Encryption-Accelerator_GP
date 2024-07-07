module division_tb(); parameter length=32;
  
  reg [length-1:0] oper_a_tb,oper_b_tb;
  reg operation_tb,enable_div_tb;
 // wire divided_by_zero_tb;
  wire [length-1:0] div_o_tb;
//  wire div_finish_tb;
  
  
  division DUT(
  .oper_a(oper_a_tb),
  .oper_b(oper_b_tb),
  .operation(operation_tb),
  .enable_div(enable_div_tb),
  // .divided_by_zero(divided_by_zero_tb),
  .div_o(div_o_tb));
 // .div_finish(div_finish_tb));
  
  
  
  initial
  begin
    enable_div_tb='b0;
    operation_tb=1'b1;
    oper_a_tb='d7;
    oper_b_tb='d3;
    #5  enable_div_tb='b1;
    #5 operation_tb=1'b0;
    #5 oper_a_tb=-'d7; operation_tb=1'b1;
    #5 operation_tb=1'b0;
    #5  oper_a_tb='d7; oper_b_tb=-'d3; operation_tb=1'b1;
    #5  operation_tb=1'b0;
    #5  oper_a_tb=-'d7; oper_b_tb=-'d3; operation_tb=1'b1;
    #5  operation_tb=1'b0;
    #5  oper_a_tb=-'d7; oper_b_tb='d0; operation_tb=1'b1;
    #5  operation_tb=1'b0;
    #5  oper_a_tb='d3025; oper_b_tb='d12; operation_tb=1'b1;
    #5  operation_tb=1'b0;
    #5  oper_a_tb='d18; oper_b_tb='d6; operation_tb=1'b1;
    #5  operation_tb=1'b0;
    #5  oper_a_tb='h7139d764; oper_b_tb='h519e1e33; operation_tb=1'b1;
      #5  operation_tb=1'b0;
      #5  oper_a_tb='h79645efb; oper_b_tb='h24af67de; operation_tb=1'b1;
      #5  operation_tb=1'b0;
      #5  oper_a_tb='ha9d64154; oper_b_tb='hd98825ed; operation_tb=1'b1;
      #5  operation_tb=1'b0;
    #5
    
    $finish;
  end
  
  
  
endmodule
    
    
  
 
 
 
 
 
 
  