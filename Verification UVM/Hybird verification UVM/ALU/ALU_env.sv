//alu of RV32IM verification uvm
//Author: reem ahmed  nada ayman
// ALU environment

package ALU_env;
`include "uvm_macros.svh"
import ALU_scoreboard::*;
import ALU_coverage_collector::*;
import ALU_agent::*;
import ALU_sequence::*;
import ALU_seq_item::*;
import ALU_sequencer::*;
import ALU_config_obj::*;
import ALU_driver::*;
import uvm_pkg::*;

class alu_env extends uvm_env;
`uvm_component_utils(alu_env)
 alu_agent agt;
 alu_scoreboard sb;
 alu_coverage cov;

//constructor
function new (string name = "alu_env", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
super.build_phase(phase);
agt = alu_agent::type_id::create("agt", this);
sb = alu_scoreboard::type_id::create("sb", this);
cov = alu_coverage::type_id::create("cov", this);
endfunction : build_phase

//connect phase
        function void connect_phase (uvm_phase phase);
            agt.agt_ap.connect(sb.sb_export);
            agt.agt_ap.connect(cov.cov_export);
        endfunction : connect_phase

endclass : alu_env	

endpackage : ALU_env	