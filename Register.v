`timescale 1ns / 1ns
module REGISTER(clk, rst, ld, data, out);
    parameter DATA_WIDTH = 2;
    reg [DATA_WIDTH - 1: 0] temp;
    output [DATA_WIDTH - 1: 0] out;
    input [DATA_WIDTH - 1: 0] data;
    input clk, rst, ld;
    initial begin
        temp = 0;
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            temp <= 0;
        end
        else if (ld) temp <= data;
        else temp <= temp;
    end

    assign out = temp;
endmodule // Register
