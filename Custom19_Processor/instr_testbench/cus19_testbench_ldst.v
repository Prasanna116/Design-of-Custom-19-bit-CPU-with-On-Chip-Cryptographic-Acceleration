`timescale 1ns/1ps

module cus19_testbench_ldst;

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

    // LOAD RS2 , IMM_ADDR
    DUT.M2.mem[0] = 19'b00000000010_0010_1_001;

    // STORE IMM_ADDR , RS4
    DUT.M2.mem[1] = 19'b00000000100_0100_0_001;

   
    DUT.M13.data_mem[2] = 8'd5;

    DUT.M5.reg_file[4] = 8'd10;  

    
    // Optional: print IMEM contents (first 2 entries)
    $display("IMEM[0] = %019b", DUT.M2.mem[0]);
    $display("IMEM[1] = %019b", DUT.M2.mem[1]);


    // Run simulation (allow a few cycles for IF/ID/EX/MEM/WB)
   
    #200;  // adjust if your pipeline needs more cycles

    // Check results (both decimal and 16-bit binary)

    $display("Time=%0t : After LD -> R1 (decimal)  = %0d", $time, DUT.M5.reg_file[2]);
    $display("Time=%0t : After LD -> R1 (16-bit)  = %016b", $time, {8'b0, DUT.M5.reg_file[2]});

    $display("Time=%0t : After ST -> DM[3] (decimal) = %0d", $time, DUT.M13.data_mem[4]);
    $display("Time=%0t : After ST -> DM[3] (16-bit) = %016b", $time, {8'b0, DUT.M13.data_mem[4]});

    $finish;
  end

endmodule

