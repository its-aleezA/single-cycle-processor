//PC adder module
module Adder(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    assign sum = a + b;
endmodule

//AND gate module
module AND(a, b, c);
    input a, b;
    output c;
    
    assign c = a & b;
endmodule
