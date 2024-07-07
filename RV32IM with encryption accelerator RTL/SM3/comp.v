module comp (
  
    input     wire           clk     ,   // Clock signal
                             rst     ,   // Reset signal
    //outputs of expantion                       
    input     wire  [31:0]   WJ_0    ,   
                             WJ_1    ,   
                             WJ_2    ,   
                             WJ_3    ,   
                             fj_0    ,   
                             fj_1    ,   
                             fj_2    ,   
                             fj_3    ,   
                            
    input     wire   [255:0] IV      ,   // Input vector                  
    input     wire   [6:0]   s       ,   // Step counter
    
    output    reg            Flag    ,   // the loop is end if Flag = 'b1 
    output    reg    [255:0] temp_v      // Temporary output vector
    );
    
    // Initial vector (constant)
    reg   [255:0]  iv = 'h7380166f4914b2b9172442d7da8a0600a96f30bc163138aae38dee4db0fb0e4e;

    // Loop counters
    reg   [5:0]    i  = 'b0   ;
    reg   [5:0]    j  = 'b0   ;
                 
    // Working variables for the hash computation
    reg   [31:0]   A = 'b0    ,
                   B = 'b0    ,
                   C = 'b0    , 
                   D = 'b0    , 
                   E = 'b0    , 
                   F = 'b0    , 
                   G = 'b0    , 
                   H = 'b0     ;
                   
    // Temporary variables for computation
    reg   [31:0]   tj    =  'b0 ,
                   x     =  'b0 ,
                   ss1   =  'b0 ,
                   ss2   =  'b0 ,
                   tt1   =  'b0 ,
                   tt2   =  'b0 ,
                   FF    =  'b0 ,
                   GG    =  'b0 ,
                   shift =  'b0   ;

