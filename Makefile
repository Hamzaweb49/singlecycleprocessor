# Makefile for Verilog simulation using VSIM

# Define VSIM variables
VSIM = vsim
VSIM_FLAGS = -R

# Define simulation variables
SIM_BINARY = sim_bin

SIM_SRC_VSIM = src/scp.sv \
					src/datapath.sv \
					src/controller.sv \
					src/alu.sv \
					src/imem.sv \
					src/registers.sv \
					src/mux.sv \
					src/immGen.sv \
					src/dmem.sv \
					test/scp_tb.sv


COMP_OPTS_SV := --incr --relax

TB_TOP = tb_SequentialMultiplier
MODULE = tb_SequentialMultiplier


# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "Verilog Simulation Makefile"
	@echo "---------------------------"
	@echo "Targets:"
	@echo "  help          - Display this help message"
	@echo "  sim TOOL=vsim - Run simulation using VSIM"
	@echo "  sim TOOL=verilator - Run simulation using Verilator"
	@echo "  clean         - Remove generated files"

# Simulation target
.PHONY: sim
sim:
ifdef TOOL
ifeq ($(TOOL),vsim)
	@echo "Running VSIM simulation..."
	vlog $(SIM_SRC_VSIM)
	vsim tb_SequentialMultiplier

else
	@echo "Invalid TOOL specified. Please use 'vsim' or 'verilator'."
endif
else
	@echo "Please specify the simulation tool using 'make sim TOOL=vsim' or 'make sim TOOL=verilator'."
endif

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf $(SIM_BINARY) obj_dir