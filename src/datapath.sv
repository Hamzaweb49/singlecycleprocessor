module Datapath (
    input logic clk, 
    input logic reset,
    input logic [1:0] WBSel,
    input logic BSel,
    input logic [3:0] ALUSel,
    input logic [2:0] branch_type,
    input logic RegWEn,
    input logic ImmSel,
    input logic MemRW,
    output logic [31:0] PC
);

    logic [31:0] instruction;
    logic [31:0] dataA, dataB, immediate;
    logic [31:0] ALUResult;
    logic [31:0] Bmux_output;
    logic [31:0] Wmux_output;
    logic [31:0] dmem_data;
    logic br_taken;

    UpdatePC UPC (
        .pc(PC),
        .br_taken(br_taken),
        .alu_result(alu_result)
    );
    IMemory IM (
        .program_counter(PC), 
        .instruction(instruction)
    );
    RegisterFile RF (
        .clk(clk), 
        .reset(reset), 
        .rs1(instruction[19:15]), 
        .rs2(instruction[24:20]), 
        .rd(instruction[11:7]), 
        .writeData(Wmux_output), 
        .dataA(dataA), 
        .dataB(dataB), 
        .RegWEn(RegWEn)
    );
    ImmediateGeneration ImmGen (
        .instruction(instruction), 
        .immediate(immediate), 
        .ImmSel(ImmSel)
    );
    Mux MX1 (
        .A(dataB), 
        .B(immediate), 
        .sel(BSel), 
        .Y(Bmux_output)
    );
    Mux MX2(
        .A(PC),
        .B(dataA),
        .sel(ASel),
        .Y(Amux_output)
    );
    ConditionalBranch CB(
        .operand1(dataA),
        .operand2(dataB),
        .b_type(branch_type),
        .br_taken(br_taken)
    );
    ALU ALU1 (
        .operand1(Amux_output), 
        .operand2(Bmux_output), 
        .ALUSel(ALUSel), 
        .result(ALUResult)
    );
    DMEM DM (
        .Address(ALUResult), 
        .WriteData(dataB), 
        .MemRW(MemRW), 
        .ReadData(dmem_data)
    );
    Mux3x1 MX3 (
        .A(ALUResult), 
        .B(dmem_data),
        .C(PC + 1), 
        .sel(WBSel), 
        .Y(Wmux_output)
    );

endmodule
