`include "striping.v"

module TBStriping;
    reg clk;
    reg [7:0] fromMux;

    wire [7:0] TL0;
    wire [7:0] TL1;
    wire [7:0] TL2;
    wire [7:0] TL3;

    striping byteStp (.clk(clk), .fromMux(fromMux), .TL0(TL0), .TL1(TL1), .TL2(TL2),.TL3(TL3));

    always #1 clk = !clk; //clk sgl.

    initial begin
    $display ("test");
    $dumpvars;
    $display ("time\t    clk,      fromMux,    TL0   ,    TL1   ,   TL2   ,   TL3   ");
    $monitor ("%g\t      %b          %h         %h        %h         %h        %h",
    $time, clk, fromMux, TL0, TL1, TL2,TL3);

    clk <= 0;
    #4
    $display ("dsadsad");
    fromMux = 8'h1C; //SKP
    #6
        $display ("dsadsad");

    fromMux = 8'h7C; //IDLE
    #6
        $display ("dsadsad");

    fromMux = 8'hFB; //STP
    #2
    $display ("stp");
    fromMux = 8'hFF;
    #12
    $display ("ff");
    fromMux = 8'hFD;
    #2
    $display ("end FD");
    $finish;
    end

    endmodule