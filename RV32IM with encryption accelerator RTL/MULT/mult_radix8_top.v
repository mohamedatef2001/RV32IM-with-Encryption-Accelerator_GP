module mult_radix8_top #(parameter length=32)(
  input wire [length-1:0] oper_a,oper_b,
  input wire  enable_mult,operation,
  output wire [length-1:0] mult_o);
 // output wire  mult_finish);
  
  
   wire  [length:0] partial1_booth, partial2_booth, partial3_booth, partial4_booth;
   wire  [length:0] partial5_booth, partial6_booth, partial7_booth, partial8_booth;   
   wire  [length:0] partial9_booth, partial10_booth, partial11_booth, partial12_booth;
   wire  [length:0] partial13_booth, partial14_booth, partial15_booth, partial16_booth;

   
   
  
  
  
  booth b1 (
  .oper_a(oper_a),
  .oper_b(oper_b),
  .enable_mult(enable_mult),
  .partial1_booth(partial1_booth),
  .partial2_booth(partial2_booth),
  .partial3_booth(partial3_booth),
  .partial4_booth(partial4_booth),
  .partial5_booth(partial5_booth),
  .partial6_booth(partial6_booth),
  .partial7_booth(partial7_booth),
  .partial8_booth(partial8_booth),
  .partial9_booth(partial9_booth),
  .partial10_booth(partial10_booth),
  .partial11_booth(partial11_booth),
  .partial12_booth(partial12_booth),
  .partial13_booth(partial13_booth),
  .partial14_booth(partial14_booth),
  .partial15_booth(partial15_booth),
  .partial16_booth(partial16_booth));
  
  
  
  mult_radix8 m1 (
  .partial1_booth(partial1_booth),
  .partial2_booth(partial2_booth),
  .partial3_booth(partial3_booth),
  .partial4_booth(partial4_booth),
  .partial5_booth(partial5_booth),
  .partial6_booth(partial6_booth),
  .partial7_booth(partial7_booth),
  .partial8_booth(partial8_booth),
  .partial9_booth(partial9_booth),
  .partial10_booth(partial10_booth),
  .partial11_booth(partial11_booth),
  .partial12_booth(partial12_booth),
  .partial13_booth(partial13_booth),
  .partial14_booth(partial14_booth),
  .partial15_booth(partial15_booth),
  .partial16_booth(partial16_booth),
  .enable_mult(enable_mult),
  .operation(operation),
  .mult_o(mult_o));
  //.mult_finish(mult_finish));
  
  
endmodule
