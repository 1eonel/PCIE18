`timescale 1ns/1ps


module ParaleloSerial(
  clk, reset, enb,
  clk8,
  entrada,
  salida
);

parameter cantBits = 8;

input wire clk;
input wire enb;
input wire reset;
input wire clk8;
input wire [7:0] entrada;
output reg salida;
reg [3:0] contador;

always @ ( * ) begin
salida = ~reset & enb ? entrada[contador] : 0;
end

always @(posedge clk) begin

  if (reset) begin
    contador <= 0;
  end else if(enb) begin
    contador <= contador == 0 ? cantBits-1 : contador-1;
  end
  else  contador = contador;
  end


endmodule
