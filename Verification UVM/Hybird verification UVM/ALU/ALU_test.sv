//ALU of RV32IM verification uvm
//Author: Reem Ahmed & Nada Ayman
// ALU test

package ALU_test;
`include "uvm_macros.svh"
import uvm_pkg::*;
import ALU_config_obj::*;
import ALU_agent::*;
import ALU_seq_item::*;
import ALU_sequence::*;
import ALU_env::*;

class alu_test extends uvm_test;
 `uvm_component_utils(alu_test)
  alu_config_obj alu_config_obj_test;
  alu_env env;
  alu_agent agt;
  alu_main_sequence main_seq;
 sequence_1 seq_or; 
  virtual ALU_interface alu_test_vif;

//constructor 
function new (string name = "alu_test", uvm_component parent = null);
	super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	env = alu_env::type_id::create("env", this);
	agt = alu_agent::type_id::create("agt", this);
	alu_config_obj_test = alu_config_obj::type_id::create("alu_config_obj_test", this);
	main_seq= alu_main_sequence::type_id::create("main_seq", this);
	seq_or=sequence_1::type_id::create("seq_or", this);

if(!uvm_config_db#(virtual ALU_interface)::get(this, "", "ALU_INTERFACE", alu_config_obj_test.alu_config_vif))
	`uvm_fatal("build_phase", "TEST - Unable to Get the Virtual Interface from the config_db");

	uvm_config_db#(alu_config_obj)::set(this, "*", "Virtual_IF", alu_config_obj_test);
endfunction : build_phase

//run phase
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	phase.raise_objection(this);

	`uvm_info("run_phase", "Stimulus Gen. Started", UVM_NONE);
	main_seq.start(env.agt.sqr);
	`uvm_info("run_phase", "Stimulus Gen. Ended", UVM_NONE);

   `uvm_info("run_phase", "seq_or ASSERTED", UVM_NONE);
    seq_or.start(env.agt.sqr);
    `uvm_info("run_phase", "seq_or DE-ASSERTED", UVM_NONE);


	phase.drop_objection(this);
endtask : run_phase

endclass : alu_test

endpackage : ALU_test	
