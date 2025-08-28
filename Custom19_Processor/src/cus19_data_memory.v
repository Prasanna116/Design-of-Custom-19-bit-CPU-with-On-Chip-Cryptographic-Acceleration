// MEMORY STAGE - Used mainly for Load and Store Operation.
// LD - To load the data from DM to Register File(RF).
// ST - To store the data from RF to DM.
// PIPELINE STAGE 3 
module cus19_data_memory #(
    parameter Mem_Addr_Width = 11,
    parameter Data_Width     = 8
)(
    input  wire                    clk_in,
    input  wire                    rst_in,

    input  wire                    mem_rd_in,   // Enable to read a data
    input  wire [Mem_Addr_Width-1:0] rd_addr_in, // READ ADDRESS

    input  wire                    mem_wr_in,   // Enable to write a data
    input  wire [Mem_Addr_Width-1:0] wr_addr_in, // WRITE ADDRESS
    input  wire [Data_Width-1:0]     wr_data_in, // WRITE DATA

    output wire [Data_Width-1:0]     rd_data_out // READ DATA
);

    // 8-bit wide, 2^Mem_Addr_Width deep memory
    reg [Data_Width-1:0] data_mem [(1<<Mem_Addr_Width)-1:0];

    integer i;

    // Memory operations
    always @(posedge clk_in or negedge rst_in) begin
        if (!rst_in) begin
            // Reset memory contents
            for (i = 0; i < (1<<Mem_Addr_Width); i = i+1) begin
                data_mem[i] <= {Data_Width{1'b0}};
            end
        end 
        else begin
            // WRITE (priority: you can choose if read should override write)
            if (mem_wr_in) begin
                data_mem[wr_addr_in] <= wr_data_in;
            end

        end
    end

assign rd_data_out = (mem_rd_in) ? (data_mem[rd_addr_in]) : 8'bz;

endmodule
