//alu of RV32IM verification uvm
//Author: Reem Ahmed & Nada Ayman
//ALU monitor

package ALU_monitor;
	import ALU_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
   virtual ALU_interface alu_monitor_vif;
	alu_seq_item rsp_seq_item;
	uvm_analysis_port #(alu_seq_item) mon_ap;
//constructor
function new (string name = "alu_monitor", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
 super.build_phase(phase);
	mon_ap = new("mon_ap", this);
endfunction : build_phase

//runphase
task run_phase(uvm_phase phase);
			super.run_phase(phase);
			forever begin
				@(negedge alu_monitor_vif.clk);
				rsp_seq_item = alu_seq_item::type_id::create("rsp_seq_item");
				rsp_seq_item.operand_A	= alu_monitor_vif.operand_A;
				rsp_seq_item.operand_B	= alu_monitor_vif.operand_B;
				rsp_seq_item.ALU_Control	= alu_monitor_vif.ALU_Control;
				rsp_seq_item.ALU_result	= alu_monitor_vif.ALU_result;
				rsp_seq_item.Branch_taken= alu_monitor_vif.Branch_taken;
				rsp_seq_item.JALR_target= alu_monitor_vif.JALR_target;
				rsp_seq_item.hold_pipeline= alu_monitor_vif.hold_pipeline;
				rsp_seq_item.pc_s_a_1= alu_monitor_vif.pc_s_a_1;
				rsp_seq_item.zero= alu_monitor_vif.zero;
				rsp_seq_item.ex	= alu_monitor_vif.ex;
				mon_ap.write(rsp_seq_item);
				`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)
			end
		endtask : run_phase
	endclass : alu_monitor

endpackage