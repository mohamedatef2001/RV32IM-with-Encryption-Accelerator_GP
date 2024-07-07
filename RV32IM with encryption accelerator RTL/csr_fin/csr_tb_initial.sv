module csr_tb_initial();

    parameter MXLEN     = 32;
	parameter COUNT_LEN = 64;
	//registers
	parameter MTVEC     = 32'h305;
	parameter MEPC      = 32'h341;
	parameter MCAUSE    = 32'h342;
	//unprivleged counters
	parameter CYCLE     = 12'hB00;
	parameter CYCLEH    = 12'hB80;

	parameter TIME      = 12'hC01;
	parameter TIMEH     = 12'hC81;

	parameter INSTRET   = 12'hB02;
	parameter INSTRETH  = 12'hB82;
	
	//declaration 
	bit clk, rst_n, excp_int, operation, instret_exc, error;
	bit [11:0]  addr;
	reg   [MXLEN-1:0]     data_wr;
	logic [MXLEN-1:0]     data_out;

    

    //instatiation 
    csr_mod_inst DUT (
    	.clk(clk), .rst_n(rst_n),
    	.excp_int(excp_int), 
    	.operation(operation),
    	.instret_exc(instret_exc),
    	.addr(addr), .data_wr(data_wr),
    	.data_out(data_out),
        .error(error), .done(done)
    	);

    //clk generation
    initial begin
	   clk = 0;
	   forever
	   #1 clk = ~clk;
    end 


    //stimulus
    initial begin
    	//test reset priority
    	rst_n = 0; excp_int = 1; operation = 1; addr = MEPC; data_wr = 32'h45456767; instret_exc = 1;
    	#10

    	//test excp_int prority
    	rst_n = 1; 
    	//test wr in mepc
    	#10

    	//test rd in mepc
    	operation = 0; data_wr = 32'h67891088;
    	#10

    	//test wr in mcause
    	addr = MCAUSE; data_wr = 32'h32324141; operation = 1;
    	#10

    	//test rd in mcause
    	operation = 0; data_wr = 32'h67891088;
    	#10

    	//test error when wr in mtvec
    	addr = MTVEC; data_wr = 32'h12121212; operation = 1;
    	#10

    	//test read from mtvec
    	addr = MCAUSE; data_wr = {28'h0000000,4'h2}; operation = 1; 
    	#10
    	addr = MTVEC; operation = 0; data_wr = 32'h67891088;
    	#10

    	//test cycle read
    	operation = 0; addr = CYCLE; excp_int = 0;
    	#10
    	addr = CYCLEH;
    	#10

    	//test cycle write
    	operation = 1; addr = CYCLE; excp_int = 0; data_wr = 32'h77776666;
    	#10
    	addr = CYCLEH;
    	#10

    	//test cycle read again
    	operation = 0; addr = CYCLE; excp_int = 0; data_wr = 32'h0;
    	#10
    	addr = CYCLEH;
    	#10

    	//test instret read
    	operation = 0; addr = INSTRET; excp_int = 0;
    	#10
    	addr = INSTRETH;
    	#10

    	//test instret write
    	operation = 1; addr = INSTRET; excp_int = 0; data_wr = 32'h44884488;
    	#10
    	addr = INSTRETH;
    	#10

    	//test cycle read again
    	operation = 0; addr = INSTRET; excp_int = 0;
    	#10
    	addr = INSTRETH;
    	#10







    #10;
    $stop;
    end

endmodule : csr_tb_initial