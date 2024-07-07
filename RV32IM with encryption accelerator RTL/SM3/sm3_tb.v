`timescale 1ns/1ns

// Testbench for SM3 module
module sm3_tb ();
  
  // Input registers
  reg             clk         ,  // Clock signal
                  rst         ,  // Reset signal
                  valid_in    ,  // Input validity signal
                  m_sm3        ; // Enable signal for change message of padding block
                  
  reg   [31:0]    message      ; // Message input
  
  // Output wires
  wire            hold_pipline ; // Pipeline hold signal
  wire  [255:0]   hash_value   ; // Output hash value
  
  initial 
  begin
    $dumpfile("sm3.vcd")       ; // Specify the dump file for waveform
    $dumpvars                  ; // Dump all variables
    
    // Initialize values
    clk      = 'b0             ;
    rst      = 'b0             ;
    message  = 'h0             ;
    valid_in = 'b0             ;
    m_sm3    = 'b0             ;
    
    #10
    rst      = 'b1             ; // De-assert reset after 10ns
    
    // Assert valid_in signal after 5ns
    #5
    valid_in = 'b1             ; 
    m_sm3    = 'b1             ;
    
    #10
    m_sm3    = 'b0             ;
    #10
    message  = 'h2             ;
    #170
    valid_in = 'b0             ; // De-assert valid_in signal after 170ns
    
    #10
    message  = 'h1             ; // Change message input
    valid_in = 'b1             ; // Assert valid_in signal
    m_sm3    = 'b1             ;
    #10
    m_sm3    = 'b0             ;
    #180
    valid_in = 'b0             ; // De-assert valid_in signal
    
    #50
    $finish                    ; // End the simulation
  end
  
  // Clock generator
  always #5 clk = !clk         ; // Toggle clock every 5ns
  
  // Instantiate the SM3 module
  top_sm3  DUT (
    .clk          ( clk          ),
    .rst          ( rst          ),
    .m_sm3        ( m_sm3        ),
    .valid_in     ( valid_in     ),
    .message      ( message      ),
    .hold_pipline ( hold_pipline ),
    .hash_value   ( hash_value   )
  );
  
endmodule
