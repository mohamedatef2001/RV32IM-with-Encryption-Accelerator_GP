//alu of RV32IM verification uvm
//Author: reem ahmed
// ALU scoreboard

package ALU_scoreboard;
import ALU_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alu_scoreboard extends uvm_scoreboard;
`uvm_component_utils(alu_scoreboard);
uvm_analysis_export #(alu_seq_item) sb_export;
uvm_tlm_analysis_fifo #(alu_seq_item) sb_fifo;

alu_seq_item seq_item_sb;
parameter data_width=32;
logic signed [data_width-1:0] result_expec; 
logic signed [data_width-1:0] target_expec;
logic hold_pipeline_expec, zero_expec, pc_expec, ex_expec,Branch_taken_expec; 
logic error_count;
logic correct_count;

//constructor 
function new (string name = "alu_scoreboard", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
 super.build_phase(phase);
 sb_export = new("sb_export", this);
 sb_fifo = new("sb_fifo", this);
endfunction : build_phase

//connect phase
function void connect_phase (uvm_phase phase);
	super.connect_phase(phase);
	sb_export.connect(sb_fifo.analysis_export);
endfunction : connect_phase

//run phase
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	  forever begin 
		sb_fifo.get(seq_item_sb);
		 ref_model(seq_item_sb);
		 
			//if((seq_item_sb.ALU_result !==result_expec) || (seq_item_sb.JALR_target !== target_expec )|| (seq_item_sb.hold_pipeline!== hold_pipeline_expec) || (seq_item_sb.zero!==zero_expec) || (seq_item_sb.Branch_taken!==Branch_taken_expec)|| (seq_item_sb.ex !== ex) || (seq_item_sb.pc_s_a_1!==pc_expec)) begin 
	if (seq_item_sb.ALU_result !== result_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output ofDUT is: %s, result_expected: %0h", 
                                     seq_item_sb.convert2string(),result_expec));
end 
else if (seq_item_sb.JALR_target !== target_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output of DUT is: %s, target_expected: %0h", 
                                     seq_item_sb.convert2string(), target_expec));
end
 else if (seq_item_sb.pc_s_a_1 !== pc_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output of DUT is: %s, pc_expected: %0h", 
                                     seq_item_sb.convert2string(),  pc_expec));
end 
else if (seq_item_sb.Branch_taken !== Branch_taken_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf(" incorrect output of DUT is: %s,Branch_expected: %0h", 
                                     seq_item_sb.convert2string(), Branch_taken_expec));
end
 else if (seq_item_sb.hold_pipeline !== hold_pipeline_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output of DUT is: %s holdpipeline_expected: %0h", 
                                     seq_item_sb.convert2string(),hold_pipeline_expec));
end
 else if (seq_item_sb.ex !== ex_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output of DUT is: %s, ex_expected: %0h", 
                                     seq_item_sb.convert2string(), ex_expec));
end
 else if (seq_item_sb.zero !== zero_expec) begin
    error_count++;
    `uvm_error("run_phase", $sformatf("incorrect output of DUT is: %s, zero_expected: %0h", 
                                     seq_item_sb.convert2string(),zero_expec));
