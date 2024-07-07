///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef    - mohamedatefp3@gmail.com                  //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    tb_one_round_for_key_exp                                   //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   TB                                                          //
////////////////////////////////////////////////////////////////////////////////

module tb_one_round_for_key_exp ();
reg	[127 : 0]	data_in_tb;
reg	[31  : 0]	ck_parameter_in_tb;
reg [5   : 0] 	count_round_in_tb;
wire	[31:0]	rk_o_tb;
wire	[127 : 0]	result_out_tb;



one_round_for_key_exp one_round_for_key_exp (
.data_in(data_in_tb),
.ck_parameter_in(ck_parameter_in_tb),
.count_round_in(count_round_in_tb),
.rk_o(rk_o_tb),
.result_out(result_out_tb)
);




initial 
begin
  data_in_tb = 'h0123456789abcdeffedcba9876543210 ;
  ck_parameter_in_tb ='h00070e15;
  count_round_in_tb = 0;
  #20
  
   
  $finish;
  
end
endmodule
  
