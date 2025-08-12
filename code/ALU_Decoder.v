//alu decoder module
module ALU_Decoder(aluOp, funct3, funct7, op, aluControl);
    input [1:0] aluOp;
    input [2:0] funct3;
    input [6:0] funct7, op;
    output [2:0] aluControl;
    
    assign aluControl = (aluOp == 2'b00) ? 3'b000 :
                       (aluOp == 2'b01) ? 3'b001 :
                       ((aluOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} == 2'b11)) ? 3'b001 :
                       ((aluOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} != 2'b11)) ? 3'b000 :
                       ((aluOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :
                       ((aluOp == 2'b10) & (funct3 == 3'b011)) ? 3'b011 :
                       ((aluOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :
                       3'b000;
endmodule
