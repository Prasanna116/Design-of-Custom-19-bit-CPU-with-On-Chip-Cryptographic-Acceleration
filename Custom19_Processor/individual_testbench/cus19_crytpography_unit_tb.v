`timescale 1ns/1ps

module cus19_cryptography_unit_tb;

  // Inputs
  reg  [7:0] data_in;
  reg        start;
  reg        mode_enc_dec;

  // Output
  wire [7:0] data_out;

  // DUT instantiation
  cus19_cryptography_unit #(8'hA5) dut (
    .data_in(data_in),
    .start(start),
    .mode_enc_dec(mode_enc_dec),
    .data_out(data_out)
  );

  // Stimulus
  initial begin
    
    // Case 0: start=0 ? output should be 0
    data_in = 8'h3C; start = 0; mode_enc_dec = 1;
    #10;
    // Case 1: Encryption mode
    start = 1; mode_enc_dec = 1; data_in = 8'h3C;  // Example input
    #10;
    // Case 2: Another Encryption input
    data_in = 8'hF0; mode_enc_dec = 1;
    #10;
    // Case 3: Decryption mode (check if reverses encryption)
    mode_enc_dec = 0; data_in = data_out;  // Feed encrypted result back
    #10;
    // Case 4: Decryption of another value
    data_in = 8'h7E; mode_enc_dec = 0;
    #10;
    // Finish simulation
    #20 $finish;
  end

endmodule

