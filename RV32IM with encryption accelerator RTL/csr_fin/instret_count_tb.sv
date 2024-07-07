module instret_count_tb ();
  parameter COUNT_LEN = 64;

  //declaration
    bit clk;
    bit rst_n;
    bit instruction_exc;
    logic [COUNT_LEN-1:0] data;
    logic [COUNT_LEN-1:0] instret_out;

  //instatiation
   instret_counter DUT (.clk(clk), .rst_n(rst_n), .data(data), .instruction_exc(instruction_exc), .instret_out(instret_out));

  //clk generation
    initial begin
	   clk = 0;
	   forever
	   #1 clk = ~clk;
    end 

  //stimulus
    initial begin
      //test reset priority
      rst_n = 0; data = $random; instruction_exc = 1;
      #8 

      //test ability to count ahead
      rst_n = 1; data = 0; instruction_exc = 1;
      #2
      instruction_exc = 0; 
      #1
      instruction_exc = 1;
      #2

      //test ability to take data and count ahead
      rst_n = 1; data = 12; instruction_exc = 0;
      #2
      instruction_exc = 0; 
      #1
      instruction_exc = 1; 
      #2

      //test ability to count ahead
      rst_n = 1; data = 118; instruction_exc = 1;
      #4
      data = 0;

      #10;
       $stop;
    end

endmodule : instret_count_tb    