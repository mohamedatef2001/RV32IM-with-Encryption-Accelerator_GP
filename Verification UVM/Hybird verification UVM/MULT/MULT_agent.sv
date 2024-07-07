//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT agent

package MULT_agent;
	import MULT_monitor::*;
	import MULT_sequence::*;
	import MULT_seq_item::*;
	import MULT_sequencer::*;
	import MULT_config_obj::*;
	import MULT_driver::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
class mult_agent extends uvm_agent;
`uvm_component_utils(mult_agent)
	mult_config_obj mult_config_obj_agent;
	mult_driver driver;
	mult_sequencer sqr;
	mult_monitor mon;
	uvm_analysis_port #(mult_seq_item) agt_ap;

//constructor
function new (string name = "mult_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction 

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(mult_config_obj)::get(this, "", "Virtual_IF", mult_config_obj_agent))
		`uvm_fatal("build_phase", "Agent - Unable to Get the Configuration Object")

			sqr 	= mult_sequencer::type_id::create("sqr", this);
			driver 	= mult_driver::type_id::create("driver", this);
			mon 	= mult_monitor::type_id::create("mon", this);
			agt_ap 	= new("agt_ap", this);
		endfunction : build_phase


//connect phase
function void connect_phase (uvm_phase phase);
	super.connect_phase(phase);
			driver.mult_driver_vif 	= mult_config_obj_agent.mult_config_vif;
			mon.mult_monitor_vif 	= mult_config_obj_agent.mult_config_vif;
			driver.seq_item_port.connect(sqr.seq_item_export);
			mon.mon_ap.connect(agt_ap);
endfunction : connect_phase

endclass : mult_agent

endpackage : MULT_agent
