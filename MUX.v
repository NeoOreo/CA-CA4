`timescale 1ns / 1ns
module MUX(A, B, Sel, Out);
     parameter DATA_WIDTH;
     input [DATA_WIDTH-1:0] A, B;
     input Sel;
     output [DATA_WIDTH-1:0] Out;


     assign Out = (Sel == 1) ? A : B;
 endmodule
