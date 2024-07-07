//alu of RV32IM verification uvm
//Author: reem ahmed
// ALU driver

package ALU_driver;
import uvm_pkg::*;
import ALU_seq_item::*;
`include "uvm_macros.svh"

class alu_driver extends uvm_driver#(alu_seq_item);
`uvm_component_utils(alu_driver)
virtual ALU_interface alu_driver_vif;
alu_seq_item stim_seq_item;

//constructor
function new (string name = "alu_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction

//run phase
task run_phase(uvm_phase phase);
 super.run_phase(phase);	
	forever begin 
		stim_seq_item = alu_seq_item::type_id::create("stim_seq_item");
		seq_item_port.get_next_item(stim_seq_item);
		alu_driver_vif.operand_A = stim_seq_item.operand_A;
		alu_driver_vif.operand_B = stim_seq_item.operand_B;; 	
		alu_driver_vif.ALU_Control= stim_seq_item.ALU_Control ; 
		@(negedge alu_driver_vif.clk);
		seq_item_port.item_done();
		`uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
		end
	endtask : run_phase

endclass : alu_driver	


endpackage : ALU_driver