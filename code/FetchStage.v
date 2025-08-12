//top instruction fetch module
module FetchStage(
    input clk,
    input rst,
    input [31:0] pc_mux_in,
    input pc_select,
    output [31:0] instr_out,
    output [31:0] pc_plus_4_out
);
    wire [31:0] pc_current;
    wire [31:0] pc_next;
    wire [31:0] instruction;
    wire [31:0] pc_plus_4;
    
    PCMux pc_mux(
        .pc_in(pc_current),
        .pc_mux_in(pc_mux_in),
        .pc_select(pc_select),
        .pc_out(pc_next)
    );
    
    Counter pc(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_next),
        .pc_out(pc_current)
    );
    
    Adder pc_adder(
        .a(pc_current),
        .b(32'd4),
        .sum(pc_plus_4)
    );
    
    InstructionMemory instr_mem(
        .pc(pc_current),
        .instruction(instruction)
    );
    
    FetchStageRegisters fetch_regs(
        .clk(clk),
        .rst(rst),
        .instr_in(instruction),
        .pc_plus_4_in(pc_plus_4),
        .instr_out(instr_out),
        .pc_plus_4_out(pc_plus_4_out)
    );
endmodule
