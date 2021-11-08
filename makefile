# CC and CFLAGS are varilables
CC = iverilog
# CFLAGS = -c
# AR = ar
# ARFLAGS = rcv
# -c option ask g++ to compile the source files, but do not link.
# -g option is for debugging version
# -O2 option is for optimized version
# DBGFLAGS = -g -D_DEBUG_ON_
# OPTFLAGS = -O3

all: CPU.out
	@echo -n ""

CPU.out: *.v
	$(CC) -o $@ $^

sim:
	vvp CPU.out

wav:
	gtkwave CPU.vcd

clean:
	rm -rf *.out *.vcd output.txt
