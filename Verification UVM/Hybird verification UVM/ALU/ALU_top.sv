//ALU of RV32IM verification uvm
//Author: Reem Ahmed &  Nada Ayman
//ALU TOP


`include "uvm_macros.svh"
import ALU_config_obj::*;
import ALU_driver::*;
import ALU_env::*;
import ALU_test::*;
import uvm_pkg::*;
module ALU_top();
	bit clk;

	/* Clock Generation */
	initial begin 
		clk = 0;
		forever 
			#1 clk = ~clk;
	end
ALU_interface aluIF(clk);
ALU  DUT(aluIF);
	//assertions bind

//interface handle in the config. databse & runnig test
initial begin
		uvm_config_db#(virtual ALU_interface)::set(null, "uvm_test_top", "ALU_INTERFACE", aluIF); 
		run_test("alu_test");
	end



endmodule : ALU_top
