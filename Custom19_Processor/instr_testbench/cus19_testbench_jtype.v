 `timescale 1ns/1ps

module cus19_testbench_jtype;


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


// JUMP IMM_ADDR - Jump to 5th address 

DUT.M2.mem[0] = 19'b000_00000000101_00_010; 

// Jump to this address and perform add ( rs2+rs3 = rs4) 
DUT.M2.mem[5] = 19'b0100_0010_0011_0000_000; 

// CALL IMM_ADDR - Call 10th address 
DUT.M2.mem[6] = 19'b000_00000001010_01_010; 
DUT.M2.mem[10] = 19'b0100_0011_0010_0001_000; //Subtract rs3-rs2 = rs4 

// RETURN - Return to 7th address as the previous address is 6th 
DUT.M2.mem[11] = 19'b000_00000000_10_010;


    // Initial Data

    DUT.M5.reg_file[2] = 8'd5;   // R2 = 5
    DUT.M5.reg_file[3] = 8'd10;  // R3 = 10  


    // Debug printing
    $display("IMEM[0] = %019b", DUT.M2.mem[0]);
    $display("IMEM[5] = %019b", DUT.M2.mem[5]);
    $display("IMEM[6] = %019b", DUT.M2.mem[6]);
    $display("IMEM[10] = %019b", DUT.M2.mem[10]);
    $display("IMEM[11] = %019b", DUT.M2.mem[11]);

    // Run simulation
    #400; // give enough cycles

    // Final results
    $display("Time=%0t : R2 = %0d (16-bit=%016b)", $time, DUT.M5.reg_file[2], {8'b0,DUT.M5.reg_file[2]});
    $display("Time=%0t : R3 = %0d (16-bit=%016b)", $time, DUT.M5.reg_file[3], {8'b0,DUT.M5.reg_file[3]});
    $display("Time=%0t : R4 (ADD/SUB results) = %0d (16-bit=%016b)", $time, DUT.M5.reg_file[4], {8'b0,DUT.M5.reg_file[4]});

    $finish;
  end

endmodule
