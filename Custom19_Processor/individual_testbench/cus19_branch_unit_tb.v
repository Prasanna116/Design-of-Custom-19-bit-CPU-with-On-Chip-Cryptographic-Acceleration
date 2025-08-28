`timescale 1ns/1ps

module cus19_branch_unit_tb;

  parameter Data_Width = 8;

  // DUT inputs
  reg [Data_Width-1:0] op1_in;
  reg [Data_Width-1:0] op2_in;
  reg branch_en_in;
  reg [3:0] funct_in;

  // DUT output
  wire [2:0] pc_src_out;

  // DUT instantiation
  cus19_branch_unit #(.Data_Width(Data_Width)) dut (
    .op1_in(op1_in),
    .op2_in(op2_in),
    .branch_en_in(branch_en_in),
    .funct_in(funct_in),
    .pc_src_out(pc_src_out)
  );

  // Stimulus
  initial begin
    
    // Test 1: BER, equal case
    branch_en_in = 1;
    funct_in = 4'b0000;    // BER
    op1_in = 8'd10; 
    op2_in = 8'd10; 
    #10

    // Test 2: BER, not equal case
    op1_in = 8'd5; 
    op2_in = 8'd7; 
    #10;

    // Test 3: BNE, not equal case
    funct_in = 4'b0001;    // BNE
    op1_in = 8'd20; 
    op2_in = 8'd25; 
    #10;

    // Test 4: BNE, equal case
    op1_in = 8'd30; 
    op2_in = 8'd30; 
    #10;

    // Test 5: branch disabled
    branch_en_in = 0;
    op1_in = 8'd40; 
    op2_in = 8'd40; 
    #10;

    $finish;
  end

endmodule

