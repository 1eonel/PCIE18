module deMux(

input [7:0] data,
input enb,
output [3:0] S,
output [7:0] outmux
);

reg outmux;
reg S;
reg salidaX;

parameter COM = 8'hBC,PAD = 8'hF7,SKP = 8'h1C,STP = 8'hFB, SDP = 8'h5C ;
parameter END = 8'hFD,EDB = 8'hFE,FTS = 8'h3C,IDL = 8'h7C;

always @ (*)
  begin
    if (enb) begin
      if (data == COM) begin
        S = 4'b0001;
        outmux = salidaX;
      end else if (data == PAD) begin
        S = 4'b0010;
        outmux = salidaX;
      end else if (data == SKP) begin
        S = 4'b0011;
        outmux = salidaX;
      end else if (data == STP) begin
        S = 4'b0100;
        outmux = salidaX;
      end else if (data == SDP) begin
        S = 4'b0101;
        outmux = salidaX;
      end else if (data == END) begin
        S = 4'b0110;
        outmux = salidaX;
      end else if (data == EDB) begin
        S = 4'b0111;
        outmux = salidaX;
      end else if (data == FTS) begin
        S = 4'b1000;
        outmux = salidaX;
      end else if (data == IDL) begin
        S = 4'b1001;
        outmux = salidaX;
      end else begin
        S = 4'b0000;
        outmux = data;
      end
    end
  end
  endmodule
