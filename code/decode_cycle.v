//top decode cycle module
module decode_cycle(clk, rst, InstrD, PCD, PCPlus4D, RegWriteW, RDW, ResultW, 
                   RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, ALUControlE, 
                   RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, RS1_E, RS2_E);
    input clk, rst, RegWriteW;
    input [31:0] InstrD, PCD, PCPlus4D, ResultW;
    input [4:0] RDW;
    
    output RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    output [2:0] ALUControlE;
    output [31:0] RD1_E, RD2_E, Imm_Ext_E;
    output [4:0] RS1_E, RS2_E, RD_E;
    output [31:0] PCE, PCPlus4E;

    wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
    wire [1:0] ImmSrcD;
    wire [2:0] ALUControlD;
    wire [31:0] RD1_D, RD2_D, Imm_Ext_D;

    reg RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE;
    reg [2:0] ALUControlE;
    reg [31:0] RD1_E, RD2_E, Imm_Ext_E;
    reg [4:0] RD_E, RS1_E, RS2_E;
    reg [31:0] PCE, PCPlus4E;

    Control_Unit_top control (
        .op(InstrD[6:0]),
        .regWrite(RegWriteD),
        .immSrc(ImmSrcD),
        .aluSrc(ALUSrcD),
        .memWrite(MemWriteD),
        .resultSrc(ResultSrcD),
        .branch(BranchD),
        .funct3(InstrD[14:12]),
        .funct7(InstrD[31:25]),
        .aluControl(ALUControlD)
    );

    Register_File rf (
        .clk(clk),
        .rst(rst),
        .WE3(RegWriteW),
        .WD3(ResultW),
        .A1(InstrD[19:15]),
        .A2(InstrD[24:20]),
        .A3(RDW),
        .RD1(RD1_D),
        .RD2(RD2_D)
    );

    Sign_Extend extension (
        .In(InstrD),
        .ImmSrc(ImmSrcD),
        .Imm_Ext(Imm_Ext_D)
    );

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            RegWriteE <= 1'b0;
            ALUSrcE <= 1'b0;
            MemWriteE <= 1'b0;
            ResultSrcE <= 1'b0;
            BranchE <= 1'b0;
            ALUControlE <= 3'b000;
            RD1_E <= 32'h00000000;
            RD2_E <= 32'h00000000;
            Imm_Ext_E <= 32'h00000000;
            RD_E <= 5'h00;
            PCE <= 32'h00000000;
            PCPlus4E <= 32'h00000000;
            RS1_E <= 5'h00;
            RS2_E <= 5'h00;
        end else begin
            RegWriteE <= RegWriteD;
            ALUSrcE <= ALUSrcD;
            MemWriteE <= MemWriteD;
            ResultSrcE <= ResultSrcD;
            BranchE <= BranchD;
            ALUControlE <= ALUControlD;
            RD1_E <= RD1_D;
            RD2_E <= RD2_D;
            Imm_Ext_E <= Imm_Ext_D;
            RD_E <= InstrD[11:7];
            PCE <= PCD;
            PCPlus4E <= PCPlus4D;
            RS1_E <= InstrD[19:15];
            RS2_E <= InstrD[24:20];
        end
    end
endmodule
