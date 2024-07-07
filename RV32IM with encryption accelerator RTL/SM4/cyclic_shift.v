///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    Cycle_Shift                                                //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   Routet Left data_in Specific Number                          //
////////////////////////////////////////////////////////////////////////////////
module cyclic_shift 
  (
  input [31:0] data_in        ,
  output wire [31:0] data_out
  );
  
  assign	data_out = ( 	 (data_in ^ {data_in[29:0], data_in[31:30]}) 
                       ^({data_in[21:0], data_in[31:22]} ^ {data_in[13:0], data_in[31:14]})) 
				               ^{data_in[7:0], data_in[31:8]};
	endmodule
