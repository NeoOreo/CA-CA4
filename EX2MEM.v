`timescale 1ns / 1ns

module EX2MEM(clk, rst, ALUResultIn, WriteRegisterIn, ReadDataRF1In, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn,
                        ALUResult,   WriteRegister,   ReadDataRF1,   RegWrite,   MemRead,   MemWrite,   MemToReg);

    input clk, rst, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn;
    input [31:0] ALUResultIn, ReadDataRF1In;
    input [4:0]  WriteRegisterIn;

    output reg RegWrite, MemRead, MemWrite, MemToReg;
    output reg [31:0] ALUResult, ReadDataRF1;
    output reg [4:0]  WriteRegister;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {RegWrite, MemRead, MemWrite, MemToReg, ALUResult, WriteRegister} = 0;
        end
        else begin
            RegWrite <= RegWriteIn;
            MemRead <= MemReadIn;
            MemWrite <= MemWriteIn;
            MemToReg <= MemToRegIn;
            ReadDataRF1 <= ReadDataRF1In;


            ALUResult <= ALUResultIn;

            WriteRegister <= WriteRegisterIn;

        end
    end
endmodule
