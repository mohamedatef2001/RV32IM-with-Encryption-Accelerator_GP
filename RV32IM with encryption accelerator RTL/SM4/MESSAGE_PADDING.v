///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef    - mohamedatefp3@gmail.com                  //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    message_padding                                            //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   Extend message into 128 bit                                 //
////////////////////////////////////////////////////////////////////////////////
module message_padding 
  (
  input [31:0] message_in  ,
  output[127:0]messsage_out
  );
  //assign messsage_out = {message_in , 1'b1 , 63'b0 , 32'b100000} ;
  
  assign messsage_out = {message_in , 96'h89abcdeffedcba9876543210} ;
  
endmodule 
    
