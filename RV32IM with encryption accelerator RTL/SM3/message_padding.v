module message_padding (

  // Input signals
  input                  clk   ,   // Clock signal
  input                  rst   ,   // Reset signal
  input                  start ,   // Start signal
  input          [31:0]  m     ,   // Message input

  // Output signals
  output   reg           done,    // Done signal
  output   reg   [511:0] padded   // Padded message output
);

always @(posedge clk or negedge rst)
begin
  // Reset logic
  if(!rst)
    begin
      padded  =  'b0 ;  // Reset padded output to 0
      done    =  'b0 ;  // Reset done signal to 0
    end
  // Padding logic
  else if (start == 'b01 || start == 'b10)
    begin
      padded  = ( { m , 1'b1 , 415'b0 , 64'b100000  } );  // Pad the message
      done    = 'b1                                    ;  // Set done signal to 1
    end
  // Default case
  else 
    begin
      done  = 'b0;  // Set done signal to 0
    end
end

endmodule
 
