//memory cycle module
module memory_cycle(
    input clk, rst, RegWriteM, MemWriteM, ResultSrcM,
    input [4:0] RD_M,
    input [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output RegWriteW, ResultSrcW,
    output [4:0] RD_W,
    output [31:0] PCPlus4W, ALU_ResultW, ReadDataW
);
    wire [31:0] ReadDataM;
    
    reg RegWriteW, ResultSrcW;
    reg [4:0] RD_W;
    reg [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
    
    Data_Memory dmem(
        .clk(clk),
        .rst(rst),
        .WE(MemWriteM),
        .WD(WriteDataM),
        .A(ALU_ResultM),
        .RD(ReadDataM)
    );
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            RegWriteW <= 1'b0;
            ResultSrcW <= 1'b0;
            RD_W <= 5'h00;
            PCPlus4W <= 32'h00000000;
            ALU_ResultW <= 32'h00000000;
            ReadDataW <= 32'h00000000;
        end else begin
            RegWriteW <= RegWriteM;
            ResultSrcW <= ResultSrcM;
            RD_W <= RD_M;
            PCPlus4W <= PCPlus4M;
            ALU_ResultW <= ALU_ResultM;
            ReadDataW <= ReadDataM;
        end
    end
endmodule
