module cus19_pc #(parameter PC_Width=11, parameter Stack_Depth=8) //IF STAGE
(
input clk_in,
input rst_in,

input [PC_Width-1:0] pc_in,   //Present PC Value after posedge of clk
input branch_out,              //From Branch Unit,  if branch is taken or not
input [1:0] pc_src_in,        //From decode stage, the type of operations is received
input [PC_Width-1:0] imm_add_in,     //From Imm adder or Decode stage, the immediate address is received

output reg [PC_Width-1:0] pc_mux_out);

// STACK for SP for CALL and RETURN OPERATION

reg [PC_Width-1:0] stack [0: Stack_Depth-1];
reg [2:0] sp;

always@(posedge clk_in or negedge rst_in) begin

if(!rst_in) begin

pc_mux_out<=0;
sp<=3'b111;

end else if(branch_out) begin
     pc_mux_out <= imm_add_in ; //BRANCH OP

end else begin

case(pc_src_in)

2'b00 : pc_mux_out <= pc_in + 1 ;  //Normal PC operation

2'b01 :  pc_mux_out <= imm_add_in ; //JUMP OP

2'b10 : begin //CALL OP
         stack[sp] <= pc_in + 1 ; //Load the return address into the stack
         sp <= sp-1;              // Shift to next SP
         pc_mux_out <= imm_add_in;
         end

2'b11: begin  //RET OP
        pc_mux_out<=stack[sp+1];
        sp<=sp+1;          //Move to the SP where the return address is stored
        end

default:  pc_mux_out <= pc_in + 1 ; 

endcase
end
end

endmodule
         
