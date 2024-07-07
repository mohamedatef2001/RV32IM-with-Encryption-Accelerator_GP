module mult_radix8 #(parameter length=32)(
  
  
  input logic signed [length:0] partial1_booth, partial2_booth, partial3_booth, partial4_booth,
  input logic signed [length:0] partial5_booth, partial6_booth, partial7_booth, partial8_booth,   
  input logic signed [length:0] partial9_booth, partial10_booth, partial11_booth, partial12_booth,
  input logic signed [length:0] partial13_booth, partial14_booth, partial15_booth, partial16_booth,
  input logic enable_mult,
  input logic operation,                          ////to know it's mul or mulh
  output logic signed [length-1:0] mult_o,
  output logic  mult_finish);
  
  
  logic [2*length-1:0]  partial_product1,partial_product2,partial_product3,partial_product4; // define 64_bit 
  logic [2*length-1:0]  partial_product5,partial_product6,partial_product7,partial_product8;
  logic [2*length-1:0]  partial_product9,partial_product10,partial_product11,partial_product12;
  logic [2*length-1:0]  partial_product13,partial_product14,partial_product15,partial_product16;
  
   
  
  
  assign partial_product1={{31{partial1_booth[length]}},partial1_booth};        // { copy MSB of partial1_booth 33 --> 63 , partial1_booth 0-->32}
  assign partial_product2={{29{partial2_booth[length]}},partial2_booth,2'b0};   // { copy MSB of partial1_booth 35 --> 63 , partial1_booth 0-->32}
  assign partial_product3={{27{partial3_booth[length]}},partial3_booth,4'b0};
  assign partial_product4={{25{partial4_booth[length]}},partial4_booth,6'b0};
  assign partial_product5={{23{partial5_booth[length]}},partial5_booth,8'b0};
  assign partial_product6={{21{partial6_booth[length]}},partial6_booth,10'b0};
  assign partial_product7={{19{partial7_booth[length]}},partial7_booth,12'b0};
  assign partial_product8={{17{partial8_booth[length]}},partial8_booth,14'b0};
  assign partial_product9={{15{partial9_booth[length]}},partial9_booth,16'b0};
  assign partial_product10={{13{partial10_booth[length]}},partial10_booth,18'b0};
  assign partial_product11={{11{partial11_booth[length]}},partial11_booth,20'b0};
  assign partial_product12={{9{partial12_booth[length]}},partial12_booth,22'b0};
  assign partial_product13={{7{partial13_booth[length]}},partial13_booth,24'b0};
  assign partial_product14={{5{partial14_booth[length]}},partial14_booth,26'b0};
  assign partial_product15={{3{partial15_booth[length]}},partial15_booth,28'b0};
  assign partial_product16={{1{partial16_booth[length]}},partial16_booth,30'b0};
  logic [length*2-1:0] sum;
  logic [length*2-1:0] temp_sum;

  logic [length*2-1:0] sum_1;
 
  assign sum_1=sum;
 
 
integer i;

always@(*)
begin  
  sum='b0;
  temp_sum='b0;
  for (i=0 ;i<16;i=i+1)
  begin
    case(i)
      'd0 : sum=temp_sum+partial_product1;  
      'd1 : sum=temp_sum+partial_product2;
      'd2 : sum=temp_sum+partial_product3;
      'd3 : sum=temp_sum+partial_product4;
      'd4 : sum=temp_sum+partial_product5;
      'd5 : sum=temp_sum+partial_product6;
      'd6 : sum=temp_sum+partial_product7;
      'd7 : sum=temp_sum+partial_product8;
      'd8 : sum=temp_sum+partial_product9;
      'd9: sum=temp_sum+partial_product10;
      'd10: sum=temp_sum+partial_product11;
      'd11: sum=temp_sum+partial_product12;
      'd12: sum=temp_sum+partial_product13;
      'd13: sum=temp_sum+partial_product14;
      'd14: sum=temp_sum+partial_product15;
      'd15: sum=temp_sum+partial_product16;
      default: sum=0;
    endcase
    temp_sum=sum;
  end

   if(enable_mult)
      begin
    if(!operation)            ///////instruction is mul
      begin 
        mult_o=sum[length-1:0];
     //   mult_finish='b1;
      end
    else if (sum[2*length-1] )
          begin
            sum= sum+ 'b100000000000000000000000000000000;
        mult_o=sum[2*length-1:length];
      //  mult_finish='b1;
        
      end
    else
      begin
       mult_o=sum[2*length-1:length];
      //  mult_finish='b1;
      end
    end
    else
       begin
        mult_o='b0;
      //  mult_finish='b0;
        
      end
      
    end
  
endmodule