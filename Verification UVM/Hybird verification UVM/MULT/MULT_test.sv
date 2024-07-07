//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT test

package MULT_test;
`include "uvm_macros.svh"
import uvm_pkg::*;
import MULT_config_obj::*;
import MULT_agent::*;
import MULT_seq_item::*;
import MULT_sequence::*;
import MULT_env::*;

class mult_test extends uvm_test;
 `uvm_component_utils(mult_test)
  mult_config_obj mult_config_obj_test;
  mult_env env;
  mult_agent agt;
  mult_main_sequence main_seq;
  mult_enable_sequence enable_seq;
  virtual MULT_interface mult_test_vif;

//constructor 
function new (string name = "mult_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	env = mult_env::type_id::create("env", this);
	agt = mult_agent::type_id::create("agt", this);
	mult_config_obj_test = mult_config_obj::type_id::create("mult_config_obj_test", this);
	main_seq= mult_main_sequence::type_id::create("main_seq", this);
	enable_seq=mult_enable_sequence::type_id::create("enable_seq", this);

if(!uvm_config_db#(virtual MULT_interface)::get(this, "", "MULT_INTERFACE", mult_config_obj_test.mult_config_vif))
	`uvm_fatal("build_phase", "TEST - Unable to Get the Virtual Interface from the config_db");

	uvm_config_db#(mult_config_obj)::set(this, "*", "Virtual_IF", mult_config_obj_test);
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

endclass : mult_test

endpackage : MULT_test	
