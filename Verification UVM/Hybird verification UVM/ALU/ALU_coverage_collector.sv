//alu of RV32IM verification uvm
//Author: reem ahmed
// ALU coverage collector

package ALU_coverage_collector;
import ALU_seq_item::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alu_coverage extends uvm_component;
`uvm_component_utils(alu_coverage)
uvm_analysis_export #(alu_seq_item) cov_export; 
uvm_tlm_analysis_fifo #(alu_seq_item) cov_fifo;

alu_seq_item seq_item_cov;

parameter ADD = 6'b000000;
  parameter SUB = 6'b001000;
  //bitwise
  parameter OR  = 6'b000110;
  parameter XOR = 6'b000100;
  parameter AND = 6'b000111;
  //shift
  parameter SLL = 6'b000001;
  parameter SRL = 6'b000101;
  parameter SRA = 6'b001101;
  //set less than
  parameter SLT = 6'b000010;
  //jump and link
  parameter JALR = 6'b100111;
  //branch
  parameter BEQ = 6'b010000;
  parameter BNE = 6'b010001;
  parameter BLT = 6'b000010;
  parameter BGE = 6'b010101;
  parameter BLTU = 6'b010110;
  parameter BGEU = 6'b010111;

  localparam ZERO = 0;
  localparam POSMAX = 32'h7fffffff;
  localparam NEGMAX = 32'h80000000;


//covergroups
       covergroup CovGp();
        A_cp: coverpoint seq_item_cov.operand_A { 
        bins data_0       = {ZERO};
        bins data_max     = {POSMAX};
        bins data_min     = {NEGMAX};
        bins data_default = default;
        }

        B_cp: coverpoint seq_item_cov.operand_B { 
        bins data_0       = {ZERO};
        bins data_max     = {POSMAX};
        bins data_min     = {NEGMAX};
        //bins zero_flag    = {~operand_B[11]};
        bins data_default = default;
        }

        opcode_cp: coverpoint seq_item_cov.ALU_Control {
        bins Bins_arith[]   = {ADD,SUB};
        bins Bins_bitwise[] = {OR,XOR,AND};
        bins Bins_shift[]   = {SLL,SRL,SRA};
        bins Bins_jump      = {JALR};
        bins Bins_compare   = {SLT};
        bins Bins_branch[]  = {BEQ,BNE,BLT,BGE,BLTU,BGEU};
        bins Bins_br_eq[]   = {BEQ,BGE,BGEU};
      }

      result_cp: coverpoint seq_item_cov.ALU_result {
        bins data_0       = {ZERO};
        bins data_max     = {POSMAX};
        bins data_min     = {NEGMAX};
        bins data_default = default;
      }

      jtarget_cp: coverpoint seq_item_cov.JALR_target {
        bins data_0       = {ZERO};
        bins one          = {1};
        //bins data_max     = {POSMAX};
       // bins data_min     = {NEGMAX};
        bins data_default = default;
      }

      zero_cp:coverpoint seq_item_cov.zero {
       bins z = {0,1};
       } 

      hpipe_cp:coverpoint seq_item_cov.hold_pipeline {
       bins hp = {0,1};
      } 

      btake_cp:coverpoint seq_item_cov.Branch_taken {
       bins bt = {0,1};
      } 

      ex_cp: coverpoint seq_item_cov.ex {
       bins exc = {0,1};
      }

      pc_cp: coverpoint seq_item_cov.pc_s_a_1 {
       bins pcs = {0,1};
      }

//       //cross coverage

//       //Arthematic operation
//       alu1: cross A_cp, B_cp, opcode_cp{
//          bins a0_b0       = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_0)   && binsof (A_cp.data_0);
//          bins a0_b_pos    = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_max) && binsof (A_cp.data_0);
//          bins a0_b_neg    = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_min) && binsof (A_cp.data_0);
//          bins a_pos_b0    = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_0)   && binsof (A_cp.data_max);
//          bins a_pos_b_pos = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_max) && binsof (A_cp.data_max);
//          bins a_pos_b_neg = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_min) && binsof (A_cp.data_max);
//          bins a_neg_b0    = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_0)   && binsof (A_cp.data_min);
//          bins a_neg_b_pos = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_max) && binsof (A_cp.data_min);
//          bins a_neg_b_neg = binsof (opcode_cp.Bins_arith) && binsof (B_cp.data_min) && binsof (A_cp.data_min);
//    //      option.cross_auto_bin_max=0;
//       }

//       //set less than operation
//       alu2: cross opcode_cp, result_cp {
//        bins A_is_less = binsof (opcode_cp.Bins_compare) && binsof (result_cp) intersect {1};
// //         option.cross_auto_bin_max=0;
//       }

//       //branch operations
//       alu3: cross opcode_cp, btake_cp, hpipe_cp, zero_cp {
//        bins brnch_satsfied = binsof (opcode_cp.Bins_branch) && binsof (btake_cp) intersect {1} && binsof (hpipe_cp) intersect {1}; 
//        bins eq_satsfied    = binsof (opcode_cp.Bins_br_eq)  && binsof (zero_cp)  intersect {1};
//       //   option.cross_auto_bin_max=0;
//       }

//       //operand_B and hold_pipeline
//       alu4: cross B_cp, hpipe_cp {
//        bins hpipe_high = binsof (B_cp) intersect {~seq_item_cov.operand_B[11]} && binsof (hpipe_cp)  intersect {1};
//        //  option.cross_auto_bin_max=0;
//       }

//       //pc and ex
//       alu5: cross opcode_cp, pc_cp, ex_cp, btake_cp, hpipe_cp, A_cp {
//        bins cluster1 = binsof (btake_cp) intersect {1}
//                    && binsof (hpipe_cp)  intersect {1} 
//                    && binsof (pc_cp)     intersect {0}
//                    && binsof (ex_cp)     intersect {1};

//        bins jump = binsof (opcode_cp.Bins_jump) && binsof (A_cp) intersect {!0}
//                    && binsof (hpipe_cp) intersect {1} 
//                    && binsof (pc_cp)    intersect {1} 
//                    && binsof (ex_cp)    intersect {1};  

//        bins cluster2 = binsof (hpipe_cp) intersect {0} 
//                     && binsof (pc_cp)    intersect {0} 
//                     && binsof (ex_cp)    intersect {0};  
//        //  option.cross_auto_bin_max=0;                                      
//       }
          
        endgroup : CovGp 
//constructor
function new (string name = "alu_coverage", uvm_component parent = null);
 super.new(name, parent);
	CovGp = new;
endfunction

//build phase
function void build_phase (uvm_phase phase);
  super.build_phase(phase) ;
  seq_item_cov=alu_seq_item::type_id::create("seq_item_cov",this);
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
	  CovGp .sample();
			end
endtask : run_phase


endclass : alu_coverage	

endpackage : ALU_coverage_collector	