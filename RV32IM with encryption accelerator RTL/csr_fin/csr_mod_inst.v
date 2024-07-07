module csr_mod_inst  #(
	parameter MXLEN          = 32,
	parameter COUNT_LEN      = 64,
	parameter CSR_OP         = 1 ,
	parameter ADDR_WIDTH     = 12,

	//registers
	parameter MTVEC     = 12'h305,
	parameter MEPC      = 12'h341,
	parameter MCAUSE    = 12'h342,

	//unprivleged counters
	parameter CYCLE     = 12'hB00,
	parameter CYCLEH    = 12'hB80,

	parameter TIME      = 12'hC01,
	parameter TIMEH     = 12'hC81,

	parameter INSTRET   = 12'hB02,
	parameter INSTRETH  = 12'hB82
	)

	//------------ports-----------------------

    (  
	  input clk,
	  input rst_n,

  	input excp_int,      //from controller
    input instret_exc,   //from decoder


    input [MXLEN-1:0]           data_wr,    //from GPR
	  input [CSR_OP-1:0]          operation,  //from decoder
    input [ADDR_WIDTH-1:0]      addr,       //from decoder


    output  reg [MXLEN-1:0]        data_out,  //to GPR (mux)
    output  reg error,          //illegal operation (to mux)
    output  reg done           //end of handelling (to controller)

    );

    //---------------M_mode registers--------------
    reg  [MXLEN-1:0]  mtvec;
    reg  [MXLEN-1:0]  mepc;
    reg  [MXLEN-1:0]  mcause;
    reg  [MXLEN-1:0]  base;


  //-------------unprivliged conters-----------
    reg  [COUNT_LEN-1:0] cycle_r;
    wire [COUNT_LEN-1:0] cycle_w;

    reg  [COUNT_LEN-1:0] time_reg_r;
    wire [COUNT_LEN-1:0] time_reg_w;


    reg  [COUNT_LEN-1:0] instret_r;
    wire [COUNT_LEN-1:0] instret_w;

    /*reg flag_r;
    wire flag_w;*/



  //----------counter instances------------------
    wire [COUNT_LEN-1:0] instret_out;
    wire [COUNT_LEN-1:0] cycle_out;
    wire [COUNT_LEN-1:0] real_time_out;

   instret_counter    #(COUNT_LEN) inst (clk, rst_n, instret_exc, instret_w, instret_out);
   cycle_counter      #(COUNT_LEN) cycl (clk, rst_n, cycle_w, cycle_out);
   real_time_counter  #(COUNT_LEN) tim (clk, rst_n, time_reg_w, real_time_out);

  //------------------------------------------------------------------------------------

  always @(posedge clk or negedge rst_n) begin
  //reset
   	if (!rst_n) begin
  		data_out      = 0;
  		error         = 0;
  		done          = 0;
  		mepc          = 0;
  		mtvec         = 0;
  		mcause        = 0;
  		base          = 0;
  		time_reg_r    = 0;
  		instret_r     = 0;
  		cycle_r       = 0;
  	end

  	//exception handelling
  	else if (excp_int) begin
  		if (operation) begin //CSRRW , rd = x0 so no read pre write
  			case (addr) //(write)
  		         MEPC:    begin    mepc   = data_wr; error = 0; data_out = 0; done = 0; end 
  	           MCAUSE:  begin  mcause   = data_wr; error = 0; data_out = 0; done = 0; end
  		         default:  error    = 1;   //illegal operation
  		   endcase
  		end

  	    else if (!operation) begin
  			 case (addr) //(read) (csrrs)
  		       MCAUSE:  begin data_out = mcause; error = 0; mcause = mcause | data_wr;  done = 0; end
  		       MEPC:    begin data_out = mepc;   error = 0; mepc   = mepc   | data_wr;  done = 1; end
  		       MTVEC:    begin
  		       	    case (mcause)
                      //exception cause values with imaginary memory locations
  		       	    	  {28'h8000000,4'h3}: base = 32'h0;   //m software interrupt
	                    {28'h8000000,4'h7}: base = 32'h1;   //m timer interrupt
	                    {28'h8000000,4'hB}: base = 32'h2;   //m external interrupt 
	                    {28'h0000000,4'h0}: base = 32'h4;   //instruction address misalignment
	                    {28'h0000000,4'h2}: base = 32'h000000B4;  //illegal instruction******************
	                    {28'h0000000,4'h3}: base = 32'h6;   //breakpoint
	                    {28'h0000000,4'h4}: base = 32'h7;   //load access misalignment
	                    {28'h0000000,4'h5}: base = 32'h8;   //load access fault
	                    {28'h0000000,4'h6}: base = 32'h9;   //store access misalignment
	                    {28'h0000000,4'h7}: base = 32'hA;   //store access fault
	                    {28'h0000000,4'hB}: base = 32'hB;   //m mode environment call
  		       	    	default            : error = 1;
  		       	    endcase
  		       	         mtvec     = base; 
  		       	         data_out  = mtvec;
  		       	         mtvec     = mtvec | data_wr;  
  		       	         done = 0; error = 0;
  		       end
  		       default           : error= 1;

  		    endcase
  		end 
  	end	  

  		//normal read and write (unlikely)
  	else begin
  		if (!operation) begin //(read)
  			case (addr)
  		      CYCLE:    begin  data_out  = cycle_out [31:0];               error = 0; end
  		      CYCLEH:   begin  data_out  = cycle_out [COUNT_LEN-1:32];     error = 0; end

  		      TIME:     begin  data_out  = real_time_out [31:0];           error = 0; end
  		      TIMEH:    begin  data_out  = real_time_out [COUNT_LEN-1:32]; error = 0; end

  		      INSTRET:  begin  data_out  = instret_out [31:0];             error = 0; end
  		      INSTRETH: begin  data_out  = instret_out [COUNT_LEN-1:32];   error = 0; end

  		      default : error      = 1; 
  		   endcase
  		end
  		
  		else if (operation) begin
  			case (addr) //CSRRW , rd = x0 so no read pre write
  		       CYCLE:    begin  cycle_r  [31:0]             = data_wr; error = 0; data_out = 0;  end
  		       CYCLEH:   begin  cycle_r  [COUNT_LEN-1:32]   = data_wr; error = 0; data_out = 0;  end

  		       TIME:     begin /* time_reg_r [31:0]           <= data_wr; */error = 1; data_out = 0; end
  		       TIMEH:    begin /* time_reg_r [COUNT_LEN-1:32] <= data_wr; */error = 1; data_out = 0; end

  		       INSTRET:  begin  instret_r [31:0]            = data_wr; error = 0; data_out = 0; end
  		       INSTRETH: begin  instret_r[COUNT_LEN-1:32]   = data_wr; error = 0; data_out = 0; end

  		       default : error    = 1;
  		    endcase
  		end 
  	end		
 end
 

  assign cycle_w     = cycle_r;
  assign instret_w  = instret_r;
  assign time_reg_w = time_reg_r;
  //assign flag_w = flag_r;
endmodule
    