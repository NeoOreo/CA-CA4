`timescale 1ns / 1ns
module DP(clk, rst);
    input clk, rst;
    wire [31:0] PCOut, PCIn, SignExtendedInstruction, Instruction, WriteDataRF, ReadDataRF0, ReadDataRF1, B, ALUResult, ReadDataDM;
    wire [2:0] PCSrc, ALUControl;
    wire [4:0] ReadRegister0, ReadRegister1, WriteRegister;
    wire [1:0] ALUOp;
    wire ldPC, RegDst, RegWrite, ALUSrc, Zero, MemWrite, MemRead, Branch, Jump, MemToReg;

    PCMUX #(.DATA_WIDTH(32)) PCMux({PCOut[31:28] + 4'd4, Instruction[25:0], 2'b00}, (SignExtendedInstruction << 2) + PCOut + 32'd4, PCOut + 32'd4, PCSrc, PCIn);
    REGISTER #(.DATA_WIDTH(32)) PC(clk, rst, ldPC, PCIn, PCOut);
    INSTRUCTION_MEMORY IM(PCOut, Instruction);
    SignExtend Extend(Instruction[15:0], SignExtendedInstruction);
    MUX #(.DATA_WIDTH(32)) RegDstMux(Instruction[15:11], Instruction[20:16], RegDst, WriteRegister);
    REGISTER_FILE RF(clk, rst, ReadRegister0, ReadRegister1, WriteRegister, WriteDataRF, RegWrite, ReadDataRF0, ReadDataRF1);

    MUX #(.DATA_WIDTH(32)) ALUSrcMux(SignExtendedInstruction, ReadDataRF1, ALUSrc, B);
    ALU Alu(ReadDataRF0, B, ALUControl, ALUResult, Zero);
    DATA_MEMORY DM(clk, rst, ALUResult, ReadDataRF1, MemWrite, MemRead, ReadDataDM);
    MUX #(.DATA_WIDTH(32)) MemToRegMux(ReadDataDM, ALUResult, MemToReg, WriteDataRF);
    assign PCSrc = (Zero & Branch) ? 2'd1 :
                   (Jump) ? 2'd2 : 2'd0;
    CU cu(Instruction[31:26], RegDst, Branch, MemRead, MemWrite, MemToReg, Jump, ALUSrc, ALUOp, RegWrite);
    
    ALUCU Alucu(ALUOp, Instruction[7:0], ALUControl);

endmodule


module TBDP ();
    reg clk = 0, rst = 0;
    always #200 clk = ~clk;
    initial begin


        #1000000;
        $stop;
    end
endmodule // TBDP
