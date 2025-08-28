// IE STAGE ALU UNIT
module cus19_alu  
#(
  parameter Data_Width = 8,             // Operand width
  parameter Result_Width = 2*Data_Width // Result width = 16 bits
)(
  input  [Data_Width-1:0] op1_in,       // Operand 1
  input  [Data_Width-1:0] op2_in,       // Operand 2
  input  [3:0] funct_op_in,             // Function select
  input  alu_en_in,                     // ALU enable

  output reg [Result_Width-1:0] result_out // Result
);

  localparam 
    ALU_ADD = 4'b0000,
    ALU_SUB = 4'b0001,
    ALU_MUL = 4'b0010,
    ALU_DIV = 4'b0011,
    ALU_INC = 4'b0100,
    ALU_DEC = 4'b0101,
    ALU_AND = 4'b0110,
    ALU_OR  = 4'b0111,
    ALU_XOR = 4'b1000,
    ALU_NOT = 4'b1001;

always @(*) begin
  if (alu_en_in) begin
    case (funct_op_in)
      ALU_ADD: result_out = {{Data_Width{1'b0}}, (op1_in + op2_in)};   // ADD rd,r1,r2
      ALU_SUB: result_out = {{Data_Width{1'b0}}, (op1_in - op2_in)};   // SUB rd,r1,r2
      ALU_MUL: result_out = op1_in * op2_in;                           // MUL rd,r1,r2 (16b)
      ALU_DIV: result_out = { (op1_in % op2_in), (op1_in / op2_in) };  // DIV rd,r1,r2 {rem,quot}
      ALU_INC: result_out = {{Data_Width{1'b0}}, (op1_in + 1)};        // INC r1
      ALU_DEC: result_out = {{Data_Width{1'b0}}, (op1_in - 1)};        // DEC r1
      ALU_AND: result_out = {{Data_Width{1'b0}}, (op1_in & op2_in)};   // AND rd,r1,r2
      ALU_OR : result_out = {{Data_Width{1'b0}}, (op1_in | op2_in)};   // OR rd,r1,r2
      ALU_XOR: result_out = {{Data_Width{1'b0}}, (op1_in ^ op2_in)};   // XOR rd,r1,r2
      ALU_NOT: result_out = {{Data_Width{1'b0}}, (~op1_in)};           // NOT r1
      default: result_out = {Result_Width{1'b0}};                      // Default
    endcase
  end else begin
    result_out = {Result_Width{1'b0}};
  end
end

endmodule

