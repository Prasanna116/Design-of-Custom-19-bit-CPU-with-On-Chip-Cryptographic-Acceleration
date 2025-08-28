// TOP MODULE

module cus19_top_module #(parameter PC_Width=11, parameter Stack_Depth=8, parameter Instr_Width=19,
parameter Data_Width=8, parameter Reg_Addr_Width=4, parameter key=8'hA5)
(
input cus19_clk_in,
input cus19_rst_in,

output [(2*Data_Width)-1:0] alu_result_out,
output [(2*Data_Width)-1:0] ld_result_out);

wire [PC_Width-1:0] pc_in;
wire [PC_Width-1:0] pc_mux_out;

wire [Instr_Width-1:0] cus19_instr; //Instruction from IM

wire [2:0] opcode_out;
wire [3:0] funct_out;
wire [3:0] rs1_out;
wire [3:0] rs2_out;
wire [3:0] rd_out;
wire [PC_Width-1:0] imm_addr_out;
wire [3:0] wb_addr_out;

wire alu_en_out;
wire mem_rd_out;
wire mem_wr_out;
wire reg_wr_out;
wire wr_back_sel_out;
wire [1:0] pc_src_out;
wire branch_en_out;
wire start_out;
wire mode_enc_dec_out;

wire [Data_Width-1:0] rs1_data_out;
wire [Data_Width-1:0] rs2_data_out;

wire branch_out;

wire [2:0] opcode_in;
wire [3:0] funct_in;
wire [PC_Width-1:0] imm_addr_in; 
wire [3:0] wb_addr_in; 

wire alu_en_in;  
wire mem_rd_in;
wire mem_wr_in;  
wire reg_wr_in; 
wire start_in;       
wire mode_enc_dec_in;
wire wr_back_sel_in; 

wire [7:0] rs1_data_in;
wire [7:0] rs2_data_in;

wire [10:0] dm_wr_addr_out; // Address to Data Memory
wire [7:0]  dm_wr_data_out; // Data to Data Memory
wire dm_write_req;    // Write request signal

wire [Data_Width-1:0] crypt_data_out; // Ecrypted/Decrypted data to be stored in the data memory


wire mem_rd_req;
wire [PC_Width-1:0] mem_rd_addr;

wire mem_wr_req;
wire [PC_Width-1:0] wr_addr_in; 
wire [Data_Width-1:0] wr_data_in; 
wire [Data_Width-1:0] dm_rd_data_out;

wire [(2*Data_Width)-1:0]  alu_result_out_sync;
wire [(2*Data_Width)-1:0]  ld_result_out_sync;
wire [3:0] wb_addr_out_sync;
wire wr_back_sel_out_sync;
wire reg_wr_out_sync;


wire [(2*Data_Width)-1:0] final_operation_op;


assign pc_in = pc_mux_out; //For the next cycle

  // INSTRUCTION FETCH STAGE - PIPELINE STAGE 1-2

  cus19_pc #(PC_Width,Stack_Depth) M1(
            .clk_in(cus19_clk_in),
            .rst_in(cus19_rst_in),
            .pc_in(pc_in),
            .branch_out(branch_out),
            .pc_src_in(pc_src_out),
            .imm_add_in(imm_addr_out),
            .pc_mux_out(pc_mux_out));

  cus19_instr_memory #(PC_Width,Instr_Width) M2 (
             .clk_in(cus19_clk_in),
             .rst_in(cus19_rst_in),
             .instr_mem_in(pc_mux_out),
             .cus19_instr(cus19_instr)); //Instruction out
  
   // INSTRUCTION DECODE STAGE

  cus19_decoder M3 (
              .cus19_instr_in(cus19_instr),
              .opcode_out(opcode_out),
              .funct_out(funct_out),
              .rs1_out(rs1_out),
              .rs2_out(rs2_out),
              .rd_out(rd_out),
              .imm_addr_out(imm_addr_out),
              .wb_addr_out(wb_addr_out));

  cus19_control_unit M4 (
              .opcode_in(opcode_out),
              .funct_in(funct_out),
              .alu_en_out(alu_en_out),
              .mem_rd_out(mem_rd_out),
              .mem_wr_out(mem_wr_out),
              .reg_wr_out(reg_wr_out),
              .wr_back_sel_out(wr_back_sel_out),
              .pc_src_out(pc_src_out),
              .branch_en_out(branch_en_out),
              .start_in(start_out),
              .mode_enc_dec_in(mode_enc_dec_out));

  
   cus19_integer_file #(Data_Width,Reg_Addr_Width) M5 (
                 .clk_in(cus19_clk_in),
                 .rst_in(cus19_rst_in),
                 .rs1_addr_in(rs1_out),
                 .rs2_addr_in(rs2_out),
                 .wr_en_in(reg_wr_out_sync),
                 .wr_addr_in(wb_addr_out_sync),
                 .wr_data_in(final_operation_op),
                 .rs1_out(rs1_data_out),
                 .rs2_out(rs2_data_out));

   cus19_branch_unit M6 (
               .op1_in(rs1_data_out),
               .op2_in(rs2_data_out),
               .branch_en_in(branch_en_out),
               .funct_in(funct_out),
               .branch_out(branch_out) );


