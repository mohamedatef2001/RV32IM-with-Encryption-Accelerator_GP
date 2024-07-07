module message_expansion (
  
       input wire              clk        , // Clock signal 
                               rst        , // Reset signal
                               en         , // Enable signal
                               
       input wire  [511:0]     padded     , // Padded input message
       
       //Outputs 
       output reg  [31:0]      WJ_0       ,
                               fj_0       ,
                               WJ_1       ,
                               fj_1       ,
                               WJ_2       ,
                               fj_2       ,
                               WJ_3       ,
                               fj_3       ,
                                
       output reg  [6:0]       s            // Step counter
       
       );
       
        // Arrays for storing intermediate words and functions 
       reg [31:0] w [67:0]     ;
       reg [31:0] f [63:0]     ;
       
       // Temporary variables for permutation and intermediate values
       reg [31:0] k            ;    // Argument for permutation function P1
       reg [31:0] p1           ;    // Permutation function P1
  
       reg [6:0]  x            ;    // Loop index
       reg [6:0]  i = 'b0      ;    // Step counter for sequential logic
    
    // Combinational logic block for message expansion  
    always @(*)
      begin
       
       // Initialize w array with padded input message 
       {w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7],w[8],w[9],w[10],w[11],w[12],w[13],w[14],w[15]} <= padded ;
         
         // Compute remaining words w[16] to w[67]
         for ( x = 16 ; x < 68 ; x = x + 1 )
            begin 
              
              // Compute intermediate value k 
              k    =  w[x-16] ^ w[x-9] ^ {w[x-3][16:0],w[x-3][31:17]}  ;
              
              // Compute permutation function P1
              p1   =  k ^ {k[16:0],k[31:17]} ^ {k[8:0],k[31:9]}        ;
              
              // Compute word w[x] based on permutation and previous words
              w[x] =  p1 ^ w[x - 6] ^ {w[x-13][24:0],w[x-13][31:25]}   ;
       
           end
         
         // Compute function f[x] for x from 0 to 63
         for ( x = 0 ; x < 64 ; x = x + 1 )
            begin      
              
              // Compute function f[x] based on words w
              f[x] = w[x] ^ w[x+4] ;
              
           end
     end
    
    
    // Sequential logic block for updating outputs on clock edge 
    always @(posedge clk or negedge rst)
      begin
        
        // Reset all outputs and counters to initial values
         if(!rst)
           begin
              
              s      =   'd64   ;
              WJ_0   =   'b0   ;
              fj_0   =   'b0   ;
              WJ_1   =   'b0   ;
              fj_1   =   'b0   ;
              WJ_2   =   'b0   ;
              fj_2   =   'b0   ;
              WJ_3   =   'b0   ;
              fj_3   =   'b0   ;
              i      =   'b0   ;
         
          end
          
        // When enable is low, set outputs to default values
         else if ( !en )
          begin
            
              s      =   'd64  ;
              WJ_0   =   'b0   ;
              fj_0   =   'b0   ;
              WJ_1   =   'b0   ;
              fj_1   =   'b0   ;
              WJ_2   =   'b0   ;
              fj_2   =   'b0   ;
              WJ_3   =   'b0   ;
              fj_3   =   'b0   ;
              i      =   'b0   ;
          end
      
       else 
         begin 
         
         // Update step counter and outputs based on current step i  
         if ( i < 64 )
           begin
             
              s      =   i            ;
              WJ_0   =   w[ i ]       ;
              fj_0   =   f[ i ]       ;
              WJ_1   =   w[ i + 1 ]   ;
              fj_1   =   f[ i + 1 ]   ;
              WJ_2   =   w[ i + 2 ]   ;
              fj_2   =   f[ i + 2 ]   ;
              WJ_3   =   w[ i + 3 ]   ;
              fj_3   =   f[ i + 3 ]   ;
              i      =   i + 4        ;
                           
           end
         
         // Update step counter when i reaches 64  
         else if ( i == 64 )
           begin
              s      =   'd65   ;
            end
         end  
       end
  endmodule