module top_sm3(
  
  input    wire             clk          ,  // Clock signal
                            rst          ,  // Reset signal
                            valid_in     ,  // Input valid signal
                            m_sm3        ,  // Enable signal for change message of padding block
                          
  input    wire  [31:0]     message      ,  // Input message
  
  output   wire             hold_pipline ,  // Signal to hold the pipeline
  output   wire   [255:0]   hash_value ,     // Computed hash value
  output   wire			            save_hash              // indicate that the hash_value is ready to store in memory
 
  );
  
  wire            start  ,  // Start signal for the hashing process
                  FLAG   ,  // Flag signal indicating computation state
                  en     ;  // Enable signal for message padding
  
  wire   [511:0]  padded ;  // Padded message
  
  wire   [31:0]   w_0,
                  f_0,
                  w_1,
                  f_1,
                  w_2,
                  f_2,
                  w_3,
                  f_3 ;      // Intermediate variables for message expansion
                  
  wire    [ 6   : 0 ]  s  ;  // Intermediate variable
  
  wire    [ 255 : 0 ]  iv ;  // Intermediate hash value
  
  // Initial vector for the hash
  reg     [ 255 : 0 ]   IV = 'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e ; 
  reg     [ 31  : 0 ]   m                                                                       ;
  
  // Message padding module instantiation
  message_padding  pd 
  (
  .clk   ( clk     ),  // Clock signal
  .rst   ( rst     ),  // Reset signal
  .m     ( m       ),  // Input message
  .start ( start   ),  // Start signal
  .done  ( en      ),  // Done signal
  .padded( padded  )); // Padded message

  // Message expansion module instantiation
   message_expansion  ex
  ( 
  .clk    ( clk    ),  // Clock signal
  .rst    ( rst    ),  // Reset signal
  .en     ( en     ),  // Enable signal
  .padded ( padded ),  // Padded message
  .WJ_0   ( w_0    ),  // Intermediate variable
  .WJ_1   ( w_1    ),  // Intermediate variable
  .WJ_2   ( w_2    ),  // Intermediate variable
  .WJ_3   ( w_3    ),  // Intermediate variable
  .fj_0   ( f_0    ),  // Intermediate variable
  .fj_1   ( f_1    ),  // Intermediate variable
  .fj_2   ( f_2    ),  // Intermediate variable
  .fj_3   ( f_3    ),  // Intermediate variable
  .s      ( s      )); // Intermediate variable
  
  // Compression function module instantiation
  comp c1 
  (
  .clk    ( clk  ),  // Clock signal
  .rst    ( rst  ),  // Reset signal
  .fj_0   ( f_0  ),  // Intermediate variable
  .fj_1   ( f_1  ),  // Intermediate variable
  .fj_2   ( f_2  ),  // Intermediate variable
  .fj_3   ( f_3  ),  // Intermediate variable
  .WJ_0   ( w_0  ),  // Intermediate variable
  .WJ_1   ( w_1  ),  // Intermediate variable
  .WJ_2   ( w_2  ),  // Intermediate variable
  .WJ_3   ( w_3  ),  // Intermediate variable
  .IV     ( iv   ),  // Intermediate hash value
  .s      ( s    ),  // Intermediate variable
  .Flag   ( FLAG ),  // Flag signal
  .temp_v ( iv   )); // Intermediate hash value
 

  
  // Assigning the start signal based on the valid_in and FLAG signals
  assign start        = (!valid_in) ? 'b0        : (!FLAG)  ? 'b1 : 'b0      ;

  // Assigning the hash value based on the reset and FLAG signals 
  assign hash_value   = (!rst)      ? 'h0        : (!FLAG)  ? 'h0 : iv ^ IV  ;
  // Assigning the hash value based on the reset and FLAG signals
  assign save_hash   = (!rst)      ? 'h0        : (!FLAG)  ? 'h0 : 'b1  ;
  
  // Assigning the hold_pipeline signal based on the valid_in and FLAG signals
  assign hold_pipline = (!valid_in) ? 'b0        : (!FLAG)  ? 'b1 : 'b0      ;
  
  // Assigning the massage signal to padding block
  always @(posedge clk or negedge rst)
      begin
        
         if(!rst)
           begin
             m = message ;
           end
           
         else if ( m_sm3 )
           begin
             m = message ;
           end
         end

endmodule
