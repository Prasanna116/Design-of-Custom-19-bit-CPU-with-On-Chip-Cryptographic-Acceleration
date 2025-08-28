module cus19_branch_unit #(parameter Data_Width=8) // IE STAGE- Branch operation - BER and BNE
(
input [Data_Width-1:0] op1_in,
input [Data_Width-1:0] op2_in,
input branch_en_in,
input [3:0] funct_in,


output reg branch_out);

always@(*) begin
if(branch_en_in) begin
    if(funct_in[0]==0) begin                             // BER OP
       branch_out = (op1_in==op2_in) ? 1'b1: 1'b0;
    end else begin                                       //BNE OP
       branch_out = (op1_in!=op2_in) ? 1'b1: 1'b0;
       end
end else begin
  branch_out=1'b0;
end

end

endmodule
