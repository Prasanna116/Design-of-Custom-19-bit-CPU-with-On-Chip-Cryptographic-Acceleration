module cus19_integer_file #(
    parameter Data_Width = 8,
    parameter Reg_Addr_Width = 4
)(
    input clk_in,
    input rst_in,

    input [Reg_Addr_Width-1:0] rs1_addr_in,
    input [Reg_Addr_Width-1:0] rs2_addr_in,

    input wr_en_in,
    input [Reg_Addr_Width-1:0] wr_addr_in,
    input [(2*Data_Width)-1:0] wr_data_in, //Need to check - MUL and DIV operation

    output [Data_Width-1:0] rs1_out,
    output [Data_Width-1:0] rs2_out
);

integer i;
reg [Data_Width-1:0] reg_file [0:32];

// Reset + Write
always @(posedge clk_in or negedge rst_in) begin
    if (!rst_in) begin
        for (i = 0; i < 32; i = i+1) begin
            reg_file[i] <= {Data_Width{1'b0}};
        end
    end 
    else begin
        if (wr_en_in) begin
            reg_file[wr_addr_in] <= wr_data_in[7:0];
            reg_file[wr_addr_in+1] <= wr_data_in[15:8]; // Need to check - MUL and DIV operation
        end
    end
end

// Read with simple forwarding
assign rs1_out = ((wr_en_in==1) && (rs1_addr_in == wr_addr_in)) ? wr_data_in[7:0] : reg_file[rs1_addr_in];
assign rs2_out = ((wr_en_in==1) && (rs2_addr_in == wr_addr_in)) ? wr_data_in[7:0] : reg_file[rs2_addr_in];

endmodule

