///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    MUX                                                        //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   Selction                                                    //
////////////////////////////////////////////////////////////////////////////////
module mux 
  (
  input      [5:0]   sm4_enc         ,
  input              clk             ,
  input              rest            ,
  input      [127:0] intial_data     ,
  input      [127:0] data_transform  ,
  output reg [127:0] mux_out  
  );
  
  
always@(posedge clk or negedge rest)
begin
  if(sm4_enc == 'd0 )
    mux_out <= intial_data ;
  else
     mux_out <= data_transform ;
end
endmodule
       

