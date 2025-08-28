// IE STAGE- TO EXECUTE SPECIAL APPLICATION UNIT - ENCRYTPION AND DECRYPTION

module cus19_cryptography_unit #(parameter key= 8'hA5)
(

input [7:0] data_in, // Data to be encrypted/decrypted from the data memory (From rs2_addr)

input start, //Control signal from CU
input mode_enc_dec,  //Mode control signal from CU

output reg [7:0] data_out // Ecrypted/Decrypted data to be stored in the data memory
);

wire [7:0] rotated_enc;
wire [7:0] rotated_dec;
wire [7:0] xor_dec;
//ENCRYPTION - TO ROTATE LEFT BY 3 BITS

assign rotated_enc = {data_in[4:0],data_in[7:5]};

//DECRYPTION - TO ROTATE RIGHT BY 3 BITS
assign xor_dec = data_in ^ key;
assign rotated_dec = {xor_dec[2:0],xor_dec[7:3]};

always@(*) begin

if(!start) begin
data_out =8'b0;
end

else begin
    if(mode_enc_dec) begin //ENCRYPTION
       data_out = rotated_enc ^ key ; //ROTATE & XOR to Ecrypt the data
    end else if(!mode_enc_dec) begin
       data_out = rotated_dec ; // XOR & Reverse Rotate to Decrypt the data
     end
end
end

endmodule





