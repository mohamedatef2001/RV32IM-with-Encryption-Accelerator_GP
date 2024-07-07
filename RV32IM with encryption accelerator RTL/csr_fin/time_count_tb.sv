module time_count_tb ();
  parameter COUNT_LEN = 64;

  //declaration
    bit clk;
    bit rst_n;
    logic [COUNT_LEN-1:0] data;
    logic [COUNT_LEN-1:0] real_time_out;

  //instatiation
   real_time_counter DUT (.clk(clk), .rst_n(rst_n), .data(data), .real_time_out(real_time_out));

  //clk generation
    initial begin
      clk = 0;
      forever
      #1 clk = ~clk;
    end 

  //stimulus
    initial begin
      //test reset priority
      rst_n = 0; data = $random; 
      #10  //real_time_out = 0

      //test taking data
      rst_n = 1; data = 100;
      #2  //real_time_out = 100

      //test regular count
      rst_n = 1; data = 0;
      #1000000000

      //test regular count
      rst_n = 1; data = 0;
      #1000000000
      #1000000000

       #10;
       $stop;
    end

endmodule : time_count_tb  
