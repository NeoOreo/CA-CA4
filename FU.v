module FU (RsID2EX, RtID2EX, WriteRegisterEX2MEM, WriteRegisterMEM2WB, RegWriteEX2MEM, RegWriteMEM2WB, ForwardA, ForwardB);
    input  RegWriteEX2MEM, RegWriteMEM2WB;
    input [4:0] WriteRegisterEX2MEM, WriteRegisterMEM2WB,RsID2EX, RtID2EX;
    output reg [1:0] ForwardA, ForwardB;
    always @ ( * ) begin
        {ForwardA, ForwardB} = 0;
        if (WriteRegisterEX2MEM && (RsID2EX == WriteRegisterEX2MEM) && WriteRegisterEX2MEM != 0) begin
            ForwardA = 2'd2;
        end
        else if (WriteRegisterMEM2WB && (RsID2EX == WriteRegisterMEM2WB) && WriteRegisterMEM2WB != 0) begin
            ForwardA = 2'd1;
        end
        if (WriteRegisterEX2MEM && (RtID2EX == WriteRegisterEX2MEM) && WriteRegisterEX2MEM != 0) begin
            ForwardB = 2'd2;
        end
        else if (WriteRegisterMEM2WB && (RtID2EX == WriteRegisterMEM2WB) && WriteRegisterMEM2WB != 0) begin
            ForwardB = 2'd1;
        end
    end
endmodule // FU
