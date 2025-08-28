`timescale 1ns/1ps

module cus19_alu_tb;

  // Parameters
  localparam Data_Width   = 8;
  localparam Result_Width = 2*Data_Width;

  // DUT signals
  reg  [Data_Width-1:0]  op1_in;
  reg  [Data_Width-1:0]  op2_in;
  reg  [3:0]             funct_op_in;
  reg                    alu_en_in;
  wire [Result_Width-1:0] result_out;

  // Instantiate DUT
  cus19_alu #(
    .Data_Width(Data_Width),
    .Result_Width(Result_Width)
  ) dut (
    .op1_in(op1_in),
    .op2_in(op2_in),
    .funct_op_in(funct_op_in),
    .alu_en_in(alu_en_in),
    .result_out(result_out)
  );

  // Task to run a test case
  task run_test;
    input [Data_Width-1:0] a, b;
    input [3:0] funct;
    begin
      op1_in = a;
      op2_in = b;
      funct_op_in = funct;
      alu_en_in = 1;
      #10; // wait for combinational settle
      $display("[%0t] op1=%0d, op2=%0d, funct=%b -> result=%0d (0x%h)",
                $time, op1_in, op2_in, funct_op_in, result_out, result_out);
    end
  endtask

  // Stimulus
  initial begin
    $display("---- Starting ALU Testbench ----");

    // ADD
    run_test(8'd15, 8'd10, 4'b0000); //ADD
    // SUB
    run_test(8'd20, 8'd5,  4'b0001); //SUB
    // MUL
    run_test(8'd12, 8'd3,  4'b0010); //MUL
    // DIV
    run_test(8'd22, 8'd5,  4'b0011); //DIV
    // INC
    run_test(8'd7,  8'd0,  4'b0100);  //INC
    // DEC
    run_test(8'd9,  8'd0,  4'b0101);  //DEC
    // AND
    run_test(8'hF0, 8'h0F, 4'b0110);  //AND
    // OR
    run_test(8'hAA, 8'h55, 4'b0111);  //OR
    // XOR
    run_test(8'h0F, 8'hF0, 4'b1000);  //XOR
    // NOT
    run_test(8'h55, 8'd0,  4'b1001);  //NOT

    // ALU disable case
    alu_en_in = 0;
    op1_in = 8'd50; op2_in = 8'd25; funct_op_in = 4'b0000;
    #10;
    $display("[%0t] ALU disabled -> result=%0d (0x%h)", $time, result_out, result_out);

    $display("---- ALU Testbench Completed ----");
    $finish;
  end

endmodule

