`timescale  1ns/1ps

module cus19_pc_tb;

localparam PC_Width =11;
localparam Stack_Depth=8;

reg clk,rst;

reg [PC_Width-1:0] pc_in;

reg [2:0] pc_src_in;

reg [PC_Width-1:0] imm_addr_in;

wire [PC_Width-1:0] pc_mux_out;

cus19_pc #(.PC_Width(PC_Width),.Stack_Depth(Stack_Depth) ) utt(clk,rst,pc_in,pc_src_in,imm_addr_in, pc_mux_out);

initial begin 

clk=0;
forever #5 clk=~clk;

end

initial begin
  
  $dumpfile ("cus19_pc_tb.vcd");
  $dumpvars(0,cus19_pc_tb);
  
rst=0;
clk=0;
pc_in=0;
pc_src_in=0;
imm_addr_in=0;

#10

rst=1;

//Case1 :  Normal Operation
pc_in=11'd0;
pc_src_in=3'b000;
#10;

//Case2 : Branch Operation
pc_in=11'd5;
imm_addr_in=11'd5;
pc_src_in=3'b001;
#10;

//Case3 : Jump Operation
pc_in=11'd10;
imm_addr_in=11'd2;
pc_src_in=3'b010;
#10;

//Case4 : Call Operation
pc_in=11'd15;
imm_addr_in=11'd10;
pc_src_in=3'b011;
#10;

//Case5 : Return Operation
pc_src_in=3'b100;
#10;

$finish;
end

endmodule

