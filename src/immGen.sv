module ImmediateGeneration (
    input logic [31:0] instruction,
    input logic ImmSel,
    output logic [31:0] immediate
);

    // Define signal widths
    parameter IMM_WIDTH = 12;

    // Extract immediate based on instruction type
    always_comb begin
        if (ImmSel == 1'b1) begin
            case (instruction[6:0])
                // I-type instructions
                7'b0000011, 7'b0010011, 7'b0001111, 7'b1100111, 7'b0000011, 7'b0000011, 7'b0010011, 7'b0010011, 7'b1100011, 7'b1100011, 7'b1100011, 7'b1100011, 7'b1100011: 
                    immediate = {{20{instruction[31]}}, instruction[31:20]};

                // S-type instructions
                7'b0100011: immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; 

                // B-type instructions
                7'b1100011: immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}; 

                // U-type instructions
                7'b0110111, 7'b0010111: immediate = {instruction[31:12], 12'b0}; 

                // J-type instructions
                7'b1101111: immediate = {{20{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; 

                // Default case
                default: immediate = 32'h0; // Default to all zeros if instruction type is not recognized
            endcase 
        end
        else begin
            immediate = 32'h0;
        end
    end

endmodule