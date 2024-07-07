///////////////////////////////////////////////////////////////////////////////
// Engineer:       Mohamed Atef - mohamedatefp3@gmail.com                     //
//                 mostafa mahmoud - mostafamhamoud192@gmail.com              //               
//                                                                            //
// Design Name:    DATA_SAVE                                                  //
// Project Name:   zero-riscy                                                 //
// Language:       Verilog                                                    //
//                                                                            //
// Description:   memory to save the outputs                                  //
////////////////////////////////////////////////////////////////////////////////

module DATA_SAVE (
input                 clk,
input                 rst,
input                 save_hash,
input                 save_data  ,   //output flag from sm4 block after 32 clk to save encrypted data
input                 pull_key_en,   //output from controller to wr the inatial key to sm4 block
input      [255:0]    in_hash    ,   //input hash value 
input      [127:0]    in_data    ,   //encrypted data value
input      [4:0]      address    ,   //address key  
input      [4:0]      rd         ,   //addr of mem_data_save
output reg [31:0]     key

);

reg [255:0] hash_save ;           //register save hash value
reg [31:0]  mem [0:4] ;           //mem save intial key
reg [127:0] mem_data_save[0:4] ;  //mem to save encrypted data

always @ (posedge clk or negedge rst)

begin 

if (!rst)
  
begin
  
hash_save <= 'd0;

mem[0]<= 'h01234567;
mem[1]<= 'h29112000;
mem[2]<= 'h02982000;
mem[3]<= 'h02971959;
mem[4]<= 'h00972001;

mem_data_save[0] <= 'd0;
mem_data_save[1] <= 'd0;
mem_data_save[2] <= 'd0;
mem_data_save[3] <= 'd0;
mem_data_save[4] <= 'd0;

end

else if (pull_key_en)

key <= mem[address];

else if (save_hash)

hash_save <= in_hash;

else if (save_data)

mem_data_save[rd] <= in_data;

else
     begin
           hash_save <= 'd0;
           
           mem_data_save[0] <= 'd0;
           mem_data_save[1] <= 'd0;
           mem_data_save[2] <= 'd0;
           mem_data_save[3] <= 'd0;
           mem_data_save[4] <= 'd0;
           
           mem[0]<= 'h01234567;
           mem[1]<= 'h29112000;
           mem[2]<= 'h02982000;
           mem[3]<= 'h02971959;
           mem[4]<= 'h00972001;
     end
end


endmodule 
