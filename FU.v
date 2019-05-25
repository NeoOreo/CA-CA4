module FU (RsID2EX, RtID2EX, WriteRegisterEX2MEM, WriteRegisterMEM2WB, RegWriteEX2MEM, RegWriteMEM2WB, ForwardA, ForwardB);
    input WriteRegisterEX2MEM, WriteRegisterMEM2WB, RegWriteEX2MEM, RegWriteMEM2WB;
    input [4:0] RsID2EX, RtID2EX;
    output reg ForwardA, ForwardB;
    always @ ( * ) begin
        {ForwardA, ForwardB} = 0;
        if (WriteRegisterEX2MEM && (RsID2EX == WriteRegisterEX2MEM) && WriteRegisterEX2MEM != 0) begin
            ForwardA = 2'd1;
        end
        else if (WriteRegisterEX2MEM && (RsID2EX == WriteRegisterMEM2WB) && WriteRegisterMEM2WB != 0) begin
            ForwardA = 2'd2;
        end
        if (WriteRegisterEX2MEM && (RtID2EX == WriteRegisterEX2MEM) && WriteRegisterEX2MEM != 0) begin
            ForwardB = 2'd1;
        end
        else if (WriteRegisterEX2MEM && (RtID2EX == WriteRegisterMEM2WB) && WriteRegisterMEM2WB != 0) begin
            ForwardB = 2'd2;
        end
    end
endmodule // FU
