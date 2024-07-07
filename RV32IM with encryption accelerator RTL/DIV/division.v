module division #(parameter length=32)(
 input wire signed [length-1:0] oper_a,oper_b,
 input wire operation,enable_div,
 // output reg divided_by_zero,
 output reg [length-1:0] div_o);
// output reg div_finish);
 
 
 
 
 integer n;
 
 
 reg [length-1:0] dividend,divisor;  
 reg pos_output;
 reg [length-1:0] A=0;
 reg [2*length-1:0] AQ;
 reg [length-1:0] temp_A;
 reg sign;
 
 always@(*)
 begin                         ////////convert from signed to unsigned 
   if(oper_a[length-1]&&oper_b[length-1])          //////if 2 input negative output s positve
     begin
     pos_output=1'b1;                        
     dividend= (~{oper_a})+1'b1;
     divisor= (~{oper_b})+1'b1;
   end
 else if(oper_a[length-1])          //////if input a negative output is negative
    begin
     pos_output=1'b0;
     dividend= (~{oper_a})+1'b1;
     divisor=oper_b;
   end
 else if
   (oper_b[length-1]) //////if input b negative output is negativ
    begin
     pos_output=1'b0;
     dividend=oper_a;
     divisor= (~{oper_b}) +1'b1;
   end
 else           //////if 2 input postive output is postive
    begin
     pos_output=1'b1;
     dividend=oper_a;
     divisor=oper_b;
   end
   
  AQ={A,dividend}  ;    ///////put an initial value for A and dividend to make the flow chart
  for (n=0;n<32;n=n+1)
   begin
     AQ=AQ<<1;               // shift left AQ (A concatenate to Q)
     temp_A=AQ[2*length-1:length] - divisor;      // ACC = ACC(AQ) - M 
     if(!temp_A[length-1])
       begin
         AQ[2*length-1:length]=temp_A;
         AQ[0]=1;
     end
     else
       begin
         AQ[0]=0;
       end
 end
 if(enable_div)
   begin
     if(oper_b=='b0)
       begin
    //     divided_by_zero='b1;
       //  div_finish='b1;
         div_o='b0;
       end
   else if (operation&&pos_output)              ///////instruction is div result pos
     begin
     //    divided_by_zero='b0;
         div_o=AQ[length-1:0];
       //  div_finish='b1;
       end
     else if(operation&&!pos_output)        ////instruction is div result neg
        begin
     //    divided_by_zero='b0;
         div_o=~AQ[length-1:0]+1;
      //   div_finish='b1;
       end
        else if(!operation&&pos_output)       ///////instruction is rem result is pos
        begin
    //     divided_by_zero='b0;
         div_o=AQ[2*length-1:length];
    //     div_finish='b1;
       end
       
     else
       begin
    //     divided_by_zero='b0;
         div_o=~AQ[2*length-1:length]+1;
   //      div_finish='b1;
       end
     end
     else
        begin
       //  divided_by_zero='b0;
         div_o='b0;
     //    div_finish='b0;
       end
       
 end
 endmodule
   

