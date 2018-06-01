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
    $display ("------------------------------test striping-------------------------------");
    $dumpvars;
    $display ("time\t    clk,      fromMux,    TL0   ,    TL1   ,   TL2   ,   TL3   ");
    $monitor ("%g\t      %b          %h         %h        %h         %h        %h",
    $time, clk, fromMux, TL0, TL1, TL2,TL3);

    clk <= 0;
    #4
    $display ("------------------------------Agregamos SKIPS (SKP = 1C) -------------------------------");
    fromMux = 8'h1C; //SKP
    #6
        $display ("------------------------------Agregamos IDLE (IDL = 7C) -------------------------------");

    fromMux = 8'h7C; //IDLE
    #6
        $display ("------------------------------Agregamos START (STP = FB) -------------------------------");

    fromMux = 8'hFB; //STP
    #2
    $display ("------------Agregamos 6 bytes seguidos de DATOS (en este caso FF simbolizan datos) ------------");
    fromMux = 8'h01;
    #2
    fromMux = 8'h02;
    #2
    fromMux = 8'h03;
    #2
    fromMux = 8'h04;
    #2
    fromMux = 8'h05;
    #2
    fromMux = 8'h06;
    #2
    $display ("------------------------------Agregamos END (END = ) -------------------------------");
    fromMux = 8'hFD;
    #2
    $display ("Podemos ver como inicialmente se detecta un START, se manda al LANE0, y se siguen recibiendo datos hasta que se recibe el END");
    $finish;
    end

    endmodule