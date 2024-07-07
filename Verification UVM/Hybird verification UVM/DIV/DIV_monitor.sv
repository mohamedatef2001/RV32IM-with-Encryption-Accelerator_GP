//div of RV32IM verification uvm
//Author: reem ahmed
//DIV monitor

package DIV_monitor;
	import DIV_seq_item::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

class div_monitor extends uvm_monitor;
  `uvm_component_utils(div_monitor)
   virtual DIV_interface div_monitor_vif;
	div_seq_item rsp_seq_item;
	uvm_analysis_port #(div_seq_item) mon_ap;
//constructor
function new (string name = "div_monitor", uvm_component parent = null);
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
				@(negedge div_monitor_vif.clk);
				rsp_seq_item = div_seq_item::type_id::create("rsp_seq_item");
				rsp_seq_item.oper_a 	= div_monitor_vif.oper_a;
				rsp_seq_item.oper_b		= div_monitor_vif.oper_b;
				rsp_seq_item.enable_div= div_monitor_vif.enable_div;
				rsp_seq_item.operation 	    = div_monitor_vif.operation;
				rsp_seq_item.div_o= div_monitor_vif.div_o;
				mon_ap.write(rsp_seq_item);
				`uvm_info("run_phase", rsp_seq_item.convert2string(), UVM_HIGH)
			end
		endtask : run_phase
	endclass : div_monitor

endpackage