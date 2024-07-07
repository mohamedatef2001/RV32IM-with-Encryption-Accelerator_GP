//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT monitor

package MULT_monitor;
	import MULT_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class mult_monitor extends uvm_monitor;
  `uvm_component_utils(mult_monitor)
   virtual MULT_interface mult_monitor_vif;
	mult_seq_item rsp_seq_item;
	uvm_analysis_port #(mult_seq_item) mon_ap;
//constructor
function new (string name = "mult_monitor", uvm_component parent = null);
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
				@(negedge mult_monitor_vif.clk);
				rsp_seq_item = mult_seq_item::type_id::create("rsp_seq_item");
				rsp_seq_item.oper_a 	= mult_monitor_vif.oper_a;
				rsp_seq_item.oper_b		= mult_monitor_vif.oper_b;
				rsp_seq_item.enable_mult= mult_monitor_vif.enable_mult;
				rsp_seq_item.operation 	    = mult_monitor_vif.operation;
				rsp_seq_item.mult_o 	= mult_monitor_vif.mult_o;
				mon_ap.write(rsp_seq_item);
				`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)
			end
		endtask : run_phase
	endclass : mult_monitor

endpackage