
// PIPELINE STAGE 2 from DECODE TO EXECUTE

module regblock_id_to_ie(

input clk_in,
input rst_in,

//FROM DECODER

input [2:0] opcode_out,
input [3:0] funct_out,
input [10:0] imm_addr_out, 
input [3:0] wb_addr_out, //FOR WRITE_BACK

//FROM CONTROL UNIT

input alu_en_out,  //FOR ALU
input mem_rd_out,  //FOR LOAD & SP
input mem_wr_out,  //FOR STORE & SP
input reg_wr_out,  //FOR LOAD
input start,       //FOR SP
input mode_enc_dec_out, //FOR SP
input wr_back_sel_out, //FOR WRITE_BACK

//FROM REGISTER FILES

input [7:0] rs1_out,
input [7:0] rs2_out,

//OUTPUTS

output reg [2:0] opcode_in,
output reg [3:0] funct_in,
output reg [10:0] imm_addr_in, 
output reg [3:0] wb_addr_in, //FOR WRITE_BACK

output reg alu_en_in,  //FOR ALU
output reg mem_rd_in,  //FOR LOAD & SP
output reg mem_wr_in,  //FOR STORE & SP
output reg reg_wr_in,  //FOR LOAD
output reg start_in,       //FOR SP
output reg mode_enc_dec_in, //FOR SP
output reg wr_back_sel_in, //FOR WRITE_BACK

output reg [7:0] rs1_in,
output reg [7:0] rs2_in
);

always@(posedge clk_in or negedge rst_in) begin

if(!rst_in) begin

opcode_in<=0;
funct_in<=0;
imm_addr_in<=0;
wb_addr_in<=0;
alu_en_in<=0;
mem_rd_in<=0;
mem_wr_in<=0;
reg_wr_in<=0;
start_in<=0;
mode_enc_dec_in<=0;
wr_back_sel_in<=0;
rs1_in<=0;
rs2_in<=0;

end else begin


opcode_in <= opcode_out;
funct_in <= funct_out;
imm_addr_in <= imm_addr_out;
wb_addr_in <= wb_addr_out;
alu_en_in <= alu_en_out;
mem_rd_in <= mem_rd_out;
mem_wr_in <= mem_wr_out;
reg_wr_in <= reg_wr_out;
start_in <= start;
mode_enc_dec_in <= mode_enc_dec_out;
wr_back_sel_in <= wr_back_sel_out;
rs1_in <= rs1_out;
rs2_in <= rs2_out;

end
end


endmodule
