///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    SM4_top                                                    //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   TOP_MODULE                                                  //
////////////////////////////////////////////////////////////////////////////////
module SM4_DATA_top (
  input         CLK          ,
  input         REST         ,
  input         VALID_IN     ,
  input  [31:0] INITIAL_KEY  ,
  input  [31:0] MESSAGE      ,
  output        HOLD_PIPLINE ,
  output        SAVE_DATA    ,
  output [127:0]RESULT_31    
  );
  
  //---------------------------------------------------//
  
 // wire [127:0] RESULT            ;
  wire [127:0] INITIAL_DATA      ;
  wire [127:0] DATA_TRANSFORM    ;
  wire [127:0] PADDED_KEY        ;
  wire [127:0] KEY_TRANSFORM     ;
 // wire [127:0] DATA              ;
  wire [5:0]   COUNTER_CONECTION ;
  wire [127:0] DATA_IN_ENC       ;
  wire [127:0] KEY_IN_ENC        ;
  wire [31:0]  RK_I              ;
  wire [31:0]  CK_I              ;
  
  //---------------------------------------------------//
  
  SM4_CONTROLLER u_1 
  (
    .clk(CLK)                    ,
    .valid_in(VALID_IN)          , 
    .rest(REST)                  ,
    .hold_pipline(HOLD_PIPLINE)  ,
    .save_data(SAVE_DATA)        ,
    .counter(COUNTER_CONECTION)
  );
  //----------------------------------------------------//
  
  mux u_2
  ( 
    .sm4_enc(COUNTER_CONECTION)    ,
    .clk(CLK)                      ,
    .rest(REST)                    ,
    .intial_data(INITIAL_DATA)     ,
    .data_transform(DATA_TRANSFORM),
    .mux_out(DATA_IN_ENC)
  );
  //-----------------------------------------------------//
  
  mux u_3
  ( 
    .sm4_enc(COUNTER_CONECTION)    ,
    .clk(CLK)                      ,
    .rest(REST)                    ,
    .intial_data(PADDED_KEY)       ,
    .data_transform(KEY_TRANSFORM) ,
    .mux_out(KEY_IN_ENC)
  );
  //-----------------------------------------------------//
  
  SM4_DATA_ENC u_4
  (
    .data_in(DATA_IN_ENC)          ,
    .counter(COUNTER_CONECTION)    ,
    .rk_i(RK_I)                    ,
    .result_out(DATA_TRANSFORM)    ,
    .reversed_result_finish(RESULT_31)
  );
  
  //----------------------------------------------------//
  
  message_padding u_5
  (
    .message_in(MESSAGE)           ,
    .messsage_out(INITIAL_DATA)    
  );
  
  //------------------------------------------------------//
  
  key_padding u_6
  (
   .key_in (INITIAL_KEY)          ,
   .key_out(PADDED_KEY) 
  );
  
  //------------------------------------------------------//
  
  one_round_for_key_exp u_7 
  (
   .data_in(KEY_IN_ENC)               ,
   .ck_parameter_in(CK_I)             ,
   .count_round_in(COUNTER_CONECTION) ,
   .result_out(KEY_TRANSFORM)         ,
   .rk_o(RK_I)
  );
  
  
  //-------------------------------------------------------//
  
  get_cki u_8 
  (  
    .cki_out(CK_I)                    ,
    .count_round_in(COUNTER_CONECTION),
    .clk(CLK) 
  
  );
  //-------------------------------------------------------//
 
endmodule
  
  



