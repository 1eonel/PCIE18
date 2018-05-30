all:
	iverilog -o bin/pruebaDeMux testDeMux.v
	vvp bin/pruebaDeMux
	gtkwave gtkws/testDeMux.vcd
