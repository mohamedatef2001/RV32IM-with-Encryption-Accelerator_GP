///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    Decoder                                                    //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The decoder in zero-riscy is responsible for               //
// decoding the instruction fetched from the                                  //
// instruction memory and generating the selection signals                    //                                                                            //
////////////////////////////////////////////////////////////////////////////////
         
module Decoder #( parameter ADDRESS_BITS = 32 )
(

//inputs form fetch module 
input [ADDRESS_BITS-1:0] pc         ,
//input [ADDRESS_BITS-1:0] pc_next    ,
input [31:0] instruction            ,


//inputs from Encryption
input out_of_loop_i                 ,
//inputs from alu
//input [ADDRESS_BITS-1:0] JALR_target,
input branch                        ,

//output to fetch module 
output [ADDRESS_BITS-1:0] target_pc ,  
output                    pc_s_d    ,
 

//outputs to controller 
output [6:0] op                     ,
output [2:0] funct3                 , 
output [6:0] funct7                 , 
output       flag                   ,

//output to GPRs 
output [4:0] read_sel1              ,
output [4:0] read_sel2              ,
output [4:0] write_sel              ,
output reg   wen                    ,

//outputs to Pipeline Register
output [31:0] imm32                 ,
output [11:0] imm12                  //*****
//output [ADDRESS_BITS-1:0] pc_next_o ,
//output [ADDRESS_BITS-1:0] pc_o       
              
);

//op of the instruction
localparam [6:0] R_TYPE     = 7'b0110011,
                 I_TYPE     = 7'b0010011,
                 Load       = 7'b0000011, 
                 STORE      = 7'b0100011,
                 JALR       = 7'b1100111,
                 jAL        = 7'b1101111, 
                 BRANCH     = 7'b1100011,
                 ENCRYPTION = 7'b0001011;
                 
                
wire [11:0] i_imm                   ; //original 12 bit of the i-type imm instruction
wire [31:0] i_imm_ext               ; //sign extend

wire [4:0]  s_imm_lsb               ; //original lsb 5 bit of the s-type imm instruction
wire [6:0]  s_imm_msb               ; //original msb 7 bit of the s-type imm instruction 
wire [11:0] s_imm                   ; //{s_imm_msb , s_imm_lsb}
wire [31:0] s_imm_ext               ; //sign extend

wire [3:0]  b_imm_lsb               ; //original lsb 4 bit of the b-type imm instruction
wire [5:0]  b_imm_msb               ; //original msb  bit of the s-type imm instruction 
wire [31:0] b_imm_ext               ; //sign extend

wire [20:0] j_imm                   ; //original (19 bit + 1'b0) of the j-type imm instruction
wire [31:0] j_imm_ext               ; //sign extend

wire [4:0]  shamt_imm               ; //original 5 bits of the imm instruction
wire [31:0] shamt_imm_ext           ; //sign extend

//read registers
assign read_sel1 = instruction[19:15]                 ;
assign read_sel2 = instruction[24:20]                 ;

//destination register
assign write_sel = instruction[11:7]                  ;

//decoding the instructon
assign op        = instruction[6:0]                   ;
assign funct3    = instruction[14:12]                 ;
assign funct7    = instruction[31:25]                 ;

//sign extend calculation
assign i_imm     = instruction[31:20]                 ;
assign i_imm_ext = {{20{i_imm[11]}} , i_imm }         ;

assign s_imm_lsb = instruction[11:7]                  ;
assign s_imm_msb = instruction[31:25]                 ;
assign s_imm     = {s_imm_msb , s_imm_lsb }           ;
assign s_imm_ext = {{20{s_imm[11]}} , s_imm }     ;

assign b_imm_lsb = instruction[11:8]                  ;
assign b_imm_msb = instruction[30:25]                 ;
assign b_imm_ext = {{20{instruction[31]}} , instruction[7] , b_imm_msb , b_imm_lsb , 1'b0 } ;

assign j_imm     = {instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0};
assign j_imm_ext = {{11{j_imm[20]}} , j_imm }         ;

assign shamt_imm = instruction[24:20]                 ;
assign shamt_imm_ext = {27'b0 , shamt_imm }           ;

//assign pc_o      = pc                                 ;                   //to Pipeline Register
//assign pc_next_o = pc_next                            ;                   //to Pipeline Register
//assign suspended = (op == 7'b1100111) && (read_sel1 != 'd0) ? 'd1 : 0;  //to fetch module
assign imm12     = i_imm ;  

                               
assign imm32 =  (op == 7'b0010011 && funct3 == 3'b001)? shamt_imm_ext:  //SLLI
		(op == 7'b0010011 && funct3 == 3'b101)? shamt_imm_ext:  //SRLI , SRAI
                (op == 7'b0000011 ) ? i_imm_ext : //load instruction
                (op==  7'b0010011 ) ? i_imm_ext : //i-type
                (op == 7'b0100011 ) ? s_imm_ext : //store instruction
                (op == 7'b1100011 ) ? b_imm_ext : //branch instruction
                (op == 7'b1101111 ) ? j_imm_ext : //jump and link instruction
                (op == 7'b1100111 ) ? i_imm_ext : //jump and link instruction register
                0;
               
               
assign target_pc = (op == 7'b1101111)  ? (pc + j_imm_ext) : //jal instruction 
                   
                   //Static Prediction
                   (op == 7'b1100011) && (branch || instruction[7]) ? (pc + b_imm_ext) : //branch instructions
                   (op == 7'b1100111) && (read_sel1 == 'd0)         ? j_imm_ext        : //JALR
                   (op  == 7'b0001011)                              ? pc               :
                    0; 
 
 
 assign pc_s_d   =  (op  == 7'b1101111) ? 1'b1                                :// selection for correct prediction of jal instructions 
                    ((op == 7'b1100011) && (branch || instruction[7]))  ? 1'b1 :// selection for correct prediction of branch instructions 
                    ((op == 7'b1100111) && (read_sel1 == 'd0))          ? 1'b1 :// selection for correct prediction of JALR instructions 
                    ((op == 7'b0001011) &&  (!out_of_loop_i))           ? pc   :// hold pipline while encryption
                    ((op == 7'b0001011) &&  (out_of_loop_i))            ? 1'b0 :
                    0;
                           
 assign flag     =  (op  == 7'b1100111) && (read_sel1 != 'd0)          ? 1'b0 :// selection for false prediction of JALR instructions
                     1; 
                   
always@(*)
begin
wen = 1  ;
      case(op)
                  
        STORE:     begin 
                                        wen       = 0 ;
                   end
              
        BRANCH:    begin 
                                        wen       = 0 ;
                   end  
                      
        ENCRYPTION:begin
                                        wen       = 0 ;
                   end
        
        JALR      :begin
                         if (write_sel == 'd0)
                           begin
                                       wen       = 0 ;
                            end   
                          else
                           begin
                                       wen       = 1 ;
                           end
                   end
                   
        default :begin
                                        wen       = 1 ;
                 end
      endcase
end
endmodule
                        
          
                                        
