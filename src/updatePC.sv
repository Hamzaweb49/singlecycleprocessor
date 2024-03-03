module UpdatePC(
    input logic br_taken,
    input logic [31:0] alu_result,
    output logic [31:0] pc
);

always_comb begin
    if (br_taken) // If branch is taken
        pc= pc + alu_result; // Add ALU result to PC
    else
        pc = pc + 1; // Increment PC by 1
end

endmodule