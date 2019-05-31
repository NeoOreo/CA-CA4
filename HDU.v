module HDU (Rs, Rt, RtID2EX, MemReadID2EX, Write, NoOp);
    output Write, NoOp;
    input MemReadID2EX;
    input [4:0] Rs, Rt, RtID2EX;

    assign Write = (MemReadID2EX == 1 && ((Rs == RtID2EX && Rs != 0) || (Rt == RtID2EX && Rt != 0))) ? 0 : 1;
    assign NoOp = (MemReadID2EX == 1 && ((Rs == RtID2EX && Rs != 0) || (Rt == RtID2EX && Rt != 0))) ? 1 : 0;

    // LW va Rtype 1 stall
    // Lw va Branch 1 stall
    // Rtype va Branch 1 stall
endmodule // HDU
