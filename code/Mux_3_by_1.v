//3 by 1 MUX module
module Mux_3_by_1(a, b, c, s, d);
    input [1:0] s;
    input [31:0] a, b, c;
    output [31:0] d;
    
    assign d = (s == 2'b00) ? a :
              (s == 2'b01) ? b :
              c;
endmodule
