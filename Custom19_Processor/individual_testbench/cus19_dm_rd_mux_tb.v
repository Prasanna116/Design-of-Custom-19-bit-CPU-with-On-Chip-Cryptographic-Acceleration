`timescale 1ns/1ps

module cus19_dm_rd_mux_tb;

  // Parameters
  reg  [7:0]  rs2_data_in;
  reg  [10:0] imm_addr_in;
  reg  [2:0]  opcode_in;
  reg         mem_rd_in;

  wire        mem_rd_req;
  wire [10:0] mem_rd_addr;

  // DUT instantiation
  cus19_dm_rd_mux dut (
    .rs2_data_in(rs2_data_in),
    .imm_addr_in(imm_addr_in),
    .opcode_in(opcode_in),
    .mem_rd_in(mem_rd_in),
    .mem_rd_req(mem_rd_req),
    .mem_rd_addr(mem_rd_addr)
  );

  // Stimulus
  initial begin
    $display("Time\tmem_rd_in opcode rs2_data imm_addr -> mem_rd_req mem_rd_addr");

    // Case 0: No read
    mem_rd_in = 0; rs2_data_in = 8'hAA; imm_addr_in = 11'd50; opcode_in = 3'b001;
    #10 

    // Case 1: LOAD (opcode=001), should use imm_addr_in
    mem_rd_in = 1; opcode_in = 3'b001; imm_addr_in = 11'd45;
    #10 

    // Case 2: SP (opcode=100), should use rs2_data_in extended
    mem_rd_in = 1; opcode_in = 3'b100; rs2_data_in = 8'd25;
    #10 

    // Case 3: Different SP value
    rs2_data_in = 8'd200; opcode_in = 3'b100;
    #10     // Finish

    #20 $finish;
  end

endmodule

