//PC MUX module
module PCMux(
    input [31:0] pc_in,
    input [31:0] pc_mux_in,
    input pc_select,
    output [31:0] pc_out
);
    assign pc_out = pc_select ? pc_mux_in : pc_in + 4;
endmodule
