//data memory 32-bit address

module Data_Memory (
    input logic [31:0] dm_in,
    input logic[31:0] address,
    input logic write_en, clk, reset,
    output logic[31:0] dm_out
);

logic [31:0] data_mem [1023 : 0];

integer i;

always @(posedge clk or posedge reset) begin 
    if (reset) begin //reset
        dm_out <=0;
      for (i = 0; i < 1024; i = i + 1)
        data_mem[i] <= 0;
    end else begin
      if (write_en) //write
        data_mem[address] <= dm_in;
    end
    //read
    dm_out = data_mem[address];
  end



endmodule