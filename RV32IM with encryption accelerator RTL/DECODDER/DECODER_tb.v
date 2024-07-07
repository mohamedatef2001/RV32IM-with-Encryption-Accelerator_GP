///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    DECODER_tb                                                 //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //                                                //
////////////////////////////////////////////////////////////////////////////////
module DECODER_tb ()        ;
parameter ADDRESS_BITS = 32 ;
  
//inputs form fetch module 
reg [ADDRESS_BITS-1:0] pc_tb         ;
reg [31:0]             instruction_tb;
reg [ADDRESS_BITS-1:0] pc_next_tb    ;

//inputs from alu
//reg [ADDRESS_BITS-1:0] JALR_target;
reg branch_tb                      ;
reg out_of_loop_i_tb                 ;

//output to fetch module 
wire [ADDRESS_BITS-1:0] target_pc_tb ;  

//outputs to controller 
wire [6:0] op_tb                     ;
wire [2:0] funct3_tb                 ; 
wire [6:0] funct7_tb                 ; 
wire       pc_s_d_tb                 ;

//output to GPRs 
wire [4:0] read_sel1_tb              ;
wire [4:0] read_sel2_tb              ;
wire [4:0] write_sel_tb              ;
wire       wen_tb                    ;

//outputs to Pipeline Register
wire [31:0] imm32_tb                 ;
wire [ADDRESS_BITS-1:0] pc_o_tb      ;
wire [11:0] imm12_tb                 ;
wire [ADDRESS_BITS-1:0] pc_next_o_tb ;

                       /*
                        ###################################################
                        ############### ///CONECCTIONS//// ################
                        ###################################################
                                                                           */

Decoder #(.ADDRESS_BITS(ADDRESS_BITS)) u1 (
.pc(pc_tb)                   ,
.instruction(instruction_tb) ,

//.JALR_target(JALR_target_tb),
.branch(branch_tb)           ,
.out_of_loop_i(out_of_loop_i_tb) ,
.target_pc(target_pc_tb)     ,

.op(op_tb)                   ,
.funct3(funct3_tb)           ,
.funct7(funct7_tb)           ,
.pc_s_d(pc_s_d_tb)           ,

.read_sel1(read_sel1_tb)     ,
.read_sel2(read_sel2_tb)     ,
.write_sel(write_sel_tb)     ,
.wen(wen_tb)                 ,

.imm32(imm32_tb)             ,
.pc_next(pc_next_tb)         ,
.pc_next_o(pc_next_o_tb)     ,
.pc_o(pc_o_tb)               ,
.imm12(imm12_tb)             

);

/*
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
                                                                                            */
initial
begin
  initialize();
  #20
  instruction_tb = 32'h00708093; // addi x1,x1,7
  #20
  instruction_tb = 32'h00310113; // addi x2,x2,3
  #20
  instruction_tb = 32'h00A00193; // addi x3,x0,10
  #20
  instruction_tb = 32'h40208233; // sub x4,x1,x2
  #20
  instruction_tb = 32'h06002103; // lw x2, 96(x0)
  #20
  instruction_tb = 32'h00020463; // beq x4, x0,1C
  #20
  instruction_tb = 32'h0040F2B3; // and x5,x1,x4
  #20
  instruction_tb = 32'h02220233; // mul x4,x4,x2
  #20
  instruction_tb = 32'h0089A423; // sw x3, 8(x19)
  #20
  instruction_tb = 32'h00524863; // blt x4,x5,34
  #20
  instruction_tb = 32'h0022E333; // or x6,x5,x2
  #20
  instruction_tb = 32'h00718393; // addi x7,x3,7
  #20
  instruction_tb = 32'h005314B3; // sll x9,x6,x5
  #20
  instruction_tb = 32'h02324433; // div x8,x4,x3
  #20
  instruction_tb = 32'h02311133; // mulh x2,x2,x3
  #20
  instruction_tb = 32'h008342B3; // xor x5,x6,x8
  #20
  instruction_tb = 32'h005354B3; // srl x9,x6,x5
  #20
  instruction_tb = 32'h02326533; // rem x10,x4,x3
  #20
  instruction_tb = 32'hFFC08393; // addi x7, x1,-4
  #20
  instruction_tb = 32'h00538233; // add x4,x7,x5
  #20
  instruction_tb = 32'h00329463; // bne x5,x3,58
  #20
  instruction_tb = 32'h060E8A67; // jalr x23 , x0 ,60H
  #20
  instruction_tb = 32'h00600293; // addi x5 , x0,6
  #20
  instruction_tb = 32'h0500036F; // jal x6 , 50
  #20;
  instruction_tb = 32'h0042C913; // xori x18,x5,4
  #20
  instruction_tb = 32'h00225993; // srli x19,x4,2
  #20
  instruction_tb = 32'h0053D463; // bge x7,x5,70
  #20
  instruction_tb = 32'h00A96A13; // ori x20,x18,10
  #20
  instruction_tb = 32'h00237A93; // andi x21 , x6,2
  #20
  instruction_tb = 32'h0164E463; //  not be taken
  #20
  instruction_tb = 32'h4021DB13; // srai x22,x3,2
  #20
  instruction_tb = 32'h0041A233; // slt x4, x3, x4
  #20
  instruction_tb = 32'h413B54B3; // sra x9,x22,x19
  #20
  instruction_tb = 32'h07067463; //  not be taken
  #20
  instruction_tb = 32'h0032408B; //  rd = x1 of the new register in encryption 
  #20
  instruction_tb = 32'h0000000B; //  rd = x0 of the new register in encryption 
  #20
  instruction_tb = 32'h000007E7; //  x15 = 98 , pc =0H
  #20
  instruction_tb = 32'h342D9073; // wr cuz of x27 to rg 'h342
  #20
  instruction_tb = 32'h05000193; // wr addr of failed inst
  #20
  instruction_tb = 32'h00000013; // no operation (addi 0,0,0)
  #20
  instruction_tb = 32'h34119073; // addr of failed inst (bne)
  #20
  instruction_tb = 32'h30502273; // addr of handling
  #20
  instruction_tb = 32'h00000013; // no operation
  #20
  instruction_tb = 32'h00020F67; // x30 = B4 , PC = X4+0 (addr of handling to fetch ) 
  #20
  instruction_tb = 32'h340020F3; // returen addr of failed inst (save in x1)
  #20
  instruction_tb = 32'h00000263; //  handling (to write bake branch flag)
  #20
  instruction_tb = 32'h00008067; //  refetch addr of failed inst (fetch failed insr again)
  #20;
  
  
  /*
  instruction_tb = 32'h000002E3; // to check prediction if imm[11]==1 , with fixed imm[11] ==0 in b_imm_ext(instruction[7]) when it's decoded
  c_tb         = 32'hB8      ;
  #20;
  
  instruction_tb = 32'h00200067; // to check prediction of jalr if is true
  #20;
   */
  $finish;
end


                      /*
                        ###################################################
                        ################# ///TASK//// #####################
                        ###################################################
                                                                           */
                                                                           
                                                                           
task initialize ;
  begin
        instruction_tb   = 32'h0; 
        pc_tb            = 0    ;
        pc_next_tb       = 0    ;
        out_of_loop_i_tb = 0    ;
        branch_tb        = 0    ;
  end
endtask
endmodule


