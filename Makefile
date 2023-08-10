GHDL=ghdl
FLAGS=--std=08 --ieee=synopsys -fsynopsys -fexplicit
SOURCES=src/cpu.vhdl src/alu.vhdl src/adder.vhdl
TESTS=test/cpu_test.vhdl test/alu_test.vhdl test/adder_test.vhdl
WORKDIR=./build/

all:
	@$(GHDL) -a $(FLAGS) --workdir=$(WORKDIR) $(SOURCES) $(TESTS)
