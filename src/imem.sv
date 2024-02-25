module IMemory #(parameter IMEM_DEPTH = 256, parameter INSTR_WIDTH = 32)
                (input logic [31:0] program_counter,
                 output logic [INSTR_WIDTH-1:0] instruction);

  // Define memory array to hold instructions
  logic [INSTR_WIDTH-1:0] mem [0:IMEM_DEPTH-1];

  // Initialize memory with RISC-V RV32I instructions
  initial begin
    // R-type Instructions
    mem[0] = 32'b00000000000000001000000000110011; // ADD
    mem[1] = 32'b01000000000000001000000000110011; // SUB
    mem[2] = 32'b0000000_00000_00001_111_00000_0110011; // AND
    mem[3] = 32'b0000000_00000_00001_110_00000_0110011; // OR
    mem[4] = 32'b0000000_00000_00001_100_00000_0110011; // XOR
    mem[5] = 32'b0000000_00000_00001_001_00000_0110011; // SLL
    mem[6] = 32'b0000000_00000_00001_101_00000_0110011; // SRL
    
    // I-type Instructions
    mem[7]  = 32'b0000000_00001_00010_000_00000_0010011; // ADDI
    mem[8]  = 32'b0000000_00001_00010_010_00000_0010011; // SLTI
    mem[9]  = 32'b0000000_00001_00010_011_00000_0010011; // SLTIU
    mem[10] = 32'b0000000_00001_00010_100_00000_0010011; // XORI
    mem[11] = 32'b0000000_00001_00010_110_00000_0010011; // ORI
    mem[12] = 32'b0000000_00001_00010_111_00000_0010011; // ANDI
    mem[13] = 32'b0000000_00001_00010_001_00000_0010011; // SLLI
    mem[14] = 32'b0000000_00001_00010_101_00000_0010011; // SRLI
    mem[15] = 32'b0100000_00001_00010_101_00000_0010011; // SRAI
    mem[16] = 32'b0000000_00001_00010_000_00000_0000011; // LB
    mem[17] = 32'b0000000_00001_00010_001_00000_0000011; // LH
    mem[18] = 32'b0000000_00001_00010_010_00000_0000011; // LW
    mem[19] = 32'b0000000_00001_00010_100_00000_0000011; // LBU
    mem[20] = 32'b0000000_00001_00010_101_00000_0000011; // LHU
    mem[21] = 32'b0000000_00001_00000_000_00000_1100111; // JALR
    
    // S-type Instructions
    mem[22] = 32'b0000000_00001_00010_000_00000_0100011; // SB
    mem[23] = 32'b0000000_00001_00010_001_00000_0100011; // SH
    mem[24] = 32'b0000000_00001_00010_010_00000_0100011; // SW
    
    // B-type Instructions
    mem[25] = 32'b0000000_00001_00010_000_00000_1100011; // BEQ
    mem[26] = 32'b0000000_00001_00010_001_00000_1100011; // BNE
    mem[27] = 32'b0000000_00001_00010_100_00000_1100011; // BLT
    mem[28] = 32'b0000000_00001_00010_101_00000_1100011; // BGE
    mem[29] = 32'b0000000_00001_00010_110_00000_1100011; // BLTU
    mem[30] = 32'b0000000_00001_00010_111_00000_1100011; // BGEU
    
    // U-type Instructions
    mem[31] = 32'b0000000_00001_00000_00000000000011011; // LUI
    mem[32] = 32'b0000000_00001_00000_00000000000010111; // AUIPC
    
    // J-type Instructions
    mem[33] = 32'b0000000_00001_00000_00000000000101111; // JAL
  end

  // Output the instruction based on the program counter
  always_comb begin
    if (program_counter < IMEM_DEPTH)
      instruction = mem[program_counter];
    else
      instruction = 32'h00000000; // Default to all zeros if program counter exceeds memory depth
  end

endmodule
