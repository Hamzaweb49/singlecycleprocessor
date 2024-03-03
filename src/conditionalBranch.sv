module ConditionalBranch (
    input logic [31:0] operand1,
    input logic [31:0] operand2,
    input logic [2:0] b_type,
    output logic br_taken
);

always_comb begin
    case (b_type)
        3'b000: br_taken = (operand1 == operand2); // BEQ
        3'b001: br_taken = (operand1 != operand2); // BNE
        3'b100: br_taken = (operand1 < operand2);  // BLT
        3'b101: br_taken = (operand1 >= operand2); // BGE
        3'b110: br_taken = (operand1 < operand2);  // BLTU
        3'b111: br_taken = (operand1 >= operand2); // BGEU
        default: br_taken = 0; // Default to not taken
    endcase
end

endmodule
