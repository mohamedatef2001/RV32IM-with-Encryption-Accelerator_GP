//mult of RV32IM verification uvm
//Author: reem ahmed
// MULT environment

package MULT_env;
`include "uvm_macros.svh"
import MULT_scoreboard::*;
import MULT_coverage_collector::*;
import MULT_agent::*;
import MULT_sequence::*;
import MULT_seq_item::*;
import MULT_sequencer::*;
import MULT_config_obj::*;
import MULT_driver::*;
import uvm_pkg::*;

class mult_env extends uvm_env;
`uvm_component_utils(mult_env)
 mult_agent agt;
 mult_scoreboard sb;
 mult_coverage cov;

//constructor
function new (string name = "mult_env", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
super.build_phase(phase);
agt = mult_agent::type_id::create("agt", this);
sb = mult_scoreboard::type_id::create("sb", this);
cov = mult_coverage::type_id::create("cov", this);
endfunction : build_phase

//connect phase
        function void connect_phase (uvm_phase phase);
            agt.agt_ap.connect(sb.sb_export);
            agt.agt_ap.connect(cov.cov_export);
        endfunction : connect_phase

endclass : mult_env	

endpackage : MULT_env	