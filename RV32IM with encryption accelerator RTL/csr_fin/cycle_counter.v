module cycle_counter 

   #(parameter COUNT_LEN = 64)
   
   (input clk,
    input rst_n,
    input [COUNT_LEN-1:0] data,
    output reg [COUNT_LEN-1:0] cycle_out);


always @(posedge clk or negedge rst_n) begin
   if (!rst_n)
   cycle_out = 0;

   else if (|data) begin
      cycle_out = data;
       if (clk) cycle_out = cycle_out+1;
   end

   else  cycle_out = cycle_out+1;
end
endmodule 