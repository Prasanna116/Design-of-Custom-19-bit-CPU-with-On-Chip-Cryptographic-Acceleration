 `timescale 1ns/1ps

module cus19_top_module_tb;


  // Parameters
  parameter PC_Width       = 11;
  parameter Instr_Width    = 19;
  parameter Data_Width     = 8;
  parameter Reg_Addr_Width = 4;
  parameter key=8'hA5;

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
    .Reg_Addr_Width(Reg_Addr_Width),
    .key(key)
  ) DUT (
    .cus19_clk_in(clk_in),
    .cus19_rst_in(rst_in),
    .alu_result_out(alu_result_out),
    .ld_result_out(ld_result_out)
  );


  // Clock Generation
  always #5 clk_in = ~clk_in;  // 100MHz clock


  // Stimulus

initial begin
    // Initialize
    clk_in = 0;
    rst_in = 0;
    #20;
    rst_in = 1;


    // Program Instructions in Instruction Memory

// R TYPE - MULT & XOR

// MUL  R4 = R2 * R3   (5 * 10 = 50)
    DUT.M2.mem[0] = 19'b0100_0010_0011_0010_000;

// XOR  R6 = R2 ^ R3   (5 ^ 10 = 0F)
    DUT.M2.mem[1] = 19'b0110_0010_0011_1000_000;

// M TYPE - LD & ST

// LD R8,IMM_ADDR[0]
    DUT.M2.mem[2] = 19'b00000000000_1000_1_001;

// ST IMM_ADDR[1],R3
    DUT.M2.mem[3] = 19'b00000000001_0011_0_001;

// J TYPE - JUMP, CALL & RETURN

//JUMP IMM_ADDR[7]
    DUT.M2.mem[4] = 19'b000_00000000111_00_010;

// CALL IMM_ADDR[10]
    DUT.M2.mem[7] = 19'b000_00000001010_01_010;

// RET - Return to 8
    DUT.M2.mem[10] = 19'b000_00000000000_10_010;

// B TYPE - BER & BNE

// BER R10,R11,IMM_ADDR[12]
    DUT.M2.mem[9] = 19'b0001100_1010_1011_0_011;

// BNE R11,R12,IMM_ADDR[15]
    DUT.M2.mem[12] = 19'b0001111_1011_1100_1_011;

// S TYPE ENC & DEC

// ENC R2,R3
    DUT.M2.mem[15] = 19'b0000000_0010_0011_0_100;

// DEC R14,R12
    DUT.M2.mem[16] = 19'b0000000_1110_1100_1_100;

 
// Initial Data stored in the Registers

    DUT.M5.reg_file[2] = 8'd5;   
    DUT.M5.reg_file[3] = 8'd10;  
    DUT.M5.reg_file[10] = 8'd15;  
    DUT.M5.reg_file[11] = 8'd15;
    DUT.M5.reg_file[12] = 8'd13;

// Data stored in the Data Memory

    DUT.M13.data_mem[0] = 8'b00001111; //R8 will get 15;
    DUT.M13.data_mem[10] = 8'b00001101; //ENCRYPT THIS AND STORE IN MEM[5]
    DUT.M13.data_mem[13] = 8'b00111100; //DECRYPT THIS AND STORE IN MEM[15]

    // Run simulation
    #400; // give enough cycles

end
endmodule
