`timescale 1ns/1ns

module GPRs_TB;

    // Parameters
    parameter CLK_PERIOD = 10;       // Clock period in ns
    
    // Inputs
    reg      [4:0]           read_add_a_tb;
    reg      [4:0]           read_add_b_tb;
    reg      [4:0]           rd_add_tb;
    reg      [31:0]          data_write_tb;
    reg                      write_en_tb;
    reg                      clk_tb;
    reg                      rst_tb;
    
    // Outputs
    wire     [31:0]           data_add_a_tb;
    wire     [31:0]           data_add_b_tb;
    
    
    
    // Instantiate RegisterFile module
    GPRs dut (
    
    //input signals
        .read_add_a(read_add_a_tb),
        .read_add_b(read_add_b_tb),
        .rd_add(rd_add_tb),          //address of the destination reg for write opration
        .data_write(data_write_tb),
        .write_en(write_en_tb),
        .clk(clk_tb),
        .rst(rst_tb),
        
    //output signals  
        .data_add_a(data_add_a_tb),
        .data_add_b(data_add_b_tb)
    );
    
    
    // Clock generation
    always #((CLK_PERIOD)/2) clk_tb = ~clk_tb;
    
    // Initializations
    initial begin
        // Initialize inputs
         // Reset
        rst_tb = 0;
        clk_tb = 1;
        #10
        rst_tb = 1;      
        
        
        // Test write operation
        write_en_tb = 1;
        rd_add_tb = 5'b00011;     //writ data in "X3"
        read_add_a_tb = 5'b00000;    //assume address of operand "a" point on reg X0
        read_add_b_tb = 5'b00001;    //assume address of operand "b" point on reg X1
        #10
        data_write_tb = 32'hABCDEF01;
        #10
         
        
        
        // Test read operation
          write_en_tb = 0;
          read_add_b_tb = 5'b00011;    //read from X3  => hABCDEF01
          read_add_a_tb = 5'b00010;   //read from X2   => 0  from rst operation
        
        
        // End simulation
          #70
         $finish;
    end

endmodule
