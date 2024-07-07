///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                                                                            //               
//                                                                            //
// Design Name:    SM4_CONTROLLER                                             //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //                                 //
////////////////////////////////////////////////////////////////////////////////
module SM4_CONTROLLER (
  input                   clk                  ,
  input                   rest                 ,
  input                   valid_in             ,
  output reg              hold_pipline         ,
  output reg              save_data            ,
  output wire [5:0]       counter                 
  );
  
//---------------------------------------------//

  localparam IDEL       = 1'b0,
             ENCRYPTION = 1'b1;   
//---------------------------------------------//

  reg        next_state            ;
  reg        current_state         ;   
  reg [31:0] sm4_enc               ;
//--------------------------------------------*//
         
always@(posedge clk or negedge rest)
begin
  if(!rest)
    begin
      current_state <= IDEL ;
    end
  else
    begin
       current_state <= next_state ;
     end
end
//---------------------------------------------//

always@(*)
begin
  case(current_state)
    IDEL :
     begin
       if(valid_in)
           next_state = ENCRYPTION ;
         else
           next_state = IDEL       ;
     end
     
     
    ENCRYPTION :
     begin
        if(valid_in)
           next_state = ENCRYPTION ;
         else
           next_state = IDEL       ;
     end
  endcase
end
//---------------------------------------------//

always@(*)
begin
hold_pipline = 0;
save_data    = 0;
   case(current_state)
    IDEL  :
     begin
       hold_pipline = 0;
       save_data    = 0;
     end
     
    ENCRYPTION :
     begin
       case(sm4_enc)
         'd0 :
          begin 
            if (valid_in)
              begin
            hold_pipline = 'd1    ;
            save_data    = 'd0    ;
              end
          else
            begin
            hold_pipline = 'd0    ;
            save_data   = 'd0     ;
            end
          end
          
          'd32 :
          begin 
            hold_pipline = 'd0          ;
            save_data    = 'd1          ;
          end 
          
      default : 
        begin
            hold_pipline = 'd1          ;
            save_data    = 'd0          ;
        end 
       endcase 
     end
   endcase
 end
 //-----------------------------------------//
/* 
 always@(posedge clk or negedge rest)
 begin
   if(!rest)
     data_out_enc <= 'd0;
    else
     data_out_enc <= mux_out;
 end
 */
 //------------------------------------------//
 
 always@(posedge clk or negedge rest)
 begin
   if(!rest)
     sm4_enc  <= 'd0           ;
   else if (valid_in)
     sm4_enc  <= sm4_enc + 'd1 ;
   else
     sm4_enc  <= 'd0           ;
 end
 
assign counter = sm4_enc      ;
endmodule 


