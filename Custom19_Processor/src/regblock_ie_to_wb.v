
// PIPELINE STAGE 4 EXECUTE TO DATA MEMORY TO WRITE BACK

module regblock_ie_to_wb (

input clk_in,
input rst_in,

//FROM ALU UNIT
input [15:0] alu_result_in,

//FROM LOAD UNIT
input [15:0] ld_data_in,

//FOR WRITE BACK
input [3:0] wb_addr_in,
input wr_back_sel_in,
input reg_wr_in,

output reg [15:0] alu_result_out,
output reg [15:0] ld_data_out,

output reg [3:0] wb_addr_out,
output reg wr_back_sel_out,
output reg reg_wr_out
);

always@(posedge clk_in or negedge rst_in) begin

if(!rst_in) begin

alu_result_out <=0;
ld_data_out <=0;

wb_addr_out <=0;
wr_back_sel_out <=0;
reg_wr_out<=0;
end else begin

alu_result_out <= alu_result_in;
ld_data_out <= ld_data_in;

wb_addr_out <= wb_addr_in;
wr_back_sel_out <= wr_back_sel_in;
reg_wr_out <= reg_wr_in;
end
end

endmodule



