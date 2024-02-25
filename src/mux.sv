module Mux (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic sel,
    output logic [31:0] Y
);

    always @* begin
        if (sel == 1'b0)
            Y = A;
        else
            Y = B;
    end

endmodule
