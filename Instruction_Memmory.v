`timescale 1ns / 1ns
module INSTRUCTION_MEMORY(PC, Instruction);
    input [31:0] PC;
    wire [31:0] Address = PC;
    output [31:0] Instruction;

    reg [31:0] ROM[0:2499]; //reg [wordsize:0] array_name [0:arraysize]
    initial begin
        $readmemb("Instructions.mem", ROM);
    end
    assign Instruction = {ROM[Address], ROM[Address + 32'd1], ROM[Address + 32'd2], ROM[Address + 32'd3]};
endmodule
