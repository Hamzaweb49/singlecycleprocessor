/* verilator lint_off NULLPORT */

module SCP_TB(
  `ifdef VERILATOR
    input logic clk,
  `endif
);

  // Parameters
  parameter IMEM_DEPTH = 256; // Depth of the instruction memory

  // Signals
  `ifndef VERILATOR
    logic                   clk;
  `endif;
  reg reset;
  reg [31:0] program_counter;
  
  // Instantiate IMemory module
  SingleCycleProcessor  SCP (
    .pcounter(program_counter),
    .clk(clk),
    .reset(reset)
  );
  
  // Clock generation
  `ifndef VERILATOR
  always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end
  `endif

  // Testbench stimulus
  initial begin
    `ifndef VERILATOR
    clk = 0;
    `endif
    program_counter = 0; // Initialize program counter
    reset = 1;
    
    @(posedge clk); 
    reset = 0;
    // Stimulus loop
    repeat(34) begin
      @(posedge clk); 
      // Check instruction fetched from memory
      $display("Program Counter = %d", program_counter);
      program_counter = program_counter + 1;
    end
    
    // End simulation
    $stop;
  end

endmodule

/* verilator lint_on NULLPORT */
