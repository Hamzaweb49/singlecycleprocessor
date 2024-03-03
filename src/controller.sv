module Controller (
    input logic clk,
    input logic reset,
    input logic [31:0] instruction,
    output logic ImmSel,
    output logic RegWEn,
    output logic Bsel,
    output logic [2:0] branch_type,
    output logic [3:0] ALUSel,
    output logic MemRW,
    output logic [1:0] WBSel,
    output logic Asel
);

    localparam [6:0] R_TYPE = 7'b0110011;
    localparam [6:0] I_TYPE = 7'b0010011;
    localparam [6:0] S_TYPE = 7'b0100011;
    localparam [6:0] B_TYPE = 7'b1100011;
    localparam [6:0] U_TYPE = 7'b0110111;
    localparam [6:0] J_TYPE = 7'b1101111;

    // Decode the opcode
    logic [6:0] opcode;

    // Decode the funct3 field
    logic [2:0] funct3;

    // Decode the funct7 field
    logic [6:0] funct7;

    assign opcode = instruction[6:0];

    assign func3  = instruction[14:12];

    assign func7 = instruction[31:25];

    assign branch_type = instruction[6:0] == 7'b1100011 ? instruction[14:12] : 3'b0;

    // Decode the immediate type instructions
    assign ImmSel = (opcode == 7'b0000011 || opcode == 7'b0010011 || opcode == 7'b1100111 || opcode == 7'b1100011 || opcode == 7'b0000011);
    
    // Decode the register-write enable signal
    assign RegWEn = (opcode == 7'b0110011 || opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b1100111 || opcode == 7'b1100011 || opcode == 7'b0100011 || opcode == 7'b0001111 || opcode == 7'b0010111 || opcode == 7'b1101111 || opcode == 7'b0110111);


    // Decode the A-select signal
    always_comb begin
        case(opcode)
            7'b1100111:
                Asel = 1'b0; // PC
            default:
                Asel = 1'b0; // rs1
        endcase
    end

    // Decode the B-select signal
    always_comb begin
        case(opcode)
            7'b0000011, 7'b0010011, 7'b1100111, 7'b1100011:
                Bsel = 1'b1; // Immediate
            default:
                Bsel = 1'b0; // rs2
        endcase
    end


    // Decode the ALU-select signal
    always_comb begin
        case(opcode)
            7'b0110011, 7'b0010011, 7'b1100111, 7'b1100011, 7'b0100011, 7'b0000011, 7'b0011011, 7'b0111011, 7'b0010111, 7'b0110111, 7'b1101111:
                case(funct3)
                    3'b000:
                        ALUSel = 4'b0000; // ADD, SUB
                    3'b001:
                        ALUSel = 4'b0001; // SLL
                    3'b010:
                        ALUSel = 4'b0010; // SLT
                    3'b011:
                        ALUSel = 4'b0011; // SLTU
                    3'b100:
                        ALUSel = 4'b0100; // XOR
                    3'b101:
                        if (funct7[5] == 0)
                            ALUSel = 4'b0101; // SRL
                        else
                            ALUSel = 4'b0110; // SRA
                    3'b110:
                        ALUSel = 4'b0110; // OR
                    3'b111:
                        ALUSel = 4'b0111; // AND
                    default:
                        ALUSel = 4'b0000; // Default to ADD for unrecognized instructions
                endcase
            default:
                ALUSel = 4'b0000; // Default to ADD for non-R-type instructions
        endcase
    end

    // Decode the memory-read/write signal
    assign MemRW = (opcode == 7'b0000011 || opcode == 7'b0000011 || opcode == 7'b0100011);

    // Decode the write-back select signal
    always_comb begin
        case(opcode)
            7'b0110011, 7'b0010011, 7'b1100111, 7'b1100011, 7'b0100011, 7'b0000011, 7'b0011011, 7'b0111011, 7'b0010111, 7'b0110111:
                WBSel = 2'b00; // ALU output
            7'b0000011, 7'b0010011, 7'b0100011:
                WBSel = 2'b01; // Memory output
            7'b1101111:
                WBSel = 2'b10;
            default:
                WBSel = 2'b0; // Default to zero for non-write instructions
        endcase
    end

endmodule
