`timescale 1ns/1ps

module cus19_testbench_alu;

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

    // ADD  R1 = R2 + R3   (10+20=30)
    DUT.M2.mem[0] = 19'b0100_0010_0011_0000_000;

    // SUB  R4 = R3 - R2   (20-10=10)
    DUT.M2.mem[1] = 19'b0101_0011_0010_0001_000;

    // MUL  R5 = R2 * R3   (10 * 20 = 200)
    DUT.M2.mem[2] = 19'b0110_0010_0011_0010_000;

   // DIV  R6 = R3 / R2   ( 20 / 10 =  2)
    DUT.M2.mem[3] = 19'b0111_0011_0010_0011_000;

    // INC R7 = R2 + 1  ( 10 + 1 = 11)
    DUT.M2.mem[4] = 19'b1000_0010_0000_0100_000;

    // DEC R8 = R2 -1   ( 10 - 1 = 9 )
    DUT.M2.mem[5] = 19'b1001_0010_0000_0101_000;

    // AND  R9 = R2 & R3   (10 & 20)
    DUT.M2.mem[6] = 19'b1010_0010_0011_0110_000;

    // OR   R10 = R2 | R3   (10 | 20)
    DUT.M2.mem[7] = 19'b1011_0010_0011_0111_000;

    // XOR  R7 = R2 ^ R3   (10 ^ 20)
    DUT.M2.mem[8] = 19'b1100_0010_0011_1000_000;




    // Load Register File values (source operands)
    DUT.M5.reg_file[2] = 8'd10;  
    DUT.M5.reg_file[3] = 8'd20;  


    // Run simulation (PC will fetch each instruction)

    #300;  // enough cycles to execute all instructions

    // Check results
    
    $display("Time=%0t : ADD  (R1 = R2 + R3)  -> R1=%0d",  $time, DUT.M5.reg_file[1]);
    $display("Time=%0t : SUB  (R4 = R3 - R2)  -> R4=%0d",  $time, DUT.M5.reg_file[4]);
    $display("Time=%0t : MUL  (R5 = R2 * R3)  -> R5=%0d",  $time, DUT.M5.reg_file[5]);
    $display("Time=%0t : DIV  (R6 = R3 / R2)  -> R6=%0d",  $time, DUT.M5.reg_file[6]);
    $display("Time=%0t : INC  (R7 = R2 + 1)   -> R7=%0d",  $time, DUT.M5.reg_file[7]);
    $display("Time=%0t : DEC  (R8 = R2 - 1)   -> R8=%0d",  $time, DUT.M5.reg_file[8]);
    $display("Time=%0t : AND  (R9 = R2 & R3)  -> R9=%0d",  $time, DUT.M5.reg_file[9]);
    $display("Time=%0t : OR   (R10= R2 | R3)  -> R10=%0d", $time, DUT.M5.reg_file[10]);
    $display("Time=%0t : XOR  (R11= R2 ^ R3)  -> R11=%0d", $time, DUT.M5.reg_file[11]);
    $finish;
  end

endmodule

