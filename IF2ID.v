`timescale 1ns / 1ns

module IF2ID(clk, rst, PCPlus4In, InstructionIn, PCPlus4, Instruction, Flush, Write);
    output [31:0] PCPlus4, Instruction;
    input clk, rst, Flush, Write;
    input [31:0] PCPlus4In, InstructionIn;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            PcPlus4 <= 0;
            Instruction <= 0;
        end
        else begin
            if (Write) begin


                if (Flush) begin
                    PCPlus4 <= 0;
                    Instruction <= 0;
                end
                else begin
                    PCPlus4 <= PCPlus4In;
                    Instruction <= InstructionIn;
                end
            end
        end
    end
endmodule
