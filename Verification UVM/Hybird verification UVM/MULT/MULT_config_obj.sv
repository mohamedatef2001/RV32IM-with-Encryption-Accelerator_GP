//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT congfigration object 


package MULT_config_obj;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class mult_config_obj extends uvm_object;
		`uvm_object_utils(mult_config_obj)

//cf object holds virtual if from the test to the driver
 		virtual MULT_interface mult_config_vif;

//constructor
		function new (string name = "mult_config_obj");
			super.new(name);
		endfunction
	endclass : mult_config_obj

endpackage