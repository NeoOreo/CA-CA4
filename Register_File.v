`timescale 1ns / 1ns
module REGISTER_FILE(clk, rst, Read_Register0, Read_Register1, Write_Register, Write_Data, Reg_Write, Read_Data0, Read_Data1);
    input [4:0] Read_Register0, Read_Register1, Write_Register;
    input [31:0] Write_Data;
    input Reg_Write, clk, rst;
    output [31:0] Read_Data0, Read_Data1;
    integer i, j;
    reg [31:0] Registers[0:31]; //reg [wordsize:0] array_name [0:arraysize]
    initial begin
        Registers[1] = 32'd100;
        Registers[5] = 32'd200;
    end
    always @ (posedge clk, posedge rst)begin
      if(rst) begin
        //for (i = 0; i < 32; i = i + 1)
        //  Registers[i] <= 0;
      end
      else if(Reg_Write != 0 && Write_Register != 0)
        Registers[Write_Register] <= Write_Data;
      end


    assign Read_Data0 = (Registers[Read_Register0]);
    assign Read_Data1 = (Registers[Read_Register1]);
endmodule


module tb_regfile();
  reg clk = 0, rst,Reg_Write;
  reg [4:0] Read_Register0, Read_Register1, Write_Register;
  reg [31:0] Write_Data;
  wire [31:0]  Read_Data0, Read_Data1;
  always #200 clk = ~clk;
    REGISTER_FILE ut(clk, rst, Read_Register0, Read_Register1, Write_Register, Write_Data, Reg_Write, Read_Data0, Read_Data1);
    initial begin
    Reg_Write = 0;

        rst = 1;
        #100;
        rst = 0;
        Reg_Write = 1;
        #100;
        Write_Register = 5;
        Write_Data = 6;
        #450;
        Reg_Write =1;
        Write_Register = 6;
        Write_Data = 7;
        #450;
        Reg_Write = 0;
        Read_Register0 = 6;
        Read_Register1 = 5;


        #100000;

        $stop;

    end
endmodule
