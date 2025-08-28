`timescale 1ns/1ps

module cus19_instr_memory_tb;

  parameter PC_Width = 11;
  parameter Instr_Width = 19;

  reg clk, rst;
  reg [PC_Width-1:0] pc_in;
  wire [Instr_Width-1:0] instr_out;


  cus19_instr_memory #(PC_Width, Instr_Width) dut (clk,rst,pc_in,instr_out);

  always #5 clk = ~clk;

  initial begin
    // waveform dump (for Icarus or EDA Playground)
    $dumpfile("cus19_instr_memory_tb.vcd");
    $dumpvars(0, cus19_instr_memory_tb);

    // Initialize signals
    clk = 0;
    rst = 0;
    pc_in = 0;

    // Preload instruction memory
    dut.mem[0] = 19'b000_0000_0000_0000_001;  // example opcode
    dut.mem[1] = 19'b001_0000_0000_0000_010;
    dut.mem[2] = 19'b010_0000_0000_0000_011;
    dut.mem[3] = 19'b011_0000_0000_0000_100;

    // Release reset
    #12 rst = 1;

    // Test a sequence of addresses
    #10 pc_in = 0;
    #10 pc_in = 1;
    #10 pc_in = 2;
    #10 pc_in = 3;
    #10 pc_in = 4; // empty (default X or 0)

    // Finish
    #20 $finish;
  end

endmodule

