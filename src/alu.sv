module ALU #(parameter INSTR_WIDTH = 32)
           (input logic [31:0] operand1,
            input logic [31:0] operand2,
            input logic [3:0] ALUSel,
            output logic [31:0] result);


  always_comb begin
    case (ALUSel)
      // R-type Instructions
      4'b0000: result = operand1 + operand2; // ADD
      4'b0001: result = operand1 - operand2; // SUB
      4'b0010: result = operand1 & operand2; // AND
      4'b0011: result = operand1 | operand2; // OR
      4'b0100: result = operand1 ^ operand2; // XOR
      4'b0101: result = operand1 << operand2; // SLL
      4'b0110: result = operand1 >> operand2; // SRL

      // I-type Instructions
      4'b0111: result = operand1 + operand2; // ADDI
      4'b1000: result = operand1 << operand2; // SLLI
      4'b1001: result = operand1 >> operand2; // SRLI
      // SLTI, SLTIU, XORI, ORI, ANDI, SRAI
      
      // Memory Instructions
      // LB, LH, LW, LBU, LHU, SB, SH, SW 

      // Branch Instructions
      // BEQ, BNE, BLT, BGE, BLTU, BGEU

      // U-type Instructions
      4'b1010: result = operand1 + operand2; // LUI
      4'b1011: result = operand1 + operand2; // AUIPC

      // J-type Instructions
      4'b1100: result = operand1 + operand2; // JAL
      4'b1101: result = operand1 + operand2; // JALR
    endcase
  end

endmodule
