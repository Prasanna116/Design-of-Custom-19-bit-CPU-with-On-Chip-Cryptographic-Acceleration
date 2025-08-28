`timescale 1ns/1ps

module cus19_data_memory_tb;

    // Parameters
    localparam Mem_Addr_Width = 4;   // small depth (16)
    localparam Data_Width     = 8;

    // TB signals
    reg                     clk;
    reg                     rst;
    reg                     mem_rd;
    reg  [Mem_Addr_Width-1:0] rd_addr;
    reg                     mem_wr;
    reg  [Mem_Addr_Width-1:0] wr_addr;
    reg  [Data_Width-1:0]     wr_data;
    wire [Data_Width-1:0]     rd_data;

    // DUT instantiation
    cus19_data_memory #(
        .Mem_Addr_Width(Mem_Addr_Width),
        .Data_Width(Data_Width)
    ) dut (
        .clk_in(clk),
        .rst_in(rst),
        .mem_rd_in(mem_rd),
        .rd_addr_in(rd_addr),
        .mem_wr_in(mem_wr),
        .wr_addr_in(wr_addr),
        .wr_data_in(wr_data),
        .rd_data_out(rd_data)
    );

    // Clock gen
    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0; rst = 0;
        mem_rd = 0; mem_wr = 0;
        wr_addr = 0; wr_data = 0;
        rd_addr = 0;

        // Reset pulse
        #10 rst = 1;

        // Write 0xAA @ addr 1
  
        mem_wr = 1; wr_addr =11'h1; wr_data = 8'hAA;
        #10;
        mem_wr = 0;

        // Write 0x55 @ addr 2
        #10;
        mem_wr = 1; wr_addr = 11'h2; wr_data = 8'h55;
        #10;
        mem_wr = 0;

        // Read back addr 1
       #10;
        mem_rd = 1; rd_addr = 4'h1;
        @(posedge clk);
        #10;
        mem_rd = 0;

        // Read back addr 2
        @(negedge clk);
        mem_rd = 1; rd_addr = 4'h2;
        @(posedge clk);
        $display("Read Addr=2 -> Data=%h", rd_data);
        mem_rd = 0;

        // Read unwritten addr 3
        #10;
        mem_rd = 1; rd_addr = 4'h3;
        @(posedge clk);
        #10;
        mem_rd = 0;

        #20 $finish;
    end

endmodule

