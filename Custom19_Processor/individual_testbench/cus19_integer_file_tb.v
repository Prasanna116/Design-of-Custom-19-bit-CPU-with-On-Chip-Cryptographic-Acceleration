`timescale 1ns/1ps

module cus19_integer_file_tb;

  // Parameters
  localparam Data_Width = 8;
  localparam Reg_Addr_Width = 4;

  // Testbench signals
  reg clk_in;
  reg rst_in;

  reg  [Reg_Addr_Width-1:0] rs1_addr_in;
  reg  [Reg_Addr_Width-1:0] rs2_addr_in;

  reg  wr_en_in;
  reg  [Reg_Addr_Width-1:0] wr_addr_in;
  reg  [(2*Data_Width)-1:0] wr_data_in;

  wire [Data_Width-1:0] rs1_out;
  wire [Data_Width-1:0] rs2_out;

  // DUT
  cus19_integer_file #(
    .Data_Width(Data_Width),
    .Reg_Addr_Width(Reg_Addr_Width)
  ) dut (
    .clk_in(clk_in),
    .rst_in(rst_in),
    .rs1_addr_in(rs1_addr_in),
    .rs2_addr_in(rs2_addr_in),
    .wr_en_in(wr_en_in),
    .wr_addr_in(wr_addr_in),
    .wr_data_in(wr_data_in),
    .rs1_out(rs1_out),
    .rs2_out(rs2_out)
  );

  // Clock generation
  always #5 clk_in = ~clk_in;

  initial begin

    // Init
    clk_in = 0;
    rst_in = 0;
    wr_en_in = 0;
    rs1_addr_in = 0;
    rs2_addr_in = 0;
    wr_addr_in = 0;
    wr_data_in = 0;

    // Reset pulse
    #10; rst_in=1;
    // Test 1: Write single register
    wr_en_in   = 1;
    wr_addr_in = 4'd2;
    wr_data_in = 16'hABCD;  // reg[2] = 8'hCD, reg[3] = 8'hAB
    #10 wr_en_in = 0;
    
    // Read them back
    rs1_addr_in = 4'd2;
    rs2_addr_in = 4'd3;
    #10;

    // Test 2: Forwarding check (write & read same reg)
    wr_en_in   = 1;
    wr_addr_in = 4'd5;
    wr_data_in = 16'h1122;
    rs1_addr_in = 4'd5;  // Same as write address
    #10;

    wr_en_in = 0;
    #10;

    // Test 3: Another write + read
    wr_en_in   = 1;
    wr_addr_in = 4'd7;
    wr_data_in = 16'h55AA;
    #10 wr_en_in = 0;

    rs1_addr_in = 4'd7;
    rs2_addr_in = 4'd8;  // reg[8] should hold upper byte
    #10;

    $finish;
  end

endmodule

