`timescale 1ns/1ps

module cus19_testbench_btype;


  // Parameters
  parameter PC_Width       = 11;
  parameter Instr_Width    = 19;
  parameter Data_Width     = 8;
  parameter Reg_Addr_Width = 4;


  // DUT Inputs
  reg clk_in;
  reg rst_in;


  // DUT Outputs (add only the ones exposed in top module)
  wire [(2*Data_Width)-1:0] alu_result_out;   
  wire [(2*Data_Width-1):0] ld_result_out;


  // DUT Instantiation
  cus19_top_module #(
    .PC_Width(PC_Width),
    .Stack_Depth(Data_Width),
    .Instr_Width(Instr_Width),
    .Data_Width(Data_Width),
    .Reg_Addr_Width(Reg_Addr_Width)
  ) DUT (
    .cus19_clk_in(clk_in),
    .cus19_rst_in(rst_in),
    .alu_result_out(alu_result_out),
    .ld_result_out(ld_result_out)
  );

 
  always #5 clk_in = ~clk_in;  // 100MHz clock

initial begin
    // Initialize
    clk_in = 0;
    rst_in = 0;
    #20;
    rst_in = 1;

    // Program Instructions in Instruction Memory
   
// Branch BER RS2, RS3
DUT.M2.mem[0] = 19'b0000101_0010_0011_0_011; 

// ALU - MULT RS3 * RS4 = RS10
DUT.M2.mem[5] = 19'b1010_0011_0100_0010_000; 

//Branch BNE RS3,RS4
DUT.M2.mem[6] = 19'b0001010_0011_0100_1_011;

// ALU - DIV RS4/RS3 = RS13 
DUT.M2.mem[10] = 19'b1101_0100_0011_0011_000; 



    // Initial Data
    DUT.M5.reg_file[2] = 8'd5;   // R2 = 10
    DUT.M5.reg_file[3] = 8'd5;  // R3 = 10
    DUT.M5.reg_file[4] = 8'd10;  // R3 = 10
 
    // Run simulation
    #400; // give enough cycles


    // Final results

    $display("-------------------------------------------------");
    $display("Time=%0t : R2 = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[2], {8'b0,DUT.M5.reg_file[2]});
    $display("Time=%0t : R3 = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[3], {8'b0,DUT.M5.reg_file[3]});
    $display("Time=%0t : R4 = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[4], {8'b0,DUT.M5.reg_file[4]});
    $display("Time=%0t : R10 (MUL result) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[10], {8'b0,DUT.M5.reg_file[10]});
    $display("Time=%0t : R13 (DIV result) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[13], {8'b0,DUT.M5.reg_file[13]});
    $display("ALU Result Out = %016b", alu_result_out);
    $display("-------------------------------------------------");

    $finish;
  end

endmodule
