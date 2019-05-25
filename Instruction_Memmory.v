`timescale 1ns / 1ns
module INSTRUCTION_MEMORY(PC, Instruction);
    input [31:0] PC;

    output [31:0] Instruction;
    reg [7:0] ROM[0:2499]; //reg [wordsize:0] array_name [0:arraysize]
    initial begin
        $readmemb("Instructions.mem", ROM);
    end
    assign Instruction = {ROM[PC], ROM[PC + 32'd1], ROM[PC + 32'd2], ROM[PC + 32'd3]};
endmodule
