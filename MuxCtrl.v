module MuxCtrl(

input [7:0] data,
//falta ver que tan necesaria sería la entrada ctrl
//es casi seguro que no se necesita+
//input [7:0] ctrl,
input [3:0] S,
output[7:0] outmux
//falta enb??

);

reg outmux;

parameter COM = 8'hBC,PAD = 8'hF7,SKP = 8'h1C,STP = 8'hFB, SDP = 8'h5C ;
parameter END = 8'hFD,EDB = 8'hFE,FTS = 8'h3C,IDL = 8'h7C;

always @ (*)
  begin
    case(S)
      4'b0000 : outmux = data;

      4'b0001 : outmux = COM;

      4'b0010 : outmux = PAD;

      4'b0011 : outmux = SKP;

      4'b0100 : outmux = STP;

      4'b0101 : outmux = SDP;

      4'b0110 : outmux = END;

      4'b0111 : outmux = EDB;

      4'b1000 : outmux = FTS;

      4'b1001 : outmux = IDL;
    endcase
  end
  endmodule
