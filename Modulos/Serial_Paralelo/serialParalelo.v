`timescale 1ns/1ps

module serialParalelo(
  clk, reset, enb,
  clk10,
  entrada,
  salidas
);

parameter cantBits = 8;

input wire clk;
input wire reset;
input wire enb;
input wire clk10;
input wire entrada;
output reg [7:0] salidas;

reg [3:0] contador;
reg [7:0] bits;

always @(posedge clk) begin
  if (reset) begin
    contador <= 0;
  end else if (enb) begin
    contador <= contador == 0 ? cantBits-1 : contador-1;
    bits[contador] <= entrada;
    if (contador ==  0) begin
      salidas <= {bits[cantBits-1:1], entrada};
    end
  end
end




endmodule
