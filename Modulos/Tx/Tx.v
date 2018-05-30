`timescale 1ns/1ps

`include "MuxCtrl.v"
`include "striping.v"
`include "ParaleloSerial.v"

module Tx (clk, clk2, data, enb, reset, S, L0, L1, L2, L3);
  input clk;
  input clk2;
  input [7:0] data;
  input enb;
  input reset;
  input [3:0] S;

  output L0;
  output L1;
  output L2;
  output L3;

  wire [7:0] outmux;

  reg [7:0] TL0;
  reg [7:0] TL1;
  reg [7:0] TL2;
  reg [7:0] TL3;

  MuxCtrl Mux1(.clk(clk), .data(data), .enb(enb), .S(S), .outmux(outmux));

  striping byteStp (.clk(clk), .fromMux(outmux), .TL0(TL0), .TL1(TL1), .TL2(TL2),.TL3(TL3));

  ParaleloSerial PS0 (.clk(clk2), .reset(reset), .enb(enb), .clk8(clk), .entrada(TL0), salida(L0));
  ParaleloSerial PS1 (.clk(clk2), .reset(reset), .enb(enb), .clk8(clk), .entrada(TL1), salida(L1));
  ParaleloSerial PS2 (.clk(clk2), .reset(reset), .enb(enb), .clk8(clk), .entrada(TL2), salida(L2));
  ParaleloSerial PS3 (.clk(clk2), .reset(reset), .enb(enb), .clk8(clk), .entrada(TL3), salida(L3));
endmodule
