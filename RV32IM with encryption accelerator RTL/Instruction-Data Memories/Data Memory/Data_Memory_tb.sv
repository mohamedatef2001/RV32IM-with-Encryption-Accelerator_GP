//data memory 32-bit address test
//author:nada sofy

module Data_Memory_tb;
logic clk;
logic reset;
logic write_en;
logic [31:0] address;
logic [31:0] dm_in;
logic [31:0] dm_out;

Data_Memory DM(
    .clk(clk),
    .reset(reset),
    .write_en(write_en),
    .address(address),
    .dm_in(dm_in),
    .dm_out(dm_out)
);

 //clock generation
  initial begin
    clk = 0;
    forever #1 clk = ~clk;
  end

initial 
begin
    // Initialize inputs
     clk = 0;
     reset = 1;
     write_en = 0;
     address = 0;
     dm_in = 0;

    // Apply reset
     #20 reset = 0; 

    // Write to memory
     #20 write_en = 1; 
     #20 address = 5; 
     #20 dm_in = 32'hABCDEFF0; 
     #20 write_en = 0;  

    // Read from memory
     #20 write_en = 0; 
     #20 address = 5; 
 
end

always  
 #10 clk = ~clk; 

endmodule
