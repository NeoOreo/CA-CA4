`timescale 1ns / 1ns
module SignExtend(in, SignExtended);
    output [31:0] SignExtended;
    input [15:0] in;
    assign SignExtended = (in[15] == 1'b0) ? {16'b0, in} : {16'b1111111111111111, in};
endmodule // SignExtend
