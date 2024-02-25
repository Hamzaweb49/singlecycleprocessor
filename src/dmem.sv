module DMEM (
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
    always_ff @(posedge MemRW) begin
        if (MemRW == 1)
            memory[Address] <= WriteData;
    end

    initial begin
        $readmemh("dmem.txt", memory);
    end

endmodule
