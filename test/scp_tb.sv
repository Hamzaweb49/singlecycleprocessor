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
  
  // Instantiate IMemory module
  SingleCycleProcessor  SCP (
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
    reset = 1;
    
    @(posedge clk); 
    reset = 0;
    // Stimulus loop
    repeat(34) begin
      @(posedge clk); 
    end
    
    // End simulation
    $stop;
  end

endmodule

/* verilator lint_on NULLPORT */
