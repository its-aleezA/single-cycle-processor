//top execution cycle module
module execute_cycle(
    input clk, rst, JumpE, RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    input [2:0] ALUControlE,
    input [31:0] RD1_E, RD2_E, Imm_Ext_E,
    input [4:0] RD_E,
    input [31:0] PCE, PCPlus4E, ResultW,
    input [1:0] ForwardA_E, ForwardB_E,
    output PCSrcE, RegWriteM, MemWriteM, ResultSrcM,
    output [4:0] RD_M,
    output [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCTargetE
);
    wire [31:0] Src_A, Src_B_interim, Src_B;
    wire [31:0] ResultE;
    wire ZeroE;
    wire AND_Out;
    
    reg RegWriteM, MemWriteM, ResultSrcM;
    reg [4:0] RD_M;
    reg [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    
    // Forwarding muxes
    Muxx forwardA_mux(
        .a(RD1_E),
        .b(ALU_ResultM),
        .c(ResultW),
        .s(ForwardA_E),
        .d(Src_A)
    );
    
    Muxx forwardB_mux(
        .a(RD2_E),
        .b(ALU_ResultM),
        .c(ResultW),
        .s(ForwardB_E),
        .d(Src_B_interim)
    );
    
    Muxx alu_src_mux(
        .a(Src_B_interim),
        .b(Imm_Ext_E),
        .s(ALUSrcE),
        .c(Src_B)
    );
    
    ALU alu(
        .A(Src_A),
        .B(Src_B),
        .Result(ResultE),
        .ALUControl(ALUControlE),
        .OverFlow(),
        .Carry(),
        .Zero(ZeroE),
        .Negative()
    );
    
    Adder branch_adder(
        .a(PCE),
        .b(Imm_Ext_E),
        .sum(PCTargetE)
    );
    
    AND an(
        .a(ZeroE),
        .b(BranchE),
        .c(AND_Out)
    );
    
    OR Or(
        .a(JumpE),
        .b(AND_Out),
        .c(PCSrcE)
    );
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            RegWriteM <= 1'b0;
            MemWriteM <= 1'b0;
            ResultSrcM <= 1'b0;
            RD_M <= 5'h00;
            PCPlus4M <= 32'h00000000;
            WriteDataM <= 32'h00000000;
            ALU_ResultM <= 32'h00000000;
        end else begin
            RegWriteM <= RegWriteE;
            MemWriteM <= MemWriteE;
            ResultSrcM <= ResultSrcE;
            RD_M <= RD_E;
            PCPlus4M <= PCPlus4E;
            WriteDataM <= Src_B_interim;
            ALU_ResultM <= ResultE;
        end
    end
endmodule
