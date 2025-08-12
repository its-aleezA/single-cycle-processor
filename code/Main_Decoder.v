//main decoder module
module Main_Decoder(op, regWrite, immSrc, aluSrc, memWrite, resultSrc, branch, aluOp);
    input [6:0] op;
    output [1:0] immSrc, aluOp;
    output regWrite, aluSrc, memWrite, resultSrc, branch;
    
    assign regWrite = (op == 7'b0000011 | op == 7'b0110011 | op == 7'b0010011) ? 1'b1 : 1'b0;
    assign immSrc = (op == 7'b0100011) ? 2'b01 :
                   (op == 7'b1100011) ? 2'b10 :
                   2'b00;
    assign aluSrc = (op == 7'b0000011 | op == 7'b0100011 | op == 7'b0010011) ? 1'b1 : 1'b0;
    assign memWrite = (op == 7'b0100011) ? 1'b1 : 1'b0;
    assign resultSrc = (op == 7'b0000011) ? 1'b1 : 1'b0;
    assign branch = (op == 7'b1100011) ? 1'b1 : 1'b0;
    assign aluOp = (op == 7'b0110011) ? 2'b10 :
                  (op == 7'b1100011) ? 2'b01 :
                  2'b00;
endmodule
