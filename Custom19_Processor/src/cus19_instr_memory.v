module cus19_instr_memory #(parameter PC_Width=11, parameter Instr_Width=19) //IF STAGE
(
input clk_in,
input rst_in,

input [PC_Width-1:0] instr_mem_in,

output reg [Instr_Width-1:0] cus19_instr);

reg  [Instr_Width-1:0] mem [0:(1<<PC_Width)-1]; //Instruction Memory - The instr is written into it using TESTBENCH

always@(posedge clk_in or negedge rst_in) begin

if(!rst_in) begin

cus19_instr<=0;

end else begin

cus19_instr<= mem[instr_mem_in];

end
end

endmodule 