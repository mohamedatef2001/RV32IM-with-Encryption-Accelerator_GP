module GPRs(
  
  //inputs
  input              [4:0]       read_add_a,
  input              [4:0]       read_add_b,
  input              [4:0]       rd_add,              //address of the destination reg for write opration
    
  input              [31:0]      data_write,          // input of result after operations
  input                          write_en,clk,rst,
  
  //outputs
  output          [31:0]      data_add_a,data_add_b
  
  );
  


     


// Define 32 registers, each 32 bits wide
  reg     [31:0]      reg_file[31:0];
  
 /* 
  // Assign outputs
  assign data_add_a = reg_file[read_add_a];
  assign data_add_b = reg_file[read_add_b];  
  
  */
  
  integer  i;
  
  always@(posedge clk or negedge rst)
   begin
     if (~rst)
       
       begin
         for(i = 0; i < 27; i= i + 1)
              reg_file[i] <= 0;
        
              
         reg_file[27] <= {28'h0000000,4'h2};
       
         for(i = 28; i < 32; i= i + 1)
              reg_file[i] <= 0;
       
       
     
     end
       
   else if(write_en)
     
       begin
         reg_file[rd_add] <= data_write;
       end
       
  end
       
  assign data_add_a = reg_file[read_add_a];
  assign data_add_b = reg_file[read_add_b];  
       
  
  
  endmodule  
       
       
       
       
       
       
  