`timescale 1ns/1ps

module cus19_control_unit_tb;

reg [2:0] opcode_in;
reg [3:0] funct_in;

wire alu_en_out; //To enable ALU block

// For both M type and S type
wire mem_rd_out;
wire mem_wr_out;

// For Write Back Stage
wire reg_wr_out;
wire wr_back_sel_out;

// FOR J and B TYPE
wire [2:0] pc_src_out;
wire branch_en_out;

// FOR SPECIAL APPLICATION TYPE
wire start_in;
wire mode_enc_dec_in;

cus19_control_unit dutt (opcode_in,funct_in,alu_en_out,mem_rd_out,mem_wr_out,reg_wr_out,wr_back_sel_out,
pc_src_out,branch_en_out,start_in,mode_enc_dec_in);

initial begin

$dumpfile("cus19_control_unit_tb.vcd");
$dumpvars(0,cus19_control_unit_tb);

opcode_in=0;
funct_in=0;

#10;

//R TYPE
opcode_in=3'b000;
funct_in=4'b0110; // Decrement

#10;
//M TYPE
opcode_in=3'b001;
funct_in=0; //STORE
#5;
funct_in=1; //LOAD

#10;
//J TYPE
opcode_in=3'b010;
funct_in=0; //JUMP
#2;
funct_in=1; //CALL
#2;
funct_in=2; //RETURN

#10;
//B TYPE
opcode_in=3'b011;
funct_in=0; //BEQ

#10;
//S TYPE
opcode_in=3'b100;
funct_in=1; //DEC

#10;
$finish;
end
endmodule
