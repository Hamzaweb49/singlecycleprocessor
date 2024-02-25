module Datapath (
    input logic clk, 
    input logic reset,
    input logic [31:0] PC,
    input logic WBSel,
    input logic BSel,
    input logic [3:0] ALUSel,
    input logic RegWEn,
    input logic ImmSel,
    input logic MemRW
);

    logic [31:0] instruction;
    logic [31:0] dataA, dataB, immediate;
    logic [31:0] ALUResult;
    logic [31:0] Bmux_output;
    logic [31:0] Wmux_output;
    logic [31:0] dmem_data;

    IMemory IM (.program_counter(PC), .instruction(instruction));
    RegisterFile RF (.clk(clk), .reset(reset), .rs1(instruction[19:15]), .rs2(instruction[24:20]), .rd(instruction[11:7]), .writeData(Wmux_output), .dataA(dataA), .dataB(dataB), .RegWEn(RegWEn));
    ImmediateGeneration ImmGen (.instruction(instruction), .immediate(immediate), .ImmSel(ImmSel));
    Mux MX1 (.A(dataB), .B(immediate), .sel(BSel), .Y(Bmux_output));
    ALU ALU1 (.operand1(dataA), .operand2(Bmux_output), .ALUSel(ALUSel), .result(ALUResult));
    DMEM DM (.Address(ALUResult), .WriteData(dataB), .MemRW(MemRW) , .ReadData(dmem_data));
    Mux MX2 (.A(ALUResult), .B(dmem_data), .sel(WBSel), .Y(Wmux_output));

endmodule
