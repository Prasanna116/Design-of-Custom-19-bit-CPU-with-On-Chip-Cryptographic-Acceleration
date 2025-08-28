`timescale 1ns/1ps

module cus19_load_unit_tb;

  // Testbench signals
  reg  [7:0]  dm_rd_data_in;
  reg         reg_wr_in;
  wire [15:0] ld_data_out;

  // DUT instantiation
  cus19_load_unit dut (
    .dm_rd_data_in(dm_rd_data_in),
    .reg_wr_in(reg_wr_in),
    .ld_data_out(ld_data_out)
  );

  initial begin

    // Test 1: reg_wr_in = 1, valid data
    dm_rd_data_in = 8'hA5;  // 1010_0101
    reg_wr_in     = 1;
    #10;

    // Test 2: reg_wr_in = 0, should output 0
    reg_wr_in = 0;
    #10;

    // Test 3: reg_wr_in = 1, new data
    dm_rd_data_in = 8'h3C;
    reg_wr_in     = 1;
    #10;

    // Test 4: reg_wr_in = 0 again
    reg_wr_in = 0;
    #10;
    $finish;
  end

endmodule

