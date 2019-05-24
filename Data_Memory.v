`timescale 1ns / 1ns
module DATA_MEMORY(clk, rst, Address, Write_Data, Mem_Write, Mem_Read, Read_Data);
    input [31:0] Address, Write_Data;
    input Mem_Read, Mem_Write, clk, rst;
    output [31:0] Read_Data;
    integer i;

    reg [31:0] ROM[0:199]; //reg [wordsize:0] array_name [0:arraysize]

    initial begin // initialize
        for (i = 0; i < 199; i=i+1)
            ROM[i] <= 32'b0;
    end
    always @ (posedge clk, posedge rst) begin // sequential
        if (rst) begin
            for (i = 0; i < 199; i=i+1)
                ROM[i] <= 32'b0;
        end
        else if (Mem_Write) begin
            ROM[Address] <= Write_Data;
        end
    end

    assign Read_Data = Mem_Read? ROM[Address] : 32'd0; // combinational

endmodule

/*
module TBDM ();
    reg clk = 0, rst = 0, MemR = 0, MemW = 0;
    reg [31:0] Address, WD;
    wire [31:0] RD;
    always #200 clk = ~clk;
    DATA_MEMORY ut(clk, rst, Address, WD, MemW, MemR, RD);
    initial begin
        rst = 1;
        #400;
        rst = 0;
        #400;
        MemW = 1;
        Address = 2;
        WD = 100;
        #400;
        Address = 3;
        WD = 200;
        #400;
        MemW = 0;
        #400;
        MemR = 1;
        #400;
        Address = 2;
        #400;
        MemR = 0;
        #100000000;
        $stop;
    end
endmodule // TBDM
*/
