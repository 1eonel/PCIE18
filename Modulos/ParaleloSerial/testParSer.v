`timescale 1ns/1ps

`include "ParaleloSerial.v"
`include "GeneradorClk.v"

module testSerialParalelo ();
  reg clk;
  reg clk2;
  reg enb;
  reg reset;
  reg [7:0] entrada;
  wire salida;
  wire clk10;
  wire clk20;
  wire clk40;

  GeneradorClk clks(.clk(clk), .rst(reset), .enb(enb), .clk10(clk10), .clk20(clk20), .clk40(clk40));
  ParaleloSerial prueba(.clk(clk), .reset(reset), .enb(enb), .clk8(clk10), .entrada(entrada), .salida(salida));

  always # 4 clk = ~clk;
  always # 1 clk2 = ~clk2;


  initial begin
    $dumpfile("gtkws/testParSer.vcd");
    $dumpvars;
  end

  initial begin
    clk <= 1;
    clk2 <=1;
    reset <= 1'b1;
    enb <= 0;

    # 4
    @ (posedge clk);
    reset <= 1'b0;
    enb <= 1;


    # 4
    @ (posedge clk10);
    entrada <= 8'b11100110;
    # 32
    @ (posedge clk10);
    entrada <= 8'b00001101;
    # 32
    @ (posedge clk10);
    entrada <= 8'b01011101;
    # 32





    // 0110 0110 10

    $finish;
  end
endmodule
