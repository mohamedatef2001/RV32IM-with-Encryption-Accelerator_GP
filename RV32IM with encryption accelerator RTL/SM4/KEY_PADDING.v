///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    key_padding                                                //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   Extend key into 128 bit                                     //
////////////////////////////////////////////////////////////////////////////////
module key_padding 
  (
  input [31:0] key_in  ,
  output[127:0]key_out
  );
  
 // assign key_out = {key_in , 1'b1 , 63'b0 , 32'b100000} ;
  assign key_out = {key_in , 96'h89abcdeffedcba9876543210} ;
  
endmodule 
    


