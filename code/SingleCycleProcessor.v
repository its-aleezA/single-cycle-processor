//top processor module
module SingleCycleProcessor(
    input clk,
    input rst
);
    // Fetch stage signals
    wire [31:0] pc_mux_in;
    wire pc_select;
    wire [31:0] instr_out, pc_plus_4_out;
    
    // Decode stage signals
    wire RegWriteW;
    wire [4:0] RDW;
    wire [31:0] ResultW;
    wire RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    wire [2:0] ALUControlE;
    wire [31:0] RD1_E, RD2_E, Imm_Ext_E;
    wire [4:0] RD_E, RS1_E, RS2_E;
    wire [31:0] PCE, PCPlus4E;
    
    // Execute stage signals
    wire JumpE = 1'b0; // Not implemented in this version
    wire [1:0] ForwardA_E = 2'b00, ForwardB_E = 2'b00; // No forwarding in single cycle
    wire PCSrcE;
    wire RegWriteM, MemWriteM, ResultSrcM;
    wire [4:0] RD_M;
    wire [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE;
    
    // Memory stage signals
    wire RegWriteW_out, ResultSrcW_out;
    wire [4:0] RD_W_out;
    wire [31:0] PCPlus4W_out, ALU_ResultW_out, ReadDataW_out;
    
    // Fetch stage
    FetchStage fetch(
        .clk(clk),
        .rst(rst),
        .pc_mux_in(PCTargetE),
        .pc_select(PCSrcE),
        .instr_out(instr_out),
        .pc_plus_4_out(pc_plus_4_out)
    );
    
    // Decode stage
    decode_cycle decode(
        .clk(clk),
        .rst(rst),
        .InstrD(instr_out),
        .PCD(32'b0), // Not used in single cycle
        .PCPlus4D(pc_plus_4_out),
        .RegWriteW(RegWriteW_out),
        .RDW(RD_W_out),
        .ResultW(ResultW),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .RS1_E(RS1_E),
        .RS2_E(RS2_E)
    );
    
    // Execute stage
    execute_cycle execute(
        .clk(clk),
        .rst(rst),
        .JumpE(JumpE),
        .RegWriteE(RegWriteE),
        .ALUSrcE(ALUSrcE),
        .MemWriteE(MemWriteE),
        .ResultSrcE(ResultSrcE),
        .BranchE(BranchE),
        .ALUControlE(ALUControlE),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .Imm_Ext_E(Imm_Ext_E),
        .RD_E(RD_E),
        .PCE(PCE),
        .PCPlus4E(PCPlus4E),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .ResultW(ResultW),
        .ForwardA_E(ForwardA_E),
        .ForwardB_E(ForwardB_E)
    );
    
    // Memory stage
    memory_cycle memory(
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .MemWriteM(MemWriteM),
        .ResultSrcM(ResultSrcM),
        .RD_M(RD_M),
        .PCPlus4M(PCPlus4M),
        .WriteDataM(WriteDataM),
        .ALU_ResultM(ALU_ResultM),
        .RegWriteW(RegWriteW_out),
        .ResultSrcW(ResultSrcW_out),
        .RD_W(RD_W_out),
        .PCPlus4W(PCPlus4W_out),
        .ALU_ResultW(ALU_ResultW_out),
        .ReadDataW(ReadDataW_out)
    );
    
    // Writeback stage
    writeback_cycle writeback(
        .clk(clk),
        .rst(rst),
        .ResultSrcW(ResultSrcW_out),
        .PCPlus4W(PCPlus4W_out),
        .ALU_ResultW(ALU_ResultW_out),
        .ReadDataW(ReadDataW_out),
        .ResultW(ResultW)
    );
endmodule
