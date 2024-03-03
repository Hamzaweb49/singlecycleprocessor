module Mux3x1 (
    input logic [31:0] A, // ALU Result
    input logic [31:0] B, // DMEM Result
    input logic [31:0] C, // PC increment
    input logic [1:0] sel,
    output logic [31:0] Y
);

    always @* begin
        if (sel == 2'b00)
            Y = A;
        else if (sel == 2'b01)
            Y = B;
        else if (sel == 2'b10)
            Y = C;
    end

endmodule
