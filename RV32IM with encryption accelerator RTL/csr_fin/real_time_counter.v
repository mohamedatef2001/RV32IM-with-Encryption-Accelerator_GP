module real_time_counter 

   #(parameter COUNT_LEN = 64)
   
   (input clk,
    input rst_n,
    input [COUNT_LEN-1:0] data,
    output reg [COUNT_LEN-1:0] real_time_out);

reg  seconds;
reg [31:0] nsec_time;


always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin
    nsec_time <= 0;
    seconds   <= 0;  
   end


   else begin
      nsec_time <= nsec_time+1; 
      if (nsec_time == 32'h3B9ACA00) begin  seconds <= 1; nsec_time <= 0; end 
      else seconds <= 0;
  end
end
  

always @(posedge clk or negedge rst_n) begin
   if (!rst_n) begin
      real_time_out = 0;
   end
   else if (|data) begin
      real_time_out = data;
      real_time_out = real_time_out+1;
   end
   else if (seconds) begin
      real_time_out = real_time_out+1;
   end
end

endmodule 