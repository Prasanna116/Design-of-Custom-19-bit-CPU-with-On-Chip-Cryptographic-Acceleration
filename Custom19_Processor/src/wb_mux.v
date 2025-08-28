// WRITE BACK STAGE - To Write Back either ALU or LOAD or SPECIAL OP Output to REGISTER FILE

module wb_mux(

input [15:0] alu_op_in,  //ALU Operation Output - to be stored in rd
input [15:0] ld_op_in,   //LOAD Operation Output - to be stored in rs1 


input wr_mux_sel_out_sync,

output reg [15:0] final_operation_op);

always@(*) begin

case(wr_mux_sel_out_sync)

1'b0: final_operation_op = alu_op_in;  //ALU OP

1'b1: final_operation_op = ld_op_in;   //LD OP


default: final_operation_op=16'b0;

endcase

end

endmodule
