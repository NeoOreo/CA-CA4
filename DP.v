`timescale 1ns / 1ns
module DP(clk, rst);
    input clk, rst;
    wire signed [31:0] PCOut, PCIn, PcPlus4;
    wire signed [31:0] SignExtended;
    wire [31:0] Instruction, WriteDataRF, ReadDataRF0, ReadDataRF1, B, ALUResult, ReadDataDM;
    wire [2:0] PCSrc, ALUControl;
    wire [4:0] ReadRegister0, ReadRegister1, WriteRegister;
    wire [1:0] ALUOp;
    wire ldPC, RegDst, RegWrite, ALUSrc, Zero, MemWrite, MemRead, Branch, Jump, MemToReg, NoOp, BranchN;
    assign PcPlus4 = PCOut + 32'd4;
    PCMUX #(.DATA_WIDTH(32)) PCMux({PcPlus4[31:28], Instruction[25:0], 2'b00}, (SignExtended << 2) + PcPlus4, PcPlus4, PCSrc, PCIn);
    REGISTER #(.DATA_WIDTH(32)) PC(clk, rst, ldPC, PCIn, PCOut);
    INSTRUCTION_MEMORY IM(PCOut, Instruction);
    SignExtend Extend(Instruction[15:0], SignExtended);
    MUX #(.DATA_WIDTH(32)) RegDstMux(Instruction[15:11], Instruction[20:16], RegDst, WriteRegister);
    REGISTER_FILE RF(clk, rst, Instruction[25:21], Instruction[20:16], WriteRegister, WriteDataRF, RegWrite, ReadDataRF0, ReadDataRF1);

    MUX #(.DATA_WIDTH(32)) ALUSrcMux(SignExtended, ReadDataRF1, ALUSrc, B);
    ALU Alu(ReadDataRF0, B, ALUControl, ALUResult, Zero);
    DATA_MEMORY DM(clk, rst, ALUResult, ReadDataRF1, MemWrite, MemRead, ReadDataDM);
    MUX #(.DATA_WIDTH(32)) MemToRegMux(ReadDataDM, ALUResult, MemToReg, WriteDataRF);
    assign PCSrc = ( (Zero & Branch) || (~Zero & BranchN) ) ? 2'd2 :
                   (Jump) ? 2'd3 :
                   (rst)  ? 2'd0 : 2'd1;

    assign NoOp = (Instruction == 32'b0) ? 1 : 0;
    CU cu(rst, Instruction[31:26], RegDst, Branch, MemRead, MemWrite, MemToReg, Jump, ALUSrc, ALUOp, RegWrite, NoOp, ldPC, BranchN);

    ALUCU Alucu(ALUOp, Instruction[7:0], ALUControl);

endmodule


module TBDP ();
    reg clk = 0, rst = 1;
    always #200 clk = ~clk;
    DP ut(clk, rst);
    initial begin
        #220;
        rst = 0;


        #1000000;
        $stop;
    end
endmodule // TBDP
