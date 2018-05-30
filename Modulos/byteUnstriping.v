`timescale 1ns/1ps

//S = 00 o 11 implica 8 bits; 01 implica 16 y 10 implica 32 bits

module byteUnstriping(
  reset, enb,
  clk, clk8, clk16, clk32,
  entrada,
  S,
  salida8, salida16, salida32,
  bits,
  contador,
  internoS
);

  input wire reset;
  input wire enb;
  input wire clk;
  input wire clk8;
  input wire clk16;
  input wire clk32;
  input wire [7:0] entrada;
  input wire [1:0] S;

  output reg [1:0] internoS;
  output reg [7:0] salida8;
  output reg [15:0] salida16;
  output reg [31:0] salida32;
  output reg [31:0] bits;

  reg [7:0] salidaReg8;
  reg [15:0] salidaReg16;
  reg [31:0] salidaReg32;
  reg [7:0] bits8;
  reg [15:0] bits16;
  reg [31:0] bits32;

  output reg [1:0] contador;

  always @ ( * ) begin
    if (S == 2'b01 && ~internoS) begin
      salida8 = bits8;
      salida16 = contador == 2'b01 ? {bits[15:8], entrada} : bits16;
      salida32 = bits32;
    end else if (S == 2'b10 && dataSInternal) begin
      salida8 = bits8;
      salida16 = bits16;
      salida32 = contador == 2'b11 ? {bits[31:8], entrada} : bits32;
    end else if () begin
    salida8 = (S == 2'b00 || S == 2'b11) ? {entrada} : bits8;
    salida16 = bits16;
    salida32 = bits32;
    end
  end

  always @ ( posedge clk8 ) begin
    if (reset) begin
      contador <= 0;
      bits <= 0;
      internoS <= 1;
    end
    if (~reset && enb) begin
      bits8 <= (S == 2'b00 || S == 2'b11) ? entrada : bits8;
      bits16 <= internoS && S == 2'b01 ?  {bits[15:8], entrada} : bits16;
      bits32 <= internoS && S == 2'b10 ?  {bits[31:8], entrada} : bits32;
      if (S == 2'b01) begin
        contador <= (contador >= 2'b01) ? 2'b00 : contador + 1;
        internoS <= (contador == 2'b00) ? 1 : 0;
        if (contador == 2'b00) begin
          bits[15:8] <= entrada;
        end else begin
          bits[7:0]  <= entrada;
        end
      end else if (S == 2'b10) begin
        contador <= (contador >= 2'b11) ? 2'b00 : contador + 1;
        internoS <= (contador == 2'b10) ? 1 : 0;
        if (contador == 2'b00) begin
          bits[31:24] <= entrada;
        end else if (contador == 2'b01) begin
          bits[23:16] <= entrada;
        end else if (contador == 2'b10) begin
          bits[15:8] <= entrada;
        end else begin
          bits[7:0] <= entrada;
        end
      end else begin
        bits[7:0] <= entrada;
        internoS <= 0;
      end
    end
  end




endmodule