// Sequential block triggered on clock's positive edge or reset's negative edge
always @(posedge clk or negedge rst)
    begin
        //Initial value
        Flag = 'b0 ;
      
        // Reset temp_v to 0 when rst is low
        if (!rst)
        begin
            temp_v = 'b0 ; // Reset temp_v to 0 when rst is low
        end
        
        // Reset temp_v to 0 when s == 64
        else if ( s == 'd64 )
        begin
            temp_v = 'b0 ; 
        end 
        
        
        else if ( s < 'd64 )  
        begin
            if ( s == 'b0 )
            begin
                {A,B,C,D,E,F,G,H} = iv; // Initialize A-H with iv when s is 0
            end
            else
            begin 
                {A,B,C,D,E,F,G,H} = IV; // Load A-H from IV for other values of s
            end
               
            // Main computation loop
            for( i = 0 ; i < 'h4 ; i = i + 'b1 )
            begin 
                j = s + i; // Calculate the current step index
              
                // Determine the value of tj based on the step index
                if ( s < 16 )
                begin
                    tj = 'h79cc4519 ;
                end
                else
                begin 
                    tj = 'h7a879d8a ;
                end
               
                // Perform shifting operations based on the step index
                case(j)
                    'd00: shift = tj;
                    'd01: shift = { tj[31 - 1  : 0 ] , tj[ 31 : 31 - 1  + 1] };
                    'd02: shift = { tj[31 - 2  : 0 ] , tj[ 31 : 31 - 2  + 1] };
                    'd03: shift = { tj[31 - 3  : 0 ] , tj[ 31 : 31 - 3  + 1] };
                    'd04: shift = { tj[31 - 4  : 0 ] , tj[ 31 : 31 - 4  + 1] };
                    'd05: shift = { tj[31 - 5  : 0 ] , tj[ 31 : 31 - 5  + 1] };
                    'd06: shift = { tj[31 - 6  : 0 ] , tj[ 31 : 31 - 6  + 1] };
                    'd07: shift = { tj[31 - 7  : 0 ] , tj[ 31 : 31 - 7  + 1] };
                    'd08: shift = { tj[31 - 8  : 0 ] , tj[ 31 : 31 - 8  + 1] };
                    'd09: shift = { tj[31 - 9  : 0 ] , tj[ 31 : 31 - 9  + 1] };
                    'd10: shift = { tj[31 - 10 : 0 ] , tj[ 31 : 31 - 10 + 1] };
                    'd11: shift = { tj[31 - 11 : 0 ] , tj[ 31 : 31 - 11 + 1] };
                    'd12: shift = { tj[31 - 12 : 0 ] , tj[ 31 : 31 - 12 + 1] };
                    'd13: shift = { tj[31 - 13 : 0 ] , tj[ 31 : 31 - 13 + 1] };
                    'd14: shift = { tj[31 - 14 : 0 ] , tj[ 31 : 31 - 14 + 1] };
                    'd15: shift = { tj[31 - 15 : 0 ] , tj[ 31 : 31 - 15 + 1] };
                    'd16: shift = { tj[31 - 16 : 0 ] , tj[ 31 : 31 - 16 + 1] };
                    'd17: shift = { tj[31 - 17 : 0 ] , tj[ 31 : 31 - 17 + 1] };
                    'd18: shift = { tj[31 - 18 : 0 ] , tj[ 31 : 31 - 18 + 1] };
                    'd19: shift = { tj[31 - 19 : 0 ] , tj[ 31 : 31 - 19 + 1] };
                    'd20: shift = { tj[31 - 20 : 0 ] , tj[ 31 : 31 - 20 + 1] };
                    'd21: shift = { tj[31 - 21 : 0 ] , tj[ 31 : 31 - 21 + 1] };
                    'd22: shift = { tj[31 - 22 : 0 ] , tj[ 31 : 31 - 22 + 1] };
                    'd23: shift = { tj[31 - 23 : 0 ] , tj[ 31 : 31 - 23 + 1] };
                    'd24: shift = { tj[31 - 24 : 0 ] , tj[ 31 : 31 - 24 + 1] };
                    'd25: shift = { tj[31 - 25 : 0 ] , tj[ 31 : 31 - 25 + 1] };
                    'd26: shift = { tj[31 - 26 : 0 ] , tj[ 31 : 31 - 26 + 1] };
                    'd27: shift = { tj[31 - 27 : 0 ] , tj[ 31 : 31 - 27 + 1] };
                    'd28: shift = { tj[31 - 28 : 0 ] , tj[ 31 : 31 - 28 + 1] };
                    'd29: shift = { tj[31 - 29 : 0 ] , tj[ 31 : 31 - 29 + 1] };
                    'd30: shift = { tj[31 - 30 : 0 ] , tj[ 31 : 31 - 30 + 1] };
                    'd31: shift = { tj[31 - 31 : 0 ] , tj[ 31 : 31 - 31 + 1] };
                    'd32: shift = tj;
                    'd33: shift = { tj[31 - 1  : 0 ] , tj[ 31 : 31 - 1  + 1] };
                    'd34: shift = { tj[31 - 2  : 0 ] , tj[ 31 : 31 - 2  + 1] };
                    'd35: shift = { tj[31 - 3  : 0 ] , tj[ 31 : 31 - 3  + 1] };
                    'd36: shift = { tj[31 - 4  : 0 ] , tj[ 31 : 31 - 4  + 1] };
                    'd37: shift = { tj[31 - 5  : 0 ] , tj[ 31 : 31 - 5  + 1] };
                    'd38: shift = { tj[31 - 6  : 0 ] , tj[ 31 : 31 - 6  + 1] };
                    'd39: shift = { tj[31 - 7  : 0 ] , tj[ 31 : 31 - 7  + 1] };
                    'd40: shift = { tj[31 - 8  : 0 ] , tj[ 31 : 31 - 8  + 1] };
                    'd41: shift = { tj[31 - 9  : 0 ] , tj[ 31 : 31 - 9  + 1] };
                    'd42: shift = { tj[31 - 10 : 0 ] , tj[ 31 : 31 - 10 + 1] };
                    'd43: shift = { tj[31 - 11 : 0 ] , tj[ 31 : 31 - 11 + 1] };
                    'd44: shift = { tj[31 - 12 : 0 ] , tj[ 31 : 31 - 12 + 1] };
                    'd45: shift = { tj[31 - 13 : 0 ] , tj[ 31 : 31 - 13 + 1] };
                    'd46: shift = { tj[31 - 14 : 0 ] , tj[ 31 : 31 - 14 + 1] };
                    'd47: shift = { tj[31 - 15 : 0 ] , tj[ 31 : 31 - 15 + 1] };
                    'd48: shift = { tj[31 - 16 : 0 ] , tj[ 31 : 31 - 16 + 1] };
                    'd49: shift = { tj[31 - 17 : 0 ] , tj[ 31 : 31 - 17 + 1] };
                    'd50: shift = { tj[31 - 18 : 0 ] , tj[ 31 : 31 - 18 + 1] };
                    'd51: shift = { tj[31 - 19 : 0 ] , tj[ 31 : 31 - 19 + 1] };
                    'd52: shift = { tj[31 - 20 : 0 ] , tj[ 31 : 31 - 20 + 1] };
                    'd53: shift = { tj[31 - 21 : 0 ] , tj[ 31 : 31 - 21 + 1] };
                    'd54: shift = { tj[31 - 22 : 0 ] , tj[ 31 : 31 - 22 + 1] };
                    'd55: shift = { tj[31 - 23 : 0 ] , tj[ 31 : 31 - 23 + 1] };
                    'd56: shift = { tj[31 - 24 : 0 ] , tj[ 31 : 31 - 24 + 1] };
                    'd57: shift = { tj[31 - 25 : 0 ] , tj[ 31 : 31 - 25 + 1] };
                    'd58: shift = { tj[31 - 26 : 0 ] , tj[ 31 : 31 - 26 + 1] };
                    'd59: shift = { tj[31 - 27 : 0 ] , tj[ 31 : 31 - 27 + 1] };
                    'd60: shift = { tj[31 - 28 : 0 ] , tj[ 31 : 31 - 28 + 1] };
                    'd61: shift = { tj[31 - 29 : 0 ] , tj[ 31 : 31 - 29 + 1] };
                    'd62: shift = { tj[31 - 30 : 0 ] , tj[ 31 : 31 - 30 + 1] };
                    'd63: shift = { tj[31 - 31 : 0 ] , tj[ 31 : 31 - 31 + 1] };
                endcase
         // Calculate the value of FF $ GG 
         if ( s < 16 )
               begin
                 FF                =  A ^ B ^ C  ;
                 GG                =  E ^ F ^ G  ;
               end
             else
               begin 
                 FF                =  ( A & B ) | ( A  & C ) | ( B & C ) ;
                 GG                =  ( E & F ) | ( ( ~ E ) & G ) ;
               end
             
             
              // Calculate the value of ss1 $ ss2 
              x                    =  (  {  A[19:0]     ,   A[31:20] }     ) + E + shift     ;  ///////argument of ss1 in purpose 
			        ss1                  =  (  {  x[24:0]     ,   x[31:25] }     )                 ;
     				     ss2                  =  ss1 ^ ( { A[19:0] ,   A[31:20] }     )                 ;
     				     
 				  // Calculate the value of tt1 & tt2
 				  case(i)
				       'd0: 
				        begin
				         tt1               =  FF + D + ss2 + fj_0       ;
        			      tt2               =  GG + H + ss1 + WJ_0       ;
				        end
				       'd1:
				        begin
				         tt1               =  FF + D + ss2 + fj_1       ;
        			      tt2               =  GG + H + ss1 + WJ_1       ;
				        end
				       'd2:
				        begin
				         tt1               =  FF + D + ss2 + fj_2       ;
        			      tt2               =  GG + H + ss1 + WJ_2       ;
				        end
				       'd3:
				        begin
				         tt1               =  FF + D + ss2 + fj_3       ;
        			      tt2               =  GG + H + ss1 + WJ_3       ;
				        end
				      endcase 
				      
				      // Update the values of A-H based on calculated values  
       				   D                    =  C                            ;
       				   C                    =  ( { B[22:0] , B[31:23] } )   ;
			        B                    =  A                            ;
       				   A                    =  tt1                          ;
       				   H                    =  G                            ;
       				   G                    =  ( { F[12:0] , F[31:13] } )   ;
              F                    =  E                            ;
        			   E                    =  tt2 ^ ( { tt2[22:0] , tt2[31:23] } ) ^ ( { tt2[14:0] , tt2[31:15] } )  ;
   			       
   			       // Update temp_v with new values of A-H
             temp_v[255:224] = A;
             temp_v[223:192] = B;
             temp_v[191:160] = C;
             temp_v[159:128] = D;
             temp_v[127:96]  = E;
             temp_v[95:64]   = F;
             temp_v[63:32]   = G;
             temp_v[31:0]    = H;
      			   end
    			   end
  			   else Flag = 'b1 ;
			  end                   
  endmodule
