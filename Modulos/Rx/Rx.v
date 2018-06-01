`timescale 1ns/1ps

`include "deMux.v"
`include "unstriping.v"
`include "serialParalelo.v"
`include "GeneradorClk.v"

module Rx (clk, enb, reset, L0, L1, L2, L3, S, data);
  input clk;
  input enb;
  input reset;
  input L0;
  input L1;
  input L2;
  input L3;

  output [3:0] S;
  output [7:0] data;

  wire [7:0] TL0;
  wire [7:0] TL1;
  wire [7:0] TL2;
  wire [7:0] TL3;

  wire clk4;
  wire clk8;
  wire clk16;


  wire [7:0] inMux;

  GeneradorClk clocks(.clk(clk), .rst(reset), .enb(enb), .clk10(clk4), .clk20(clk8), .clk40(clk16));

  serialParalelo SP0(.clk(clk), .reset(reset), .enb(enb), .clk10(clk), .entrada(L0), .salidas(TL0));
  serialParalelo SP1(.clk(clk), .reset(reset), .enb(enb), .clk10(clk), .entrada(L1), .salidas(TL1));
  serialParalelo SP2(.clk(clk), .reset(reset), .enb(enb), .clk10(clk), .entrada(L2), .salidas(TL2));
  serialParalelo SP3(.clk(clk), .reset(reset), .enb(enb), .clk10(clk), .entrada(L3), .salidas(TL3));

  unstriping ByUn(.clk(clk8), .FL0(TL0), .FL1(TL1), .FL2(TL2), .FL3(TL3), .toDemux(inMux));

  deMux demux(.data(inMux), .enb(enb), .S(S), .outmux(data));

endmodule
