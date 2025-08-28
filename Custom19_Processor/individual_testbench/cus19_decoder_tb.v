`timescale 1ns/1ps

module cus19_decoder_tb;

reg [18:0] instr_in;

wire [2:0] opcode_out;
wire [3:0] funct_out;

wire [3:0] rs1_out;
wire [3:0] rs2_out;
wire [3:0] rd_out;

wire [10:0] imm_addr_out;

wire [3:0] wb_addr_out;

cus19_decoder dutt(instr_in,opcode_out,funct_out,rs1_out,rs2_out,rd_out,imm_addr_out,wb_addr_out);

initial begin

$dumpfile("cus19_decoder_tb.vcd");
$dumpvars(0,cus19_decoder_tb);

    // R-type 
    // opcode=000, funct=1010, rs2=0011, rs1=0100, rd=1111
    instr_in=19'b1111_0100_0011_1010_000;
    #10;
    // M-type 
    // opcode=001, funct=1, rs1=0101, imm=0x155
    instr_in=19'b10101010101_0101_1_001;
    #10;
    // J-type
    // opcode=010, funct=10, imm=0x2AA
    instr_in=19'b000_10101010101_10_010;
    #10;
    // B-type 
    // opcode=011, funct=1, rs2=0110, rs1=1010, imm=7
    instr_in=19'b0000111_1010_0110_1_011;
    #10;
    // S-type 
    // opcode=100, funct=1, rs2=0010, rs1=1100
    instr_in=19'b0000000_1100_0010_1_100;

    #10 $finish;
  end

endmodule
