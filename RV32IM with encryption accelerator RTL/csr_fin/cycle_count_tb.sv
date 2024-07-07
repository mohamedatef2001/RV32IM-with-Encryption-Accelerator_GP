module cycle_count_tb ();
  parameter COUNT_LEN = 64;

  //declaration
    bit clk;
    bit rst_n;

    logic [COUNT_LEN-1:0] data;
    logic [COUNT_LEN-1:0] cycle_out;

   //instatiation
   cycle_counter DUT (.clk(clk), .rst_n(rst_n), .data(data), .cycle_out(cycle_out));

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
    	#10 

    	//test ability to count ahead
    	rst_n = 1; data = 0;
    	#10 

    	//test ability to take data and count ahead
    	rst_n = 1; data = 12;
    	#4

    	//test ability to take data and count ahead
    	rst_n = 1; data = 0;
    	#10

    	#10;
    	 $stop;
    end
endmodule : cycle_count_tb 

