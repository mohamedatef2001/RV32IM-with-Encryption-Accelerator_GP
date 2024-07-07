//div of RV32IM verification uvm
//Author: reem ahmed
// DIV driver

package DIV_driver;
import uvm_pkg::*;
import DIV_seq_item::*;
`include "uvm_macros.svh"

class div_driver extends uvm_driver#(div_seq_item);
`uvm_component_utils(div_driver)
virtual DIV_interface div_driver_vif;
div_seq_item stim_seq_item;

//constructor
function new (string name = "div_driver", uvm_component parent = null);
	super.new(name, parent);
endfunction

//run phase
task run_phase(uvm_phase phase);
 super.run_phase(phase);	
	forever begin 
		stim_seq_item = div_seq_item::type_id::create("stim_seq_item");
		seq_item_port.get_next_item(stim_seq_item);
		div_driver_vif.oper_a = stim_seq_item.oper_a;
		div_driver_vif.oper_b = stim_seq_item.oper_b;; 	
		div_driver_vif. enable_div = stim_seq_item.enable_div; 
		div_driver_vif.operation = stim_seq_item.operation; 
		@(negedge div_driver_vif.clk);
		seq_item_port.item_done();
		`uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
		end
	endtask : run_phase

endclass : div_driver	


endpackage : DIV_driver