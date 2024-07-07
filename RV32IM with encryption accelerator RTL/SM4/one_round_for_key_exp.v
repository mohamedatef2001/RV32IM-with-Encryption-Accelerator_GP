///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef    - mohamedatefp3@gmail.com                  //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    one_round_for_key_exp                                      //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   initializaation of the key                                  //
////////////////////////////////////////////////////////////////////////////////

module one_round_for_key_exp (
	

input	[127 : 0]	data_in,
input	[31  : 0]	ck_parameter_in,
input [5   : 0] 	count_round_in,
output	[31:0]	rk_o,
output	[127 : 0]	result_out
);


localparam FK0	=	32'ha3b1bac6;
localparam FK1	=	32'h56aa3350;
localparam FK2	=	32'h677d9197;
localparam FK3	=	32'hb27022dc;

wire	[31:0]	word_0;
wire	[31:0]	word_1;
wire	[31:0]	word_2;
wire	[31:0]	word_3;
wire	[31:0]	tmp_0;
wire	[31:0]	tmp_1;
wire	[31:0]	data_for_xor;
wire	[31:0]	data_for_transform;
wire	[31:0]	data_after_transform_key;
wire	[31:0]	k0;
wire	[31:0]	k1;
wire	[31:0]	k2;
wire	[31:0]	k3;



assign {word_0 , word_1 , word_2 , word_3} = data_in;

assign data_for_xor = ck_parameter_in ;


assign k0 = word_0 ^ FK0 ;
assign k1 = word_1 ^ FK1 ;
assign k2 = word_2 ^ FK2 ;
assign k3 = word_3 ^ FK3 ;

assign tmp_0 = count_round_in == 'd1 ? k1^k2           : word_1 ^ word_2 ;
assign tmp_1 = count_round_in == 'd1 ? k3^data_for_xor : word_3 ^ data_for_xor ;

assign data_for_transform = tmp_0 ^ tmp_1 ;
assign rk_o = count_round_in == 'd1 ?  k0 ^ data_after_transform_key : word_0 ^ data_after_transform_key ;
assign result_out = count_round_in == 'd1 ? {k1 , k2 , k3 , k0 ^ data_after_transform_key} : {word_1 , word_2 , word_3 , word_0 ^ data_after_transform_key};

Transform_for_key_exp U0 (

   .data_in(data_for_transform),
   .data_out(data_after_transform_key)

);


endmodule