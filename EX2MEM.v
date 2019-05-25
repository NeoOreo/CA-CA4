`timescale 1ns / 1ns

module EX2MEM(clk, rst, ALUResultIn, WriteRegisterIn, ReadDataRF1In, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn,
                        ALUResult,   WriteRegister,   ReadDataRF1,   RegWrite,   MemRead,   MemWrite,   MemToReg);

    input clk, rst, RegWriteIn, MemReadIn, MemWriteIn, MemToRegIn, NoOpIn;
    input [31:0] ALUResultIn;
    input [4:0]  WriteRegisterIn;

    output reg RegWrite, MemRead, MemWrite, MemToReg;
    output reg [31:0] ALUResult;
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



            ALUResult <= ALUResultIn;

            WriteRegister <= WriteRegisterIn;

        end
    end
endmodule
