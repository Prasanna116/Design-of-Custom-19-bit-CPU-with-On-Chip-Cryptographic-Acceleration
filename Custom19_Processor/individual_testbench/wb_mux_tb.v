`timescale 1ns/1ps

module wb_mux_tb;

  // Inputs
  reg [15:0] alu_op_in;
  reg [15:0] ld_op_in;
  reg wb_mux_sel_out_sync2;

  // Output
  wire [15:0] final_operation_op;

  // Instantiate the DUT
  wb_mux dut (
    .alu_op_in(alu_op_in),
    .ld_op_in(ld_op_in),
    .wb_mux_sel_out_sync2(wb_mux_sel_out_sync2),
    .final_operation_op(final_operation_op)
  );

  initial begin
  
    // Test 1: Select ALU output
    alu_op_in = 16'hA5A5;
    ld_op_in  = 16'h5A5A;
    wb_mux_sel_out_sync2 = 1'b0;
    #10;
    

    // Test 2: Select LOAD output
    alu_op_in = 16'h1111;
    ld_op_in  = 16'h2222;
    wb_mux_sel_out_sync2 = 1'b1;
    #10;
 

    // Test 3: Default (unknown sel, check fallback)
    alu_op_in = 16'hAAAA;
    ld_op_in  = 16'hBBBB;
    wb_mux_sel_out_sync2 = 1'bx; // invalid select
    #10;
   
    $finish;
  end

endmodule

