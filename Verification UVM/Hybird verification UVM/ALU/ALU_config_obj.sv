//alu of RV32IM verification uvm
//Author: Reem ahmed & Nada Ayman
// ALU congfigration object 


package ALU_config_obj;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class alu_config_obj extends uvm_object;
		`uvm_object_utils(alu_config_obj)

//cf object holds virtual if from the test to the driver
 		virtual ALU_interface alu_config_vif;

//constructor
		function new (string name = "alu_config_obj");
			super.new(name);
		endfunction
	endclass : alu_config_obj

endpackage