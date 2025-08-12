//instruction memory module
module InstructionMemory(
    input [31:0] pc,
    output [31:0] instruction
);
    reg [31:0] memory [0:255];
    
    initial begin
        $readmemh("instructions.mem", memory);
    end
    
    assign instruction = memory[pc[9:2]];
endmodule
