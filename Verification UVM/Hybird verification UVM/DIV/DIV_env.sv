//div of RV32IM verification uvm
//Author: reem ahmed
// DIV environment

package DIV_env;
`include "uvm_macros.svh"
import DIV_scoreboard::*;
import DIV_coverage_collector::*;
import DIV_agent::*;
import DIV_sequence::*;
import DIV_seq_item::*;
import DIV_sequencer::*;
import DIV_config_obj::*;
import DIV_driver::*;
import uvm_pkg::*;

class div_env extends uvm_env;
`uvm_component_utils(div_env)
 div_agent agt;
 div_scoreboard sb;
 div_coverage cov;

//constructor
function new (string name = "div_env", uvm_component parent = null);
 super.new(name, parent);
endfunction

//build phase
function void build_phase (uvm_phase phase);
super.build_phase(phase);
agt = div_agent::type_id::create("agt", this);
sb = div_scoreboard::type_id::create("sb", this);
cov = div_coverage::type_id::create("cov", this);
endfunction : build_phase

//connect phase
        function void connect_phase (uvm_phase phase);
            agt.agt_ap.connect(sb.sb_export);
            agt.agt_ap.connect(cov.cov_export);
        endfunction : connect_phase

endclass : div_env	

endpackage : DIV_env	