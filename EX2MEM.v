`timescale 1ns / 1ns

module EX2MEM(clk, rst, ALUResultIn, WriteRegisterIn, ReadDataRF1In, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn, RtIn,
                        ALUResult,   WriteRegister,   ReadDataRF1,   RegWrite,   MemRead,   MemWrite,   MemToReg, Rt);

    input clk, rst, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn;
    input [31:0] ALUResultIn, ReadDataRF1In;
    input [4:0]  WriteRegisterIn, RtIn;

    output reg RegWrite, MemRead, MemWrite, MemToReg;
    output reg [31:0] ALUResult, ReadDataRF1;
    output reg [4:0]  WriteRegister, Rt;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {RegWrite, MemRead, MemWrite, MemToReg, ALUResult, WriteRegister, Rt} = 0;
        end
        else begin
            RegWrite <= RegWriteIn;
            MemRead <= MemReadIn;
            MemWrite <= MemWriteIn;
            MemToReg <= MemToRegIn;
            ReadDataRF1 <= ReadDataRF1In;
            Rt <= RtIn;

            ALUResult <= ALUResultIn;

            WriteRegister <= WriteRegisterIn;

        end
    end
endmodule
