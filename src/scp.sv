module SingleCycleProcessor (
    input logic clk, 
    input logic [31:0] pcounter,
    input logic reset
);

    logic RegWEn, MemRW, ImmSel;
    logic  BSel, WBSel;
    logic [3:0] ALUSel;


    Datapath DP (.clk(clk), .reset(reset), .ImmSel(ImmSel), .WBSel(WBSel), .RegWEn(RegWEn), .PC(pcounter), .ALUSel(ALUSel), .MemRW(MemRW), .BSel(BSel));
    Controller C (.clk(clk), .reset(reset), .instruction(DP.instruction), .ImmSel(ImmSel), .RegWEn(RegWEn), .ALUSel(ALUSel), .MemRW(MemRW), .Bsel(BSel), .WBSel(WBSel));


endmodule
