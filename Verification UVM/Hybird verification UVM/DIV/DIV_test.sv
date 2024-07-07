//div of RV32IM verification uvm
//Author: reem ahmed
// DIV test

package DIV_test;
`include "uvm_macros.svh"
import uvm_pkg::*;
import DIV_config_obj::*;
import DIV_agent::*;
import DIV_seq_item::*;
import DIV_sequence::*;
import DIV_env::*;

class div_test extends uvm_test;
 `uvm_component_utils(div_test)
  div_config_obj div_config_obj_test;
  div_env env;
  div_agent agt;
  div_main_sequence main_seq;
  div_enable_sequence enable_seq;
  virtual DIV_interface div_test_vif;

//constructor 
function new (string name = "div_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	env = div_env::type_id::create("env", this);
	agt = div_agent::type_id::create("agt", this);
	div_config_obj_test = div_config_obj::type_id::create("div_config_obj_test", this);
	main_seq= div_main_sequence::type_id::create("main_seq", this);
	enable_seq=div_enable_sequence::type_id::create("enable_seq", this);

if(!uvm_config_db#(virtual DIV_interface)::get(this, "", "DIV_INTERFACE", div_config_obj_test.div_config_vif))
	`uvm_fatal("build_phase", "TEST - Unable to Get the Virtual Interface from the config_db");

	uvm_config_db#(div_config_obj)::set(this, "*", "Virtual_IF", div_config_obj_test);
endfunction : build_phase

//run phase
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	phase.raise_objection(this);

	`uvm_info("run_phase", "Stimulus Gen. Started", UVM_NONE);
	main_seq.start(env.agt.sqr);
	`uvm_info("run_phase", "Stimulus Gen. Ended", UVM_NONE);

   `uvm_info("run_phase", "Enable ASSERTED", UVM_NONE);
    enable_seq.start(env.agt.sqr);
    `uvm_info("run_phase", "Enable DE-ASSERTED", UVM_NONE);


	phase.drop_objection(this);
endtask : run_phase

endclass : div_test

endpackage : DIV_test	