// PIPELINE STAGE 2-3


   regblock_id_to_ie M7 (
            .clk_in(cus19_clk_in),
            .rst_in(cus19_rst_in),
            .opcode_out(opcode_out),
            .funct_out(funct_out),
            .imm_addr_out(imm_addr_out),
            .wb_addr_out(wb_addr_out),
            .alu_en_out(alu_en_out),
            .mem_rd_out(mem_rd_out),
            .mem_wr_out(mem_wr_out),
            .reg_wr_out(reg_wr_out),
            .start(start_out),
            .mode_enc_dec_out(mode_enc_dec_out),
            .wr_back_sel_out(wr_back_sel_out),
            .rs1_out(rs1_data_out),
            .rs2_out(rs2_data_out),
              
            .opcode_in(opcode_in),
            .funct_in(funct_in),
            .imm_addr_in(imm_addr_in),
            .wb_addr_in(wb_addr_in),
            .alu_en_in(alu_en_in),
            .mem_rd_in(mem_rd_in),
            .mem_wr_in(mem_wr_in),
            .reg_wr_in(reg_wr_in),
            .start_in(start_in),
            .mode_enc_dec_in(mode_enc_dec_in),
            .wr_back_sel_in(wr_back_sel_in),
            .rs1_in(rs1_data_in),
            .rs2_in(rs2_data_in) );

// INSTRUCTION EXECUTE STAGE

     cus19_alu #(Data_Width,(2*Data_Width)) M8 (
                .op1_in(rs1_data_in),
                .op2_in(rs2_data_in),
                .funct_op_in(funct_in),
                .alu_en_in(alu_en_in),
                .result_out(alu_result_out) );
 

     cus19_load_unit M9 (
              .dm_rd_data_in(dm_rd_data_out), //FROM DM
              .reg_wr_in(reg_wr_in),
              .ld_data_out(ld_result_out));


     cus19_store_unit M10 (
           .mem_wr_in(mem_wr_in),
           .imm_addr_in(imm_addr_in),
           .rs1_data_in(rs1_data_in),
           .dm_wr_addr_out(dm_wr_addr_out),
           .dm_wr_data_out(dm_wr_data_out),
           .dm_write_req(dm_write_req) );


     cus19_cryptography_unit M11 (
                .data_in(dm_rd_data_out), //FROM DM
                .start(start_in),
                .mode_enc_dec(mode_enc_dec_in),
                .data_out(crypt_data_out) ); 


     cus19_dm_rd_mux M12 (
                  .rs2_data_in(rs2_data_in),
                  .imm_addr_in(imm_addr_in),
                  .opcode_in(opcode_in),
                  .mem_rd_in(mem_rd_in),
                  
                  .mem_rd_req(mem_rd_req),
                  .mem_rd_addr(mem_rd_addr) );
    

// DATA MEMORY STAGE - PIPELINE STAGE 3-4

assign wr_addr_in = (opcode_in==3'b001) ? dm_wr_addr_out : (opcode_in==3'b100) ? {3'b000, rs1_data_out} : 11'b0;
assign mem_wr_req = (opcode_in==3'b001) ? dm_write_req   : (opcode_in==3'b100) ? mem_wr_in : 0 ;
assign wr_data_in = (opcode_in==3'b001) ? dm_wr_data_out   : (opcode_in==3'b100) ? crypt_data_out : 0 ;

     cus19_data_memory #(PC_Width,Data_Width) M13 (
                   .clk_in(cus19_clk_in),
                   .rst_in(cus19_rst_in),
                   .mem_rd_in(mem_rd_req),
                   .rd_addr_in(mem_rd_addr),
                   .mem_wr_in(mem_wr_req),
                   .wr_addr_in(wr_addr_in),
                   .wr_data_in(wr_data_in),
                  
                   .rd_data_out(dm_rd_data_out) );


// WRITE BACK STAGE - PIPELINE STAGE 4-5

     regblock_ie_to_wb M14 (
              .clk_in(cus19_clk_in),
              .rst_in(cus19_rst_in),
              .alu_result_in(alu_result_out),
              .ld_data_in(ld_result_out),
              .wb_addr_in(wb_addr_in),
              .wr_back_sel_in(wr_back_sel_in),
              .reg_wr_in(reg_wr_in),
              
              .alu_result_out(alu_result_out_sync),
              .ld_data_out(ld_result_out_sync),
              .wb_addr_out(wb_addr_out_sync),
              .wr_back_sel_out(wr_back_sel_out_sync),
              .reg_wr_out(reg_wr_out_sync) );

      wb_mux M15 (
         .alu_op_in(alu_result_out_sync),
         .ld_op_in(ld_result_out_sync),
         .wr_mux_sel_out_sync(wr_back_sel_out_sync),
         .final_operation_op(final_operation_op) );

endmodule
       
        


   