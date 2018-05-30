
`include "unstriping.v"

module TBunstriping;
    reg clk;

    reg [7:0] FL0;
    reg [7:0] FL1;
    reg [7:0] FL2;
    reg [7:0] FL3;

    wire [7:0] toDemux;
    parameter COM = 8'hBC,PAD = 8'hF7,SKP = 8'h1C,STP = 8'hFB, SDP = 8'h5C ;
    parameter END = 8'hFD,EDB = 8'hFE,FTS = 8'h3C,IDL = 8'h7C;

    unstriping unst1 (.clk(clk), .FL0(FL0), .FL1(FL1), .FL2(FL2),.FL3(FL3),.toDemux(toDemux));
    always #1 clk = !clk; //clk sgl.

    initial begin
    $dumpvars;    
    $display ("time\t    clk,    TL0   ,    TL1   ,   TL2   ,   TL3  , tomux ");
    $monitor ("%g\t      %b       %h         %h        %h       %h       %h",
    $time, clk, FL0, FL1, FL2,FL3, toDemux);
    $display ("Se prueba la secuencia:");
    $display ("START(STP = FB)");
    $display ("DATOS(ff)");
    $display ("DATOS(ff)");
    $display ("END(fd)");
    $display ("-------------------");
    
    clk<=0;
    FL0 = STP;
    #2
    FL1 = 8'hFF;
    #2
    FL2 = 8'hFF;
    #2
    FL3 = END;
    #2
    $finish;
    end
    endmodule