end

				
else begin 
	`uvm_info("run_phase", $sformatf("Correct alu Out: %s", seq_item_sb.convert2string()), UVM_HIGH);
				correct_count++;
			end
		end
endtask : run_phase

task ref_model(alu_seq_item seq_item_chk);
    case (seq_item_chk.ALU_Control) 
     seq_item_chk.ADD: begin 
          result_expec = seq_item_chk.operand_A + seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end

     seq_item_chk.SUB: begin 
          result_expec = seq_item_chk.operand_A - seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end

      seq_item_chk.OR: begin 
          result_expec = seq_item_chk.operand_A | seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end   

      seq_item_chk.XOR: begin 
          result_expec = seq_item_chk.operand_A ^ seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end 

       seq_item_chk.AND: begin 
          result_expec = seq_item_chk.operand_A & seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end  

       seq_item_chk.SLL: begin 
          result_expec = seq_item_chk.operand_A << seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end 

       seq_item_chk.SRL: begin 
          result_expec = seq_item_chk.operand_A >> seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end 

       seq_item_chk.SRA: begin 
          result_expec = seq_item_chk.operand_A >>> seq_item_chk.operand_B;
          target_expec        = 0;
          hold_pipeline_expec = 0; 
          zero_expec          = 0;
          pc_expec            = 0;
          Branch_taken_expec  = 0;
          ex_expec            = 0;
         end  

        seq_item_chk.SLT: begin 
        	if (seq_item_chk.operand_A < seq_item_chk.operand_B) begin 
               result_expec        = 32'b1;
               target_expec        = 0;
               hold_pipeline_expec = 0; 
               zero_expec          = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               ex_expec            = 0;
             end  
             else begin
               result_expec        = 32'b0;
               target_expec        = 0;
               hold_pipeline_expec = 0; 
               zero_expec          = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               ex_expec            = 0;

             end	
         end 

        seq_item_chk.JALR: begin
        	   target_expec = seq_item_chk.operand_A + seq_item_chk.operand_B;
        	    if (|seq_item_chk.operand_A !== 0)begin
               	 ex_expec = 1;
               	 hold_pipeline_expec = 1;
               	 pc_expec=1; 
                 zero_expec          = 0;
                 Branch_taken_expec  = 0;
                 result_expec=0;
               end
                              
            
                else begin 
                	ex_expec = 0;
               	 hold_pipeline_expec = 1; 
                 zero_expec          = 0;
                 Branch_taken_expec  = 0;
                 result_expec=0;
             end 
         end
             
        seq_item_chk.BEQ: begin
        	if (seq_item_chk.operand_A == seq_item_chk.operand_B) begin
        	   result_expec        = 32'b0;
               target_expec        = 0;
               zero_expec          = 1;
               pc_expec            = 0;
               Branch_taken_expec  = 1;               
                if (!seq_item_chk.operand_B[11]) begin
                 hold_pipeline_expec = 1; 
                 ex_expec            = 1;
               end
               else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
               end
            end   

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               zero_expec          = 0;
               pc_expec            = 0;
               ex_expec            = 0; 
             end
           end

        seq_item_chk.BNE: begin
            if (seq_item_chk.operand_A !== seq_item_chk.operand_B) begin
               result_expec        = 32'b0;
               target_expec        = 0;
               zero_expec          = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 1;
                 if (!seq_item_chk.operand_B[11]) begin 
                  hold_pipeline_expec = 1;
                  ex_expec            = 1;
                 end 
                else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
                end
             end 

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               zero_expec          = 1;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               pc_expec            = 0;
               ex_expec            = 0; 
             end
        end  

        seq_item_chk.BLT: begin
            if (seq_item_chk.operand_A < seq_item_chk.operand_B) begin
               result_expec        = 32'b0;
               target_expec        = 0;
               zero_expec          = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 1;
                 if (!seq_item_chk.operand_B[11]) begin 
                  hold_pipeline_expec = 1;
                  ex_expec            = 1;
                 end 
                else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
                end
             end 

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               ex_expec            = 0; 
                //if (seq_item_chk.operand_A == seq_item_chk.operand_B) zero_expec  = 1; else zero_expec = 0;
             end
        end 

        seq_item_chk.BLTU: begin
            if (seq_item_chk.operand_A < seq_item_chk.operand_B) begin
               result_expec        = 32'b0;
               target_expec        = 0;
               zero_expec          = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 1;
                 if (!seq_item_chk.operand_B[11]) begin 
                  hold_pipeline_expec = 1;
                  ex_expec            = 1;
                 end 
                else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
                end
             end 

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               ex_expec            = 0; 
                if (seq_item_chk.operand_A == seq_item_chk.operand_B) zero_expec  = 1; else zero_expec = 0;
             end
        end 

        seq_item_chk.BGE: begin
            if (seq_item_chk.operand_A >= seq_item_chk.operand_B) begin
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               //if (seq_item_chk.operand_A == seq_item_chk.operand_B) zero_expec  = 1; else zero_expec = 0;
               Branch_taken_expec  = 1;
                 if (!seq_item_chk.operand_B[11]) begin 
                  hold_pipeline_expec = 1;
                  ex_expec            = 1;
                 end 
                else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
                end
             end 

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               ex_expec            = 0; 
               zero_expec          = 0;
             end
        end  

        seq_item_chk.BGEU: begin
            if (seq_item_chk.operand_A >= seq_item_chk.operand_B) begin
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               //if (seq_item_chk.operand_A == seq_item_chk.operand_B) zero_expec  = 1; else zero_expec = 0;
               Branch_taken_expec  = 1;
                 if (!seq_item_chk.operand_B[11]) begin 
                  hold_pipeline_expec = 1;
                  ex_expec            = 1;
                 end 
                else begin 
                 hold_pipeline_expec = 0;
                 ex_expec            = 0;
                end
             end 

             else begin 
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               ex_expec            = 0; 
               zero_expec          = 0;
             end
        end  

        default : begin
               result_expec        = 32'b0;
               target_expec        = 0;
               pc_expec            = 0;
               Branch_taken_expec  = 0;
               hold_pipeline_expec = 0; 
               ex_expec            = 0; 
               zero_expec          = 0;

        end
    endcase 
endtask : ref_model

//report phase
function void report_phase (uvm_phase phase);
 super.report_phase(phase);
	`uvm_info("report_phase", $sformatf("Total Successful Transactions: %0d", correct_count), UVM_MEDIUM);
	`uvm_info("report_phase", $sformatf("Total Failed Transactions: %0d", error_count), UVM_MEDIUM);
endfunction : report_phase	

endclass : alu_scoreboard
endpackage : ALU_scoreboard	
