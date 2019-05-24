`timescale 1ns / 1ns
module ALU(A, B , ALU_Control, ALU_Result);
     input signed [31:0] A, B;
     input [2:0] ALU_Control;
     output reg  [31:0] ALU_Result;
     
     always @(*) begin
        case(ALU_Control)
            3'd0: ALU_Result = A & B;
            3'd1: ALU_Result = A | B;
            3'd2: ALU_Result = A + B;
            3'd6: ALU_Result = A - B;
            3'd7: ALU_Result = A < B;
            default:ALU_Result = A + B;
        endcase
     end
     //assign zero = (ALU_Result==32'b0000000000000000) ? 1'b1: 1'b0;
 endmodule
