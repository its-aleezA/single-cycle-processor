//ALU module
module ALU(A, B, Result, ALUControl, OverFlow, Carry, Zero, Negative);
    input [31:0] A, B;
    input [2:0] ALUControl;
    output Carry, OverFlow, Negative, Zero;
    output [31:0] Result;
    
    wire [32:0] Sum;
    wire [31:0] B_internal;
    
    assign B_internal = ALUControl[0] ? ~B + 1 : B;
    assign Sum = A + B_internal;
    
    assign Result = (ALUControl == 3'b000) ? Sum[31:0] :  // ADD/SUB
                   (ALUControl == 3'b001) ? Sum[31:0] :  // SUB
                   (ALUControl == 3'b010) ? A & B :
                   (ALUControl == 3'b011) ? A | B :
                   (ALUControl == 3'b100) ? A ^ B :
                   (ALUControl == 3'b101) ? {31'b0, Sum[31]} :  // SLT
                   (ALUControl == 3'b110) ? A << B[4:0] :
                   (ALUControl == 3'b111) ? A >> B[4:0] :
                   32'b0;
    
    assign OverFlow = (ALUControl[1:0] == 2'b00) & (A[31] == B_internal[31]) & (Sum[31] != A[31]);
    assign Carry = Sum[32];
    assign Zero = (Result == 32'b0);
    assign Negative = Result[31];
endmodule
