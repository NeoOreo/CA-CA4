`timescale 1ns / 1ns
module ALUCU(ALU_Op, func, ALU_Control);

    output [2:0] ALU_Control;
    input [1:0] ALU_Op;
    input [5:0] func;
    assign ALU_Control = (ALU_Op[1] == 1'b1 && func[3:0] == 4'b0000) ? 3'b010:
                         (ALU_Op[1] == 1'b1 && func[3:0] == 4'b0010) ? 3'b110:
                         (ALU_Op[1] == 1'b1 && func[3:0] == 4'b0100) ? 3'b000:
                         (ALU_Op[1] == 1'b1 && func[3:0] == 4'b0101) ? 3'b001:
                         (ALU_Op[1] == 1'b1 && func[3:0] == 4'b1010) ? 3'b111:
                         (ALU_Op == 2'b0) ? 3'b010:
                         (ALU_Op[0] == 1'b1) ? 3'b110 : 3'b000;





endmodule //
