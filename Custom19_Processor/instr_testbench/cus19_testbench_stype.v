 `timescale 1ns/1ps

module cus19_top_module_tb;


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


// S TYPE - ENC rs2,rs3
DUT.M2.mem[0] = 19'b0000000_0010_0011_1_100; 

// S TYPE - DEC rs4,rs5
DUT.M2.mem[1] = 19'b0000000_0100_0101_0_100;
 



    // Initial Data - Contains address of the data present in the data memory

    DUT.M5.reg_file[2] = 8'd2;   
    DUT.M5.reg_file[3] = 8'd3;  
    DUT.M5.reg_file[4] = 8'd4;  
    DUT.M5.reg_file[5] = 8'd5;


    DUT.M13.data_mem[3] = 8'b00001010;
    DUT.M13.data_mem[5] = 8'b00000101;

    // Run simulation
    #400; // give enough cycles

    // Final results for S-TYPE ENC / DEC

    $display("-------------------------------------------------");
    $display("Time=%0t : R2 (ENC src1) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[2], {8'b0,DUT.M5.reg_file[2]});
    $display("Time=%0t : R3 (ENC src2) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[3], {8'b0,DUT.M5.reg_file[3]});
    $display("Time=%0t : R4 (DEC src1) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[4], {8'b0,DUT.M5.reg_file[4]});
    $display("Time=%0t : R5 (DEC src2) = %0d (16-bit = %016b)", 
              $time, DUT.M5.reg_file[5], {8'b0,DUT.M5.reg_file[5]});
    $display("ALU Result Out = %016b", alu_result_out);
    $display("-------------------------------------------------");
end

endmodule
