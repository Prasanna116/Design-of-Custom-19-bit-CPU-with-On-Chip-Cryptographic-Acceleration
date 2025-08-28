
//IE STAGE - TO FIND WHICH DATA TO BE READ IN THE DATA MEMORY DEPENDING ON THE OPERATION

module cus19_dm_rd_mux(


input [7:0] rs2_data_in,   //Data to be read from the address located at rs2_in for SP

input [10:0] imm_addr_in, //Data to be read from this address for LOAD OP & Data to be written for STORE OP

input [2:0] opcode_in,
input mem_rd_in,

output wire mem_rd_req,
output reg [10:0] mem_rd_addr);

wire [10:0] rs2_extend;

assign rs2_extend = {3'b0,rs2_data_in};
assign mem_rd_req= mem_rd_in;

always@(*) begin

if(mem_rd_in) begin

    if(opcode_in==3'b001) begin

         mem_rd_addr = imm_addr_in;

    end else if(opcode_in==3'b100) begin

         mem_rd_addr = rs2_extend;

    end
end
end

endmodule

