`timescale 1ns/1ps

module cus19_store_unit_tb;

  // Testbench signals
  reg         mem_wr_in;
  reg  [10:0] imm_addr_in;
  reg  [7:0]  rs1_data_in;

  wire [10:0] dm_wr_addr_out;
  wire [7:0]  dm_wr_data_out;
  wire        dm_write_req;

  // DUT instantiation
  cus19_store_unit dut (
    .mem_wr_in(mem_wr_in),
    .imm_addr_in(imm_addr_in),
    .rs1_data_in(rs1_data_in),
    .dm_wr_addr_out(dm_wr_addr_out),
    .dm_wr_data_out(dm_wr_data_out),
    .dm_write_req(dm_write_req)
  );

  initial begin
    // Test 1: Store enabled
    mem_wr_in   = 1;
    imm_addr_in = 11'h1A3;
    rs1_data_in = 8'h5C;
    #10;
 
    // Test 2: Store disabled
    mem_wr_in   = 0;
    imm_addr_in = 11'h3F4;
    rs1_data_in = 8'hAA;
    #10;

    // Test 3: Store enabled with different values
    mem_wr_in   = 1;
    imm_addr_in = 11'h07F;
    rs1_data_in = 8'hFF;
    #10;
    $finish;
  end

endmodule

