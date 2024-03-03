module DMEM (
    input logic reset,
    input logic clk,
    input logic MemRW, 
    input logic [31:0] Address, 
    input logic [31:0] WriteData, 
    output logic [31:0] ReadData
);

    logic [31:0] memory [0:1023];

    // Read operation
    always_comb begin
        if (MemRW == 0)
            ReadData = memory[Address];
    end

    // Write operation
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 1024; i++) begin
                memory[i] = $random;
            end    
        end
        if (MemRW == 1)
            memory[Address] <= WriteData;
    end

endmodule
