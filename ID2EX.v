`timescale 1ns / 1ns

module ID2EX(clk, rst, PCPlus4In, ReadDataRF0In, ReadDataRF1In, RtIn, RsIn, RdIn, SignExtendedIn, JumpAddressIn, RegWriteIn, MemReadIn, MemWriteIn, ALUControlIn, MemToRegIn, PCSrcIn, RegDstIn, ALUSrcIn,
                       PCPlus4,   ReadDataRF0,   ReadDataRF1,   Rt,   Rs,   Rd,   SignExtended,   JumpAddress,   RegWrite,   MemRead,   MemWrite,   ALUControl,   MemToReg,   PCSrc,   RegDst,   ALUSrc);

    input clk, rst,
          RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn, RegDstIn, ALUSrcIn;
    input [31:0] PCPlus4In, ReadDataRF0In, ReadDataRF1In, SignExtendedIn;
    input [4:0]  RtIn, RsIn, RdIn;
    input [2:0]  ALUControlIn;
    input [1:0] PCSrcIn;
    input [25:0] JumpAddressIn;

    output reg  [25:0] JumpAddress;
    output reg RegWrite, MemRead, MemWrite, MemToReg, RegDst, ALUSrc;
    output reg  [31:0] PCPlus4, ReadDataRF0, ReadDataRF1, SignExtended;
    output reg  [4:0]  Rt, Rs, Rd;
    output reg  [2:0] ALUControl;
    output reg  [1:0] PCSrc;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {JumpAddress, RegWrite, MemRead, MemWrite, ALUControl, MemToReg, PCPlus4, ReadDataRF0, ReadDataRF1, SignExtended, Rt, Rs, Rd, PCSrc, RegDst, ALUSrc} = 0;
        end
        else begin
            JumpAddress <= JumpAddressIn;
            RegWrite <= RegWriteIn;
            MemRead <= MemReadIn;
            MemWrite <= MemWriteIn;
            MemToReg <= MemToRegIn;
            PCSrc <= PCSrcIn;
            RegDst <= RegDstIn;
            PCPlus4 <= PCPlus4In;
            ReadDataRF0 <= ReadDataRF0In;
            ReadDataRF1 <= ReadDataRF1In;
            SignExtended <= SignExtendedIn;
            Rt <= RtIn;
            Rs <= RsIn;
            Rd <= RdIn;
            ALUControl <= ALUControlIn;
            ALUSrc <= ALUSrcIn;
        end
    end
endmodule
