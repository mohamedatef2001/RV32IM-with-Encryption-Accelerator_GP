//ALU of RV32IM 
//Author: reem ahmed ali
module ALU #(parameter data_width = 32)
( ALU_interface.DUT aluIF);

  logic [5:0] ALU_Control;
  logic signed [data_width-1:0] operand_A;
  logic signed [data_width-1:0] operand_B;
  logic signed [data_width-1:0] ALU_result;
  logic Branch_taken;
  logic signed [data_width-1:0] JALR_target;
  logic hold_pipeline;
  logic pc_s_a_1;
  logic ex;  
  logic zero;

assign ALU_Control=aluIF.ALU_Control;
assign operand_A=aluIF.operand_A;
assign operand_B=aluIF.operand_B;
//outputs
assign aluIF.ALU_result=ALU_result;
assign aluIF.Branch_taken=Branch_taken;
assign aluIF.JALR_target=JALR_target;
assign  aluIF.hold_pipeline=hold_pipeline;
assign aluIF.pc_s_a_1=pc_s_a_1;
assign  aluIF.ex=ex;  
assign aluIF.zero=zero;



//internal wires of ALU assigned to the output of the comparator 
logic Greater,Equal,Less;




//comparator intantiation
ALU_Comparator #(32)  cmp (.operand_A(operand_A),.operand_B(operand_B), .Greater(Greater), .Equal(Equal), .Less(Less));

 always @(*) begin

  case(ALU_Control)
    // Addition and Subtraction
    6'b000000: begin
     ALU_result=operand_A + operand_B; // Add (lW,SW,ADDI, ADD)
    Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
   end
    6'b001000:begin
      ALU_result=operand_A - operand_B; // Sub (SUB)
    Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end

    // Logic Operations
    6'b000110:begin  ALU_result= operand_A | operand_B; // Or (OR, ORI)
      Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end
    6'b000100:begin 
     ALU_result= operand_A ^ operand_B; // Xor (XORI, XOR)
      Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end
    6'b000111: begin
     ALU_result= operand_A & operand_B; // And (ANDI, AND)
     Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
   end

     // Shift Operations
     6'b000001:begin
      ALU_result=operand_A << operand_B; // Logical Shift Left (SLLI, SLL)
      Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=1;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end
     6'b000101:begin
      ALU_result= operand_A >> operand_B; // Logical Shift Right (SRLI, SRL)
      Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end
	   6'b001101:begin
      ALU_result=operand_A >>> operand_B;// Arithmetic Shift Right (SRAI, SRA)
      Branch_taken=1'b0;
    pc_s_a_1=0;
    ex=0;  
   JALR_target=32'b0;
   hold_pipeline=1'b0;
   zero=1'b0;
    end

     // Signed Less Than (SLTI, SLT)
     6'b000010: begin
      	if(Less==1'b1)begin
          ALU_result=32'b1; // Signed Less Than(SLTI,SLT)
          Branch_taken=1'b0;
          pc_s_a_1=1'b0;
          ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
         zero=1'b0;
        end  
        else begin
          ALU_result=32'b0;
        Branch_taken=1'b0;
        pc_s_a_1=0;
        ex=0;  
       JALR_target=32'b0;
       hold_pipeline=1'b0;
        zero=1'b0;
        end    
      end
     //Jump and link rigister (JALR)
     6'b100111: begin 
        JALR_target=operand_A + operand_B; //jalr_address = rs1 + imm;
        ALU_result=32'b0;
        Branch_taken=1'b0;
        pc_s_a_1=1'b0;
        ex=1'b0;  
        hold_pipeline=1'b0;
        zero=1'b0;
     end

     // Branch Operations (BEQ, BNE, BLT, BGE, BLTU)
     6'b010000: begin // BEQ
     	if(Equal)begin
      Branch_taken=1'b1;
      zero=1'b1;
      ALU_result=32'b0;
     pc_s_a_1=1'b0;
     ex=1'b0;  
     JALR_target=32'b0;
    hold_pipeline=1'b0;

      end
      else begin
        Branch_taken=1'b0;
            zero=1'b0;
            ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
      end 
     end

     6'b010001: begin // BNE
      if (~Equal)begin
        Branch_taken=1'b1;
                    zero=1'b0;
            ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end 
     else begin 
      Branch_taken=1'b0;
                 zero=1'b0;
            ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
    end
  end

    6'b000010: begin// BLT
    	if(Less)begin
      Branch_taken=1'b1;
         zero=1'b0;
            ALU_result=32'b0;
           pc_s_a_1=1'b0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
      end 
     else begin
      Branch_taken=1'b0;
          zero=1'b0;
            ALU_result=32'b0;
           pc_s_a_1=1'b0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
     end 
    end

    6'b010101: begin // BGE
      case({Greater,Equal})
        2'b00: begin 
          Branch_taken=1'b0;
          zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;   
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b01: begin
          Branch_taken=1'b1;
          zero= 1'b1;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;   
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b10: begin
          Branch_taken=1'b1;
          zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b11: begin
          Branch_taken=1'b1;
          zero= 1'b1;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0; 
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
      endcase
    end

    //unsined
    6'b010110:begin  // BLTU
    	if(Less) begin
      Branch_taken=1'b1;
      zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0; 
          JALR_target=32'b0;
         hold_pipeline=1'b0;

      end
      else begin
        Branch_taken=1'b0;
      zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
      end 
    end
    
    6'b010111: begin // BGEU
      case({Greater,Equal})
        2'b00: begin 
          Branch_taken=1'b0;
          zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b01: begin
          Branch_taken=1'b1;
          zero= 1'b1;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0; 
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b10: begin
          Branch_taken=1'b1;
          zero= 1'b0;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
        2'b11: begin
          Branch_taken=1'b1;
          zero= 1'b1;
          ALU_result=32'b0;
           pc_s_a_1=0;
           ex=1'b0;  
          JALR_target=32'b0;
         hold_pipeline=1'b0;
        end
      endcase
    end

	default:
begin
  ALU_result=32'b0;
 Branch_taken=1'b0;
 pc_s_a_1=0;
 ex=1'b0;  
 JALR_target=32'b0;
 hold_pipeline=1'b0;
 zero=1'b0;// Default Case
 end
  endcase

//hold_pipeline signal(branch instructions)
if ((Branch_taken===1'b1 && operand_B[11]==0))
begin
                 hold_pipeline=1'b1;
                 ex = 1;
                 pc_s_a_1=0;
end
else if (ALU_Control === 6'b100111 && (|operand_A )!= 32'b0 )
begin
                 hold_pipeline=1'b1;
                 ex = 1;
                 pc_s_a_1=1;
end

else
  
begin
                 hold_pipeline=1'b0;
                 ex = 0;
                 pc_s_a_1=0;
end

end

// Flags( zero,overflow,negative)
//assign zero = ~(|ALU_result); //ALU_result is zero
//assign overflow = ({carry, ALU_result[data_width-1]} == 2'b01); 
//assign negative = (ALU_result[data_width-1] == 1 && (ALU_Control == 6'b001000)); //last bit is one and subtraction is performed

endmodule