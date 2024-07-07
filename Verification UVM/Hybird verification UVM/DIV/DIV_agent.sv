//div of RV32IM verification uvm
//Author: reem ahmed
// DIV agent

package DIV_agent;
	import DIV_monitor::*;
	import DIV_sequence::*;
	import DIV_seq_item::*;
	import DIV_sequencer::*;
	import DIV_config_obj::*;
	import DIV_driver::*;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
class div_agent extends uvm_agent;
`uvm_component_utils(div_agent)
	div_config_obj div_config_obj_agent;
	div_driver driver;
	div_sequencer sqr;
	div_monitor mon;
	uvm_analysis_port #(div_seq_item) agt_ap;

//constructor
function new (string name = "div_agent", uvm_component parent = null);
	super.new(name, parent);
endfunction 

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(div_config_obj)::get(this, "", "Virtual_IF", div_config_obj_agent))
		`uvm_fatal("build_phase", "Agent - Unable to Get the Configuration Object")

			sqr 	= div_sequencer::type_id::create("sqr", this);
			driver 	= div_driver::type_id::create("driver", this);
			mon 	= div_monitor::type_id::create("mon", this);
			agt_ap 	= new("agt_ap", this);
		endfunction : build_phase


//connect phase
function void connect_phase (uvm_phase phase);
	super.connect_phase(phase);
			driver.div_driver_vif 	= div_config_obj_agent.div_config_vif;
			mon.div_monitor_vif 	= div_config_obj_agent.div_config_vif;
			driver.seq_item_port.connect(sqr.seq_item_export);
			mon.mon_ap.connect(agt_ap);
endfunction : connect_phase

endclass : div_agent

endpackage : DIV_agent
