`timescale 1ns/1ps

module striping (clk, fromMux, TL0, TL1, TL2,TL3);
input clk;
input [7:0] fromMux;

output [7:0] TL0;
output [7:0] TL1;
output [7:0] TL2;
output [7:0] TL3;

reg [7:0] TL0;
reg [7:0] TL1;
reg [7:0] TL2;
reg [7:0] TL3;

reg [1:0] c; //Contador para ver que lane se debe usar

reg D; // D=0 => no estamos transmitiendo datos || D=1 => estamos transmitiendo datos


parameter COM = 8'hBC,PAD = 8'hF7,SKP = 8'h1C,STP = 8'hFB, SDP = 8'h5C ;
parameter END = 8'hFD,EDB = 8'hFE,FTS = 8'h3C,IDL = 8'h7C;

//D <= 1'b0; 

always @ (posedge clk) begin
      if (D) begin
            if (fromMux == END) begin
            TL3 = fromMux;
            D=0;
            c = 2'b00;
            end else begin
                  if (c==2'b00) begin
                        TL0 = fromMux;
                        c = c+1;
                  end else if (c==2'b01) begin
                        TL1 = fromMux;
                        c = c+1;
                        
                  end else if (c==2'b10) begin
                        TL2 = fromMux;
                        c = c+1;
                        
                  end else if (c==2'b11) begin
                        TL3 = fromMux;
                        c = c+1;
                        end  
            end //end else de            
      end else begin
      
            if (fromMux == STP) begin
            D=1;
            TL0 = fromMux;
            c = 2'b01;
            end  
            if (fromMux == SDP) begin
            D=1;
            TL0 = fromMux;
            c = c+1;
            end

            if (fromMux == IDL) begin
            c = 2'b00;
            TL0 = fromMux;
            TL1 = fromMux;
            TL2 = fromMux;
            TL3 = fromMux;
            end

            if (fromMux == COM) begin
            c = 2'b00;
            TL0 = fromMux;
            TL1 = fromMux;
            TL2 = fromMux;
            TL3 = fromMux;
            end


            if (fromMux == SKP) begin
            c = 2'b00;
            TL0 = fromMux;
            TL1 = fromMux;
            TL2 = fromMux;
            TL3 = fromMux;
            end
      end  //else de if (D)



end //always




      





      /*
      always @ ( * ) begin
      case(fromMux)
      STP : begin
            c = 1'b00; // contador == 00
            if(fromMux=END) begin
                  TL3 = fromMux;
                  end else begin
                  //ACOMODAR LOS BICHOS EN EL LANE CORRESPONDIENTE E INCREMENTAR EL CONTADOR
                  end
                  
            end

      SDP : TL0 = fromMux; //Start

      END : TL3 = fromMux;

      //EDB : TL3 = fromMux;

      SKP : begin
            TL0 = fromMux;
            TL1 = fromMux;
            TL2 = fromMux;
            TL3 = fromMux;
            end
      
      IDL : begin
            c = 1'b00;
            TL0 = fromMux;
            TL1 = fromMux;
            TL2 = fromMux;
            TL3 = fromMux;
            end
      


      end

      */

endmodule


      /*
      -value en 1, y selec de mux para que mande IDLE

      -Start-Datoooooos-End, Verificar multiplos de 4 bytes para que el END quede en el ultimo
      Mandar datos por multiplos de 4 bytes, contando Start y END



      */
