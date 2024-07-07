//div of RV32IM verification uvm
//Author: reem ahmed
// DIV congfigration object 


package DIV_config_obj;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	class div_config_obj extends uvm_object;
		`uvm_object_utils(div_config_obj)

//cf object holds virtual if from the test to the driver
 		virtual DIV_interface div_config_vif;

//constructor
		function new (string name = "div_config_obj");
			super.new(name);
		endfunction
	endclass : div_config_obj

endpackage