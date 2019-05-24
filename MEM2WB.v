`timescale 1ns / 1ns

module MEM2WB(clk, rst, ALUResultIn,  ReadDataDMIn, MemToRegIn, RegWriteIn, WriteRegisterIn,
                        ALUResult,    ReadDataDM,   MemToReg,   RegWrite,   WriteRegister);

    input clk, rst, MemToRegIn, RegWriteIn;
    input [31:0] ALUResultIn, ReadDataDMIn;
    input [4:0]  WriteRegisterIn;

    output [31:0] ALUResult, ReadDataDM;
    output [4:0]  WriteRegister;
    output MemToReg, RegWrite;

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            {ALUResult, ReadDataDM, WriteRegister, MemToReg, RegWrite} = 0;
        end
        else begin
            ALUResult <= ALUResultin;
            
            ReadDataDM <= ReadDataDMIn;
            WriteRegister <= WriteRegisterIn;

            MemToReg <= MemToRegIn;
            RegWrite <= RegWriteIn;
        end
    end
endmodule
