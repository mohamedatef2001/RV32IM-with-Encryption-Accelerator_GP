///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    Data_Encryption                                            //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //                                                   
////////////////////////////////////////////////////////////////////////////////
module SM4_DATA_ENC #(parameter DATA_IN_BITS = 128 , DATA_OUT_BITS = 128)
(
  
  input [DATA_IN_BITS-1:0]   data_in                ,
  input [31:0]               rk_i                   ,
  input [5:0]                counter                ,
  output[DATA_OUT_BITS-1:0]  result_out             ,
  output[DATA_OUT_BITS-1:0]  reversed_result_finish        
);

wire [31:0] x0,x1,x2,x3                       ;
wire [31:0] word_0,word_1,word_2,word_3       ;
wire [7:0]  byte_0 , byte_1                   ;
wire	[7:0]  byte_2 , byte_3                   ;
wire	[7:0] 	byte_0_replaced ,byte_1_replaced  ;
wire	[7:0]  byte_2_replaced ,byte_3_replaced  ;
wire [31:0] word_replaced                     ;
wire [31:0] tmp_0                             ;
wire [31:0] tmp_1                             ;
wire [31:0] data_after_sbox                   ;
wire [127:0]result_finish                     ;
wire [31:0] result_after_shift                ;

//divides bits to x0 , x1 , x2 , x3 then prepare data for sbox

assign {x0 , x1 , x2 , x3} = data_in          ;
assign tmp_0               = x1^x2            ;
assign tmp_1               = x3^rk_i          ;
assign data_after_sbox     = tmp_0 ^ tmp_1    ;
//------------------------------------------------------------//
assign {byte_0 , byte_1 , byte_2 , byte_3 } = data_after_sbox ;

//------------------------------------------------------------//
/*
Transform_for_key_exp d_1 
(
  .data_out(rk_i)   
) ;
*/
//------------------------------------------------------------//
sbox_replace	u_0
	(
		.data_in(byte_0),
		.result_out(byte_0_replaced)														
	);
	
sbox_replace	u_1
	(
		.data_in(byte_1),
		.result_out(byte_1_replaced)														
	);
	
sbox_replace	u_2
	(
		.data_in(byte_2),
		.result_out(byte_2_replaced)														
	);
	
sbox_replace	u_3
	(
		.data_in(byte_3),
		.result_out(byte_3_replaced)														
	);	

assign	word_replaced = {byte_0_replaced, byte_1_replaced, byte_2_replaced,byte_3_replaced};
//-------------------------------------------------------------------------------------------//

cyclic_shift	u_5
	(
		.data_in(word_replaced),
		.data_out(result_after_shift)														
	);
	
assign	result_out = {x1 , x2 , x3 , result_after_shift^x0} ;
assign result_finish = counter == 'd32 ? result_out : 'd0  ; 
assign { word_0, word_1, word_2, word_3} = result_finish   ;
assign reversed_result_finish = {word_3, word_2, word_1, word_0};

 
endmodule