//MUX module
module Muxx(a, b, s, c);
    input [31:0] a, b;
    input s;
    output [31:0] c;
    
    assign c = s ? b : a;
endmodule
