`timescale 1ns/1ps

`include "deMux.v"

module testDeMux ();
  reg clk;
  reg [7:0] data;
  reg enb;
  wire [3:0] S;
  wire [7:0] outmux;

  parameter COM = 8'hBC,PAD = 8'hF7,SKP = 8'h1C,STP = 8'hFB, SDP = 8'h5C ;
  parameter END = 8'hFD,EDB = 8'hFE,FTS = 8'h3C,IDL = 8'h7C;

  deMux prueba(.data(data), .enb(enb), .S(S), .outmux(outmux));

  always # 4 clk = ~clk;

  initial begin
    $dumpfile("gtkws/testDeMux.vcd");
    $dumpvars;
  end

  initial begin
    clk <= 0;
    enb <= 1;
    data <= IDL;

    # 8
    @ (posedge clk);

    @ (posedge clk); data <= COM;
    @ (posedge clk); data <= STP;
    @ (posedge clk); data <= 8'h1;
    @ (posedge clk); data <= 8'h2;
    @ (posedge clk); data <= 8'h3;
    @ (posedge clk); data <= 8'h4;
    @ (posedge clk); data <= 8'h5;
    @ (posedge clk); data <= 8'h6;
    @ (posedge clk); data <= END;
    @ (posedge clk); data <= COM;


    $finish;
  end




endmodule // testDeMux
