module SingleCycleProcessor (
    input logic clk, 
    input logic [31:0] pcounter,
    input logic reset
);

    logic RegWEn, MemRW, ImmSel;
    logic  BSel, ASel;
    logic [1:0] WBSel; 
    logic [3:0] ALUSel;
    logic [2:0] branch_type;


    Datapath DP (.clk(clk), .reset(reset), .ImmSel(ImmSel), .WBSel(WBSel), .branch_type(branch_type), .RegWEn(RegWEn), .PC(pcounter), .ALUSel(ALUSel), .MemRW(MemRW), .BSel(BSel), .ASel(ASel));
    Controller C (.clk(clk), .reset(reset), .instruction(DP.instruction), .ImmSel(ImmSel), .RegWEn(RegWEn), .branch_type(branch_type), .ALUSel(ALUSel), .MemRW(MemRW), .Bsel(BSel), .WBSel(WBSel), .Asel(ASel));


endmodule
