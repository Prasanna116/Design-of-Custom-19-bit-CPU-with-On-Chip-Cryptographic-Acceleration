module cus19_decoder( // ID STAGE - Decode the 19bit instruction into the desired types and functions (Instruction MUX)

input [18:0] cus19_instr_in,

output reg  [2:0] opcode_out,
output reg  [3:0] funct_out,

output reg  [3:0] rs1_out,
output reg  [3:0] rs2_out,
output reg  [3:0] rd_out,

output reg  [10:0] imm_addr_out,

output reg [3:0] wb_addr_out
); // Sign-extended immediate address

wire [2:0] opcode; 

assign opcode = cus19_instr_in[2:0];

always@(*) begin

opcode_out = opcode;

rs1_out=0;
rs2_out=0;
rd_out=0;
funct_out=0;
imm_addr_out=0;
wb_addr_out=0;

case(opcode)

3'b000: begin                          //R TYPE -  Arithemetic,Logical
        funct_out=cus19_instr_in[6:3];
        rs2_out=cus19_instr_in[10:7];
        rs1_out=cus19_instr_in[14:11];
        rd_out=cus19_instr_in[18:15];

        wb_addr_out=rd_out; //Same as rd_out
        end

3'b001: begin                           // M TYPE - Load and Store
        funct_out={3'b0,cus19_instr_in[3]};
        rs1_out=cus19_instr_in[7:4];
        imm_addr_out=cus19_instr_in[18:8];//Data_address

         wb_addr_out=cus19_instr_in[7:4]; // Same as rs1_out
        end

3'b010: begin                            // J TYPE - CALL,RET,JMP
        funct_out={2'b0,cus19_instr_in[4:3]};
        imm_addr_out=cus19_instr_in[15:5]; //11 bit Immediate address
        // Unused instr_in[18:16]-3bit
        end

3'b011: begin                      // B TYPE - BER and BNE
        funct_out={3'b0,cus19_instr_in[3]};
        rs2_out=cus19_instr_in[7:4];
        rs1_out=cus19_instr_in[11:8];
        imm_addr_out = {{4{cus19_instr_in[18]}}, cus19_instr_in[18:12]}; // 11 bit Immediate address
        end    

3'b100: begin                       // S TYPE - SPECIAL APPLICATIONS
        funct_out={3'b0,cus19_instr_in[3]};
        rs2_out= cus19_instr_in[7:4];
        rs1_out= cus19_instr_in[11:8]; //Data Memory address - Will have to sign extend
        
   
        // Unused instr_in[18:12] - 7 bit
        end
endcase
end

endmodule


