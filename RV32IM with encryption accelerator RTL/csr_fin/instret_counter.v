module instret_counter 

   #(parameter COUNT_LEN = 64)
   
   (input clk,
    input rst_n,
    input instruction_exc, //from decoder
    input [COUNT_LEN-1:0] data,
    output reg [COUNT_LEN-1:0] instret_out);


always @(posedge clk or negedge rst_n) begin
   if (!rst_n) instret_out = 0;

   else if (|data) begin
      instret_out = data;
      if (instruction_exc) instret_out = instret_out+1;
   end   

   else if (instruction_exc)
      instret_out = instret_out+1;

end
endmodule 