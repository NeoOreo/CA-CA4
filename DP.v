`timescale 1ns / 1ns
module DP(clk, rst);
    input clk, rst;
    wire signed [31:0] PCOut, PCIn, PCPlus4, PCPlus4ID2EX, PCPlus4IF2ID, SignExtendedID2EX, SignExtendedIn;
    wire [31:0] A, BIn, InstructionIn, InstructionIF2ID, WriteDataRF, ReadDataRF0In, ReadDataRF1In, B, BEX2MEM, ALUResultIn, ReadDataRF0ID2EX, ReadDataRF1ID2EX, ALUResultEX2MEM, ReadDataRF1EX2MEM, ReadDataDMIn, ALUResultMEM2WB, ReadDataDMMEM2WB;
    wire [25:0] JumpAddressID2EX;
    wire [2:0]  ALUControlIn, ALUControlID2EX;
    wire [1:0] PCSrcIn, PCSrcID2EX, ForwardA, ForwardB, ALUOp;
    wire [4:0] RtID2EX, RsID2EX, RdID2EX, WriteRegisterIn, WriteRegisterMEM2WB, WriteRegisterEX2MEM, RtEX2MEM;
    wire Flush, Write, RegDstIn, RegWriteIn, ALUSrcIn, Zero, MemWriteIn, MemReadIn, Branch, Jump, MemToRegIn, NoOp, BranchN, RegWriteMEM2WB, RegWriteID2EX, MemReadID2EX, MemWriteID2EX, MemToRegID2EX, RegDstID2EX, ALUSrcID2EX, MemWriteEX2MEM, MemReadEX2MEM, MemToRegEX2MEM, RegWriteEX2MEM, MemToRegMEM2WB;
    assign PCPlus4 = PCOut + 32'd4;
    assign Flush = (PCSrcIn == 2'd2 || PCSrcIn == 2'd3) ? 1 : 0;

    PCMUX #(.DATA_WIDTH(32)) PCMux({PCPlus4IF2ID[31:28], InstructionIF2ID[25:0], 2'b00}, (SignExtendedIn << 2) + PCPlus4IF2ID, PCPlus4, PCSrcIn, PCIn);
    REGISTER #(.DATA_WIDTH(32)) PC(clk, rst, Write & (~rst), PCIn, PCOut);
    INSTRUCTION_MEMORY IM(PCOut, InstructionIn);
    IF2ID RegIF2ID(clk, rst, PCPlus4, InstructionIn, PCPlus4IF2ID, InstructionIF2ID, Flush, Write);
    //###############

    SignExtend Extend(InstructionIF2ID[15:0], SignExtendedIn);
    CU cu(rst, InstructionIF2ID[31:26], RegDstIn, Branch, MemReadIn, MemWriteIn, MemToRegIn, Jump, ALUSrcIn, ALUOp, RegWriteIn, BranchN, NoOp);
    ALUCU Alucu(ALUOp, InstructionIF2ID[5:0], ALUControlIn);
    REGISTER_FILE RF(clk, rst, InstructionIF2ID[25:21], InstructionIF2ID[20:16], WriteRegisterMEM2WB, WriteDataRF, RegWriteMEM2WB, ReadDataRF0In, ReadDataRF1In);
    assign Zero = (ReadDataRF0In == ReadDataRF1In) ? 1 : 0;
    assign PCSrcIn = ((Zero & Branch) || (~Zero & BranchN)) ? 2'd2 :
                     (Jump) ? 2'd3 :
                     (rst)  ? 2'd0 : 2'd1;
    HDU hd(InstructionIF2ID[25:21], InstructionIF2ID[20:16], RtID2EX, MemReadID2EX, Write, NoOp);
    ID2EX RegID2EX(clk, rst, PCPlus4IF2ID, ReadDataRF0In,    ReadDataRF1In,    InstructionIF2ID[20:16], InstructionIF2ID[25:21], InstructionIF2ID[15:11], SignExtendedIn,    InstructionIF2ID[25:0], RegWriteIn,    MemReadIn,    MemWriteIn,    ALUControlIn,    MemToRegIn,    PCSrcIn,    RegDstIn,    ALUSrcIn,
                             PCPlus4ID2EX, ReadDataRF0ID2EX, ReadDataRF1ID2EX, RtID2EX,                 RsID2EX,                 RdID2EX,                 SignExtendedID2EX, JumpAddressID2EX,       RegWriteID2EX, MemReadID2EX, MemWriteID2EX, ALUControlID2EX, MemToRegID2EX, PCSrcID2EX, RegDstID2EX, ALUSrcID2EX);
    //#################
    FU fu(RsID2EX, RtID2EX, WriteRegisterEX2MEM, WriteRegisterMEM2WB, RegWriteEX2MEM, RegWriteMEM2WB, ForwardA, ForwardB);
    FUMUX #(.DATA_WIDTH(32)) FUMuxA(ALUResultEX2MEM, WriteDataRF, ReadDataRF0ID2EX, ForwardA, A);
    FUMUX #(.DATA_WIDTH(32)) FUMuxB(ALUResultEX2MEM, WriteDataRF, ReadDataRF1ID2EX, ForwardB, B);
    MUX #(.DATA_WIDTH(32)) ALUSrcMuxB(SignExtendedID2EX, B, ALUSrcID2EX, BIn);
    ALU Alu(A, BIn, ALUControlID2EX, ALUResultIn);
    MUX #(.DATA_WIDTH(32)) RegDstMux(RdID2EX, RtID2EX, RegDstID2EX, WriteRegisterIn);
    EX2MEM RegEX2MEM(clk, rst, ALUResultIn,     WriteRegisterIn,     B,       RegWriteID2EX,  MemReadID2EX,  MemWriteID2EX,  MemToRegID2EX, RtID2EX,
                               ALUResultEX2MEM, WriteRegisterEX2MEM, BEX2MEM, RegWriteEX2MEM, MemReadEX2MEM, MemWriteEX2MEM, MemToRegEX2MEM, RtEX2MEM);
    //#################
    DATA_MEMORY DM(clk, rst,   ALUResultEX2MEM, BEX2MEM, MemWriteEX2MEM, MemReadEX2MEM, ReadDataDMIn);
    MEM2WB RegMEM2WB(clk, rst, ALUResultEX2MEM, ReadDataDMIn,     MemToRegEX2MEM, RegWriteEX2MEM, WriteRegisterEX2MEM,
                               ALUResultMEM2WB, ReadDataDMMEM2WB, MemToRegMEM2WB, RegWriteMEM2WB, WriteRegisterMEM2WB);
    //#################
    MUX #(.DATA_WIDTH(32)) MemToRegMux(ReadDataDMMEM2WB, ALUResultMEM2WB, MemToRegMEM2WB, WriteDataRF);
endmodule


module TBDP ();
    reg clk = 0, rst = 1;
    always #1 clk = ~clk;
    DP ut(clk, rst);
    initial begin
        #1;
        rst = 0;
        #1000;
        $stop;
    end
endmodule // TBDP
