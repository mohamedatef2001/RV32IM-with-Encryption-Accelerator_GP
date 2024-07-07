//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT scoreboard

package MULT_scoreboard;
import MULT_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_scoreboard extends uvm_scoreboard;
`uvm_component_utils(mult_scoreboard);
uvm_analysis_export #(mult_seq_item) sb_export;
uvm_tlm_analysis_fifo #(mult_seq_item) sb_fifo;

mult_seq_item seq_item_sb;
parameter length =32;
logic signed [length-1:0] mult_o_ref;
logic signed[63:0] result;
int error_count = 0, correct_count = 0;

//constructor 
function new (string name = "mult_scoreboard", uvm_component parent = null);
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
		 #1;
			if(seq_item_sb.mult_o !== mult_o_ref) begin 
				`uvm_error("run_phase", $sformatf("Comparison Failed, Transaction received by the DUT is: %s , While the Reference out is: 0h%0h, the total result is: 0h%0h",
						seq_item_sb.convert2string(), mult_o_ref, result));
					error_count++;
			end
			else begin 
				`uvm_info("run_phase", $sformatf("Correct MULT Out: %s", seq_item_sb.convert2string()), UVM_HIGH);
				correct_count++;
			end
		end
endtask : run_phase

task ref_model(mult_seq_item seq_item_chk);
	if(seq_item_chk.enable_mult) begin
		result = seq_item_chk.oper_a * seq_item_chk.oper_b;
		if(!seq_item_chk.operation) begin
			// instruction is mul (multiply LSB)
			mult_o_ref = result[31:0];
		end else begin
			// instruction is mulh (multiply MSB)
			mult_o_ref = result[63:32];
		end
	end else begin
		mult_o_ref = 0;
	end
endtask : ref_model

//report phase
function void report_phase (uvm_phase phase);
 super.report_phase(phase);
	`uvm_info("report_phase", $sformatf("Total Successful Transactions: %0d", correct_count), UVM_MEDIUM);
	`uvm_info("report_phase", $sformatf("Total Failed Transactions: %0d", error_count), UVM_MEDIUM);
endfunction : report_phase	

endclass : mult_scoreboard
endpackage : MULT_scoreboard	