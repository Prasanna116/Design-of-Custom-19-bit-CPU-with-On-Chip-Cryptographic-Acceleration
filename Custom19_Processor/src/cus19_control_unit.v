module cus19_control_unit(  //ID STAGE- Generate control signals for different operations

input [2:0] opcode_in,
input [3:0] funct_in,

output reg alu_en_out, //To enable ALU block

// For both M type and S type
output reg mem_rd_out,
output reg mem_wr_out,

// For Write Back Stage
output reg reg_wr_out,
output reg wr_back_sel_out,

// FOR J and B TYPE
output reg [1:0] pc_src_out,
output reg branch_en_out,

// FOR SPECIAL APPLICATION TYPE
output reg start_in,
output reg mode_enc_dec_in


);


always@(*) begin 
//Default

alu_en_out=0;
mem_rd_out=0;
mem_wr_out=0;
reg_wr_out=0;
pc_src_out=2'b0;
branch_en_out=0;
start_in=0;

case(opcode_in)

// R TYPE INSTRUCTION
3'b000: begin
        alu_en_out=1;
        pc_src_out=3'b0;
        reg_wr_out=1; //Need to store the output to rd
        wr_back_sel_out= 1'b0;
        end

// M TYPE INSTRUCTION
3'b001: begin
        if(funct_in[0]) begin
        mem_rd_out=1;           // LOAD OP
        reg_wr_out=1;
        wr_back_sel_out= 1'b1;
        end else begin
        mem_wr_out=1;  
        reg_wr_out=0;         // STORE OP
        end
        end

// J TYPE
3'b010: begin
        reg_wr_out=0;
        case(funct_in[1:0]) 
        2'b00: pc_src_out= 2'b01; // JUMP OP
        2'b01: pc_src_out= 2'b10; // CALL OP
        2'b10: pc_src_out= 2'b11; // RETURN OP
        default: pc_src_out= 2'b00;
        endcase
        end

// B TYPE
3'b011: begin
        branch_en_out=1;
        reg_wr_out=0;
        end

// S TYPE
3'b100: begin
         mem_rd_out=1;
         mem_wr_out=1;
         reg_wr_out=0;
         start_in=1;
         if(funct_in[0]) begin
              mode_enc_dec_in=1; // Encryption
         end else begin
              mode_enc_dec_in=0; // Decryption
         end
        end

endcase
end

endmodule
     
        