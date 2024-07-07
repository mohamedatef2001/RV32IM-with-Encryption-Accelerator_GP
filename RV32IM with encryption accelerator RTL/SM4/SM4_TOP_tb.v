///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    SM4_top                                                    //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   TOP_MODULE_TB                                                  //
////////////////////////////////////////////////////////////////////////////////

module SM4_TOP_tb ();

  reg         CLK_tb            ;
  reg         REST_tb           ;
  reg         VALID_IN_tb       ;
  reg  [31:0] INITIAL_KEY_tb    ;
  reg  [31:0] MESSAGE_tb        ;
  wire        HOLD_PIPLINE_tb   ;
  wire [127:0]RESULT_31_tb      ;
  wire        save_data_tb      ;
  
  
  SM4_DATA_top DUT (
  .CLK(CLK_tb)                  , 
  .REST(REST_tb)                ,
  .VALID_IN(VALID_IN_tb)        ,
  .INITIAL_KEY(INITIAL_KEY_tb)  ,
  .MESSAGE(MESSAGE_tb)          ,
  .HOLD_PIPLINE(HOLD_PIPLINE_tb),
  .SAVE_DATA(save_data_tb)      ,
  .RESULT_31(RESULT_31_tb)
  );
 

always #10 CLK_tb = ! CLK_tb ;

initial 
begin 
CLK_tb  = 'd1;
REST_tb = 'd0;
VALID_IN_tb = 'd0;
INITIAL_KEY_tb = 'h01234567;
MESSAGE_tb = 'h01234567;
#10 
REST_tb = 'd1;
#10
VALID_IN_tb = 'd1;
//CLK_tb  = 'd1;
#640
VALID_IN_tb = 'd0;
#40
$finish;






end 






endmodule







