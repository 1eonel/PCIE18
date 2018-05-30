//Pruebas para Registro Desplazable 4 bits
//Bryan Cervantes Ramirez- B31726
`include "MuxCtrl.v"
module test;

reg clk;
reg [7:0] data;
reg enb;
reg [3:0] S;
wire [7:0] outmux;


	MuxCtrl Mux1(.clk(clk), .data(data), .enb(enb), .S(S), .outmux(outmux));

	always #2 clk = !clk;

	initial begin
	$display ("Mux test");
  $dumpvars;
  $display ("time\t     data  ,	       enb ,       S ,    outmux      ");
  $monitor ("%g\t      %h	   	%h          %h       %h            ",
  $time, data ,enb ,S ,outmux);

		$display("-----Test Mux de Control----");
		//Valores iniciales:
		clk <=0;
		enb <= 1;
		#2
		data <= 4'b1010;
		S <= 4'b0000;
		#8
		S <= 4'b0010;
		#8
		$display("-----STP Signal-----");
		S <= 4'b0100;
		#6
		$display("-----SDP Signal-----");
		S <= 4'b0101;
		#6
		$display("-----END Signal-----");
		S <= 4'b0110;
		#6
		$display("-----IDL Signal-----");
		S <= 4'b1001;
		#6
		$display("-----SKṔ Signal-----");
		S <= 4'b0011;
		#6



		$finish;
	    end
endmodule
