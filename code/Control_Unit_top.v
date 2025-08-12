//control unit module
module Control_Unit_top(op, regWrite, immSrc, aluSrc, memWrite, resultSrc, branch, funct3, funct7, aluControl);
    input [6:0] op, funct7;
    input [2:0] funct3;
    output regWrite, memWrite, branch, aluSrc, resultSrc;
    output [2:0] aluControl;
    output [1:0] immSrc;
    
    wire [1:0] aluOp;
    
    Main_Decoder mainDec(
        .op(op),
        .regWrite(regWrite),
        .immSrc(immSrc),
        .aluSrc(aluSrc),
        .memWrite(memWrite),
        .resultSrc(resultSrc),
        .branch(branch),
        .aluOp(aluOp)
    );
    
    ALU_Decoder aluDec(
        .aluOp(aluOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(op),
        .aluControl(aluControl)
    );
endmodule
