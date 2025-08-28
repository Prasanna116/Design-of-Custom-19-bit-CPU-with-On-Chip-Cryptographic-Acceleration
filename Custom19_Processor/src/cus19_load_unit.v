// IE STAGE - LOAD INSTRUCTION (M TYPE) - LD r1, addr

module cus19_load_unit (
    input  wire [7:0]  dm_rd_data_in, // The addr from the instruction is sent to Data Memory and the data is retrieved.
                                      //From this block it will be sent to Write back MUX.

    input  wire        reg_wr_in,     // Register write enable

    output reg  [15:0] ld_data_out    // Data to Register File (via WB mux)
);

always @(*) begin
    if (reg_wr_in) begin
        // Zero-extend 8-bit memory data to 16-bit register
        ld_data_out = {8'b0, dm_rd_data_in};
    end else begin
        // If reg_wr_in not enabled, better to "hold last value" or drive X
        ld_data_out = 16'b0;  
    end
end

endmodule
