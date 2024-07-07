module Mux (a,b,c,d,ex,s,out);
    input                ex      ;
    input        [31:0]  a,b,c,d ;
    input        [1:0]   s;
    output       [31:0]  out;
    
    reg          [31:0]   Handling_add =  'h98  ;
    
    assign out  = (ex)         ? Handling_add : (s == 2'b11) ? a : (s == 2'b10) ? b : (s == 2'b01) ? c : (s == 2'b00) ? d : 'b0 ;
    
endmodule

