`timescale 1ns/1ps

//S = 00 o 01 implica 8 bits; 01 implica 16 y 10 implica 32 bits

module byteStriping(
  reset, enb, clk,
  clk16, clk32,
  entrada8, entrada16, entrada32,
  S,
  salida
);

  input wire reset;
  input wire enb;
  input wire clk;
  input wire clk16;
  input wire clk32;

  input wire [7:0]  entrada8;   // 8 bits
  input wire [15:0] entrada16;
  input wire [31:0] entrada32;
  input wire [1:0]  S;// seleccion de modo

  output reg [7:0] salida;

  reg [1:0] contador;

  always @ ( * ) begin
    if (S == 2'b01) begin
      salida = contador == 0 ? entrada16[15:8] : entrada16[7:0];
    end else if(S == 2'b10) begin
      if (contador == 0) salida = entrada32[31:24];
      else if (contador == 2'b01) salida = entrada32[23:16];
      else if (contador == 2'b10) salida = entrada32[15:8];
      else salida = entrada32[7:0];
    end else begin
      salida = entrada;
    end
  end

  always @ (posedge clk) begin
    if (S == 2'b01) begin
      contador <= contador >= 2'b01 ? 0 : contador + 1;
    end else if (S ==2'b10) begin
      contador <= contador >= 2'b11 ? 0 : contador + 1;
    end else begin
      contador <= 0;
    end
  end


  endmodule
