module Encryption_accellerator (

input [31:0]   message,
input [4:0]    rs2,
input [4:0]    rd,
input          m_sm3,
input          valid_in_sm3,
input          valid_in_sm4,
input          RST,
input          pull_key_en,
input          gated_clk,
output         hold_pipeline_sm3,
output         hold_pipeline_sm4,
output         out_of_loop_o,
output [383:0] encrypted,
output [255:0] hash_value
);
//-------------------------------------------------------------------------------//
wire [255:0] HASH_VALIE_TOP ;
wire [31:0]  KEY_FROM_MEM_TOP;
wire         SAVE_DATA_TOP   ;
wire [127:0] RESULT_31_TOP ;
wire         SAVE_HASH_TOP ;
wire         SAVE_DATA_O_TOP;


//sm3
sm3_top u_0
(
 .clk(gated_clk)                 ,
 .rst(RST)                       ,
 .message(message)               ,
 .valid_in(valid_in_sm3)         ,
 .m_sm3(m_sm3)                   ,
 .hash_value(HASH_VALIE_TOP)     ,
 .save_hash(SAVE_HASH_TOP)       ,
 .hold_pipline(hold_pipeline_sm3)  
 );
 
 
 // SM4
 
 SM4_DATA_top u_1 
 (
  .CLK(gated_clk)                  ,
  .REST(RST)                       ,
  .VALID_IN(valid_in_sm4)          ,
  .INITIAL_KEY(KEY_FROM_MEM_TOP)   ,
  .MESSAGE(message)                ,
  .HOLD_PIPLINE(hold_pipeline_sm4) ,
  .SAVE_DATA(SAVE_DATA_TOP)        ,
  .RESULT_31(RESULT_31_TOP)  
 );
 
 
 // memory (data save) for sm3 and sm4
 
 DATA_SAVE u_2 
 (
    .clk(gated_clk),
    .rst(RST),
    .save_hash(SAVE_HASH_TOP),
    .save_data(SAVE_DATA_TOP),   //output flag from sm4 block after 32 clk to save encrypted data
    .pull_key_en(pull_key_en), //output from controller to wr the inatial key to sm4 block
    .in_hash(HASH_VALIE_TOP),     //input hash value 
    .in_data(RESULT_31_TOP),     //encrypted data value
    .address(rs2),     //address key  
    .rd(rd),          //addr of mem_data_save
    .key(KEY_FROM_MEM_TOP),
    .encrypted(encrypted)

) ;

assign out_of_loop_o = SAVE_DATA_TOP ;
endmodule