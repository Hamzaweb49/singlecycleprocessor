module SCP_TB;

  // Parameters
  parameter IMEM_DEPTH = 256; // Depth of the instruction memory

  // Signals
  reg clk;
  reg reset;
  reg [31:0] program_counter;
  
  // Instantiate IMemory module
  SingleCycleProcessor  SCP (
    .pcounter(program_counter),
    .clk(clk),
    .reset(reset)
  );
  
  // Clock generation
  always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    program_counter = 0; // Initialize program counter
    reset = 1;
    
    #5 reset = 0;
    // Stimulus loop
    repeat(34) begin
      #10; // Wait for a few time units
      
      // Check instruction fetched from memory
      $display("Program Counter = %d", program_counter);
      program_counter = program_counter + 1;
    end
    
    // End simulation
    $stop;
  end

endmodule
