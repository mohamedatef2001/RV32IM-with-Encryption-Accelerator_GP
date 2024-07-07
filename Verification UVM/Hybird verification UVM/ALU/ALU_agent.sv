//alu of RV32IM verification uvm
//Author: reem ahmed & nada ayman 
// ALU agent

package ALU_agent;
	import ALU_monitor::*;
	import ALU_sequence::*;
	import ALU_seq_item::*;
	import ALU_sequencer::*;
	import ALU_config_obj::*;
	import ALU_driver::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
class alu_agent extends uvm_agent;
`uvm_component_utils(alu_agent)
	alu_config_obj alu_config_obj_agent;
	alu_driver driver;
	alu_sequencer sqr;
	alu_monitor mon;
	uvm_analysis_port #(alu_seq_item) agt_ap;

//constructor
function new (string name = "alu_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction 

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(alu_config_obj)::get(this, "", "Virtual_IF", alu_config_obj_agent))
		`uvm_fatal("build_phase", "Agent - Unable to Get the Configuration Object")

			sqr 	= alu_sequencer::type_id::create("sqr", this);
			driver 	= alu_driver::type_id::create("driver", this);
			mon 	= alu_monitor::type_id::create("mon", this);
			agt_ap 	= new("agt_ap", this);
		endfunction : build_phase


//connect phase
function void connect_phase (uvm_phase phase);
	super.connect_phase(phase);
			driver.alu_driver_vif 	= alu_config_obj_agent.alu_config_vif;
			mon.alu_monitor_vif 	= alu_config_obj_agent.alu_config_vif;
			driver.seq_item_port.connect(sqr.seq_item_export);
			mon.mon_ap.connect(agt_ap);
endfunction : connect_phase

endclass : alu_agent

endpackage : ALU_agent
