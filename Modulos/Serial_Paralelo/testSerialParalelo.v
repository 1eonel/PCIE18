`timescale 1ns/1ps

`include "serialParalelo.v"
`include "GeneradorClk.v"

module testSerialParalelo ();
  reg clk;
  reg enb;
  reg reset;
  reg entrada;
  wire [7:0] salidas;
  wire clk10;
  wire clk20;
  wire clk40;

  GeneradorClk clks(.clk(clk), .rst(reset), .enb(enb), .clk10(clk10), .clk20(clk20), .clk40(clk40));
  serialParalelo prueba(.clk(clk), .reset(reset), .enb(enb), .clk10(clk10), .entrada(entrada), .salidas(salidas));

  always # 4 clk = ~clk;

  initial begin
    $dumpfile("gtkws/testSerPar.vcd");
    $dumpvars;
  end

  initial begin
    clk <= 0;
    reset <= 1'b1;
    enb <= 1;

    # 4
    @ (posedge clk);
    reset <= 1'b0;
    enb <= 1;

    /*
    # 8
    @ (posedge clk);
    entrada <= 1'b0;
    enb <= 1;

    # 8
    @ (posedge clk);
    //entrada <= 1'b0;

    # 8
    @ (posedge clk);
    entrada <= 1'b1;

    //
    // SE APAGA reset
    //
    # 8
    @ (posedge clk);
    reset <= 1'b0;

    */

    // 0110 0110 10
    @ (posedge clk10); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;

    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;


    @ (posedge clk10); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;

    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;


    @ (posedge clk10); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b0;

    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b0;


    @ (posedge clk10); entrada <= 1'b0;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;

    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;
    @ (posedge clk); entrada <= 1'b1;


    @ (posedge clk10);
    reset <= 1'b1;

    # 16
    @ (posedge clk);
    entrada <= 1'b0;

    # 16
    @ (posedge clk);
    entrada <= 1'b1;

    # 16
    @ (posedge clk);
    entrada <= 1'b1;

    # 16
    $finish;
  end
endmodule
