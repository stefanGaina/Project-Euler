all: clean
	as -g -c main.s -o main.o
	ld main.o -o s25
	gdb -ex "layout regs" -ex "br 26" s25

clean:
	rm -f main.o
	rm -f s25
