GHDL=ghdl
FLAGS=--std=08 --ieee=synopsys -fsynopsys -fexplicit
SOURCES=src/cpu.vhdl
TESTS=test/cpu_test.vhdl

all:
	@$(GHDL) -a $(FLAGS) $(SOURCES) $(TESTS)
