`timescale 1ns/1ps

`include "Tx.v"
`include "GeneradorClk.v"


module TB();
    reg clk;
    reg clk2;
    reg [7:0] data;
    reg enb;
    reg reset;
    reg [3:0] S;


    wire clk10;
    wire clk20;
    wire clk40;

    wire L0;
    wire L1;
    wire L2;
    wire L3;


    GeneradorClk clks(.clk(clk), .rst(reset), .enb(enb), .clk10(clk10), .clk20(clk20), .clk40(clk40));
    Tx prueba(.clk(clk10), .clk2(clk), .data(data), .enb(enb), .reset(reset), .S(S), .L0(L0), .L1(L1), .L2(L2), .L3(L3));

    always #4 clk = !clk; //clk sgl.
    always #1 clk2 = !clk2; //clk sgl.

    initial begin
    $display ("test");
    $dumpfile("gtkws/testTx.vcd");
    $dumpvars;
    $display ("time\t    clk  ,   clk10  , data  ,   enb  ,   S   ,   L0  ,   L1  ,   L2  ,   L3 ");
    $monitor ("%g\t      %b        %b      %h       %b      %b        %b       %b       %b      %b",
    $time, clk, clk10, data, enb, S, L0, L1, L2, L3);

    clk <= 1;
    clk2 <=1;
    reset <= 1'b1;
    enb <= 0;
    S <=4'b1001;

    # 8
    @ (posedge clk);
    reset <= 1'b0;
    enb <= 1;


    # 8
        $display("inicio");

    @ (posedge clk10);
    //------------------
    #64
    data <= 8'b11100110;
    S <=4'b1001;
    # 64
    #64
    #64
      data <= 8'b11100110;
	    S <=4'b0100;
	    # 64
      data <= 8'h01;
      S <=4'b0000;
      # 64
      data <= 8'h02;
      # 64
      data <= 8'h03;
      # 64
      data <= 8'h04;
      # 64
      data <= 8'h05;
      # 64

//---------------------
    @ (posedge clk10);
    data <= 8'b00001101;
    S <=4'b0000;
    # 64
    @ (posedge clk10);
    data <= 8'b01011101;
    S <=4'b0110;
    # 64

    $finish;
    end
  endmodule
