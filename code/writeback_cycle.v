//write back cycle module
module writeback_cycle(
    input clk, rst, ResultSrcW,
    input [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
    output [31:0] ResultW
);
    Mux_3_by_1 result_mux(
        .a(ALU_ResultW),
        .b(ReadDataW),
        .c(PCPlus4W),
        .s({1'b0, ResultSrcW}),
        .d(ResultW)
    );
endmodule
