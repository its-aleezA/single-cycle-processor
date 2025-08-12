//register fetch module
module FetchStageRegisters(
    input clk,
    input rst,
    input [31:0] instr_in,
    input [31:0] pc_plus_4_in,
    output reg [31:0] instr_out,
    output reg [31:0] pc_plus_4_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instr_out <= 32'b0;
            pc_plus_4_out <= 32'b0;
        end else begin
            instr_out <= instr_in;
            pc_plus_4_out <= pc_plus_4_in;
        end
    end
endmodule
