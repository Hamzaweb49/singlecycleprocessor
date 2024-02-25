module RegisterFile (
    input  logic [4:0] rs1, // Address of rs1
    input  logic [4:0] rs2, // Address of rs2
    input  logic [4:0] rd,  // Address of rd
    input  logic [31:0] writeData, // Data to be written into the register file
    output logic [31:0] dataA, // Output data corresponding to rs1
    output logic [31:0] dataB,  // Output data corresponding to rs2
    input  logic clk, // Clock input
    input  logic reset, // Reset input
    input  logic RegWEn
);

    logic [31:0] registers [31:0]; // Array of 32 registers

    // Initialize register file with random values
    initial begin
        registers[0] = 32'h00000000;
        registers[1] = 32'h00000001;
        registers[2] = 32'h00000002;
        registers[3] = 32'h00000003;
        registers[4] = 32'h00000004;
        registers[5] = 32'h00000005;
        registers[6] = 32'h00000006;
        registers[7] = 32'h00000007;
        registers[8] = 32'h00000008;
        registers[9] = 32'h00000009;
        registers[10] = 32'h00000010;
        registers[11] = 32'h00000011;
        registers[12] = 32'h00000012;
        registers[13] = 32'h00000013;
        registers[14] = 32'h00000014;
        registers[15] = 32'h00000015;
        registers[16] = 32'h00000016;
        registers[17] = 32'h00000017;
        registers[18] = 32'h00000018;
        registers[19] = 32'h00000019;
        registers[20] = 32'h00000020;
        registers[21] = 32'h00000021;
        registers[22] = 32'h00000022;
        registers[23] = 32'h00000023;
        registers[24] = 32'h00000024;
        registers[25] = 32'h00000025;
        registers[26] = 32'h00000026;
        registers[27] = 32'h00000027;
        registers[28] = 32'h00000028;
        registers[29] = 32'h00000029;
        registers[30] = 32'h00000030;
        registers[31] = 32'h00000031;
    end

    always @(*) begin
        dataA = registers[rs1];
        dataB = registers[rs2];
    end

    // Writing data into register file
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            registers[rd] <= 32'h0;
        end else if (RegWEn) begin
            registers[rd] <= writeData;
        end
    end

endmodule
