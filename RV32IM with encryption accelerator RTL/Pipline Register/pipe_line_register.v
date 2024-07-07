module pipeline_register (CLK,,RST,flush,op,funct3,funct7,pc_o,imm32,rs1,rs2,rd,en,pc_next,imm12,pc_target,op_o,funct3_o,funct7_o,pc_o_o,imm32_o,rs1_o,rs2_o,rd_o,en_o,pc_next_o,imm12_o,pc_target_o);

// inputs from Decoder and controller with CLK,RST

input        CLK;
input        RST;
input        flush;
input [6:0]  op;
input [2:0]  funct3;
input [6:0]  funct7;
input [31:0] pc_o;
input [31:0] imm32;
input [4:0]  rs1;
input [4:0]  rs2;
input [4:0]  rd;
input        en;
input [31:0] pc_next;
input [11:0] imm12;
input [31:0] pc_target;


 //outputs 
 output [6:0]  op_o ;
 output [2:0]  funct3_o; 
 output [6:0]  funct7_o;
 output [31:0] pc_o_o;
 output [11:0] imm12_o;
 output [31:0] imm32_o;
 output [4:0]  rs1_o;
 output [4:0]  rs2_o;
 output [4:0]  rd_o;
 output [31:0] pc_next_o;
 output [31:0] pc_target_o;
 output        en_o;
 
 // temporary variable for always block
 
 reg [6:0]  temp_op_o; 
 reg [2:0]  temp_funct3_o;
 reg [6:0]  temp_funct7_o;
 reg [31:0] temp_pc_o_o;
 reg [11:0] temp_imm12_o;
 reg [31:0] temp_imm32_o;
 reg [4:0]  temp_rs1_o;
 reg [4:0]  temp_rs2_o;
 reg [4:0]  temp_rd_o;
 reg [31:0] temp_pc_next_o;
 reg [31:0] temp_pc_target_o;
 reg        temp_en_o;
 
 always @ (posedge CLK or negedge RST)
  begin 
   if(!RST)
   
    begin
	
     temp_op_o        <= 'd0;
	 temp_funct3_o    <= 'd0;
	 temp_funct7_o    <= 'd0;
	 temp_pc_o_o      <= 'd0;
	 temp_imm12_o     <= 'd0;
	 temp_imm32_o     <= 'd0;
	 temp_rs1_o       <= 'd0;
	 temp_rs2_o       <= 'd0;
	 temp_rd_o        <= 'd0;
	 temp_pc_next_o   <= 'd0;
	 temp_pc_target_o <= 'd0;
	 temp_en_o        <= 'd0;
	 
	 end
	 
    else if (flush)
	
     begin	
	 
	 temp_op_o        <= 'd0;
	 temp_funct3_o    <= 'd0;
	 temp_funct7_o    <= 'd0;
	 temp_pc_o_o      <= 'd0;
	 temp_imm12_o     <= 'd0;
	 temp_imm32_o     <= 'd0;
	 temp_rs1_o       <= 'd0;
	 temp_rs2_o       <= 'd0;
	 temp_rd_o        <= 'd0;
	 temp_pc_next_o   <= 'd0;
	 temp_pc_target_o <= 'd0;
	 temp_en_o        <= 'd0;
	
	end
	
	else 
	
	begin
	
     temp_op_o        <= op;
	 temp_funct3_o    <= funct3;
	 temp_funct7_o    <= funct7;
	 temp_pc_o_o      <= pc_o;
	 temp_imm12_o     <= imm12;
	 temp_imm32_o     <= imm32;
	 temp_rs1_o       <= rs1;
	 temp_rs2_o       <= rs2;
	 temp_rd_o        <= rd;
	 temp_pc_next_o   <= pc_next;
	 temp_pc_target_o <= pc_target;
	 temp_en_o        <= en;
	 
	end
 end
 
 
 
 assign op_o        = temp_op_o ;
 assign funct3_o    = temp_funct3_o;
 assign funct7_o    = temp_funct7_o;
 assign pc_o_o      = temp_pc_o_o;
 assign imm12_o     = temp_imm12_o;
 assign imm32_o     = temp_imm32_o;
 assign rs1_o       = temp_rs1_o;
 assign rs2_o       = temp_rs2_o;
 assign rd_o        = temp_rd_o;
 assign pc_next_o   = temp_pc_next_o;
 assign pc_target_o = temp_pc_target_o;
 assign en_o        = temp_en_o;
 
 
 endmodule