// IE STAGE - STORE OP (M-TYPE) - ST addr, r1

module cus19_store_unit (
    input  wire        mem_wr_in,     // Store enable
    input  wire [10:0] imm_addr_in,   // Address from instruction (immediate or offset)
    input  wire [7:0]  rs1_data_in,   // Data from register file (r1)

    output reg  [10:0] dm_wr_addr_out, // Address to Data Memory
    output reg  [7:0]  dm_wr_data_out, // Data to Data Memory
    output reg         dm_write_req    // Write request signal
);

always @(*) begin
    if (mem_wr_in) begin
        dm_wr_addr_out = imm_addr_in;   // Send address to DM
        dm_wr_data_out = rs1_data_in;   // Send data to DM
        dm_write_req   = 1'b1;          // Assert write enable
    end else begin
        dm_wr_addr_out = 11'b0;
        dm_wr_data_out = 8'b0;
        dm_write_req   = 1'b0;
    end
end

endmodule

