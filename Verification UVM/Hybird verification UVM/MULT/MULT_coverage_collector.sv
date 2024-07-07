//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT coverage collector

package MULT_coverage_collector;
import MULT_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class mult_coverage extends uvm_component;
`uvm_component_utils(mult_coverage)
uvm_analysis_export #(mult_seq_item) cov_export;
uvm_tlm_analysis_fifo #(mult_seq_item) cov_fifo;

mult_seq_item seq_item_cov;

covergroup cg(); 
//oper_a: coverpoint seq_item_cov.oper_a;
//oper_b: coverpoint seq_item_cov.oper_b;
enable_mult: coverpoint seq_item_cov.enable_mult{
  bins enable_mult ={1};
  bins notenable_mult={0};
}
operation: coverpoint seq_item_cov.operation{
  bins operation_high={1};
  bins operation_low={0};
}
//mult_o: coverpoint seq_item_cov.mult_o;

//cross coverage
//cross operation,mult_o;


endgroup : cg	

//constructor
function new (string name = "mult_coverage", uvm_component parent = null);
 super.new(name, parent);
	cg = new;
endfunction

//build phase
function void build_phase (uvm_phase phase);
  super.build_phase(phase);
   seq_item_cov=mult_seq_item::type_id::create("seq_item_cov",this);
  cov_export = new("cov_export", this);
  cov_fifo = new("cov_fifo", this);
endfunction :  build_phase

//connect phase
function void connect_phase (uvm_phase phase);
  super.connect_phase(phase);
 cov_export.connect(cov_fifo.analysis_export);
endfunction : connect_phase

//run phase
task run_phase(uvm_phase phase);
 super.run_phase(phase);
	forever begin 
	 cov_fifo.get(seq_item_cov);
	 cg.sample();
			end
endtask : run_phase



endclass : mult_coverage	

endpackage : MULT_coverage_collector	