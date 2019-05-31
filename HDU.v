module HDU (Rs, Rt, RtID2EX, MemReadID2EX, Write, NoOp);
    output reg Write, NoOp;
    input MemReadID2EX;
    input [4:0] Rs, Rt, RtID2EX;
    always @ ( * ) begin
        NoOp <= 0;
        Write <= 1;
        if ((Rs == RtID2EX && Rs != 0) || (Rt == RtID2EX && Rt != 0)) begin
            Write <= 0;
            NoOp <= 1;
        end
    end
    // LW va Rtype 1 stall
    // Lw va Branch 1 stall
    // Rtype va Branch 1 stall
endmodule // HDU
