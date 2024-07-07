`timescale 1ns/1ns

module fetch_tb ();
  
  reg             clk, rst;
  reg             ex     ;
  reg             pc_s0_in , pc_s1_in;
  reg     [31:0]  pc_dec_in , pc_alu_in;
  wire    [31:0]  pc_out ;
  wire    [31:0]  pc_plus4 ;
  
  initial 
  begin
    
    //initial values
    clk          = 'b0     ;
    rst          = 'b0     ;
    ex           = 'b0     ;
    pc_s0_in     = 'b0     ;
    pc_s1_in     = 'b0     ;
    pc_dec_in    = 'b11111 ;
    pc_alu_in    = 'b10001 ;
    ex           = 'b0     ;
    #7
    rst          = 1'b1    ;
    #38
    pc_s0_in     = 'b1     ;
    pc_s1_in     = 'b0     ;
    #10
    pc_s0_in     = 'b0     ;
    pc_s1_in     = 'b0     ;
    #50
    pc_s0_in     = 'b0     ;
    pc_s1_in     = 'b1     ;
    #10
    pc_s0_in     = 'b0     ;
    pc_s1_in     = 'b0     ;
    #50
    pc_s0_in     = 'b1     ;
    pc_s1_in     = 'b1     ;
    #50
    ex           = 'b1     ;
    pc_s0_in     = 'b1     ;
    pc_s1_in     = 'b1     ;
    #10
    ex           = 'b0     ;
    pc_s0_in     = 'b0     ;
    pc_s1_in     = 'b0     ;
    
  #50        
  
    $finish;
  end
  
  // Clock Generator  
  always #5 clk = !clk ;
  
    fetch_cycle DUT (
  .clk(clk),
  .rst(rst),
  .ex (ex ),
  .pc_s0_in(pc_s0_in),
  .pc_s1_in(pc_s1_in),
  .pc_dec_in(pc_dec_in),
  .pc_alu_in(pc_alu_in),
  .pc_out(pc_out),
  .pc_plus4(pc_plus4)
  );
  
endmodule

