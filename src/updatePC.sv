module UpdatePC(
    input logic br_taken,
    input logic [31:0] alu_result,
    input logic clk,
    input logic [31:0] pc,
    output logic [31:0] nextpc
);

always_ff @(posedge clk) begin
    if (br_taken) begin // If branch is taken
        nextpc= pc + alu_result; // Add ALU result to PC
    end else begin
        nextpc = pc + 1; // Increment PC by 1
    end
end

endmodule