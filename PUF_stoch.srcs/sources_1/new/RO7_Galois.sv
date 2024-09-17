// 8-bit Galois ring oscillator
// https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1683753

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO7_Galois(
    output [6:0] parallel_out
    );

    // Internal wires
    (* keep = "true" *) wire not1, not2, not3, not4, not5, not6, not7;

    // Create NOT gates
    assign not1 = ~not7;
    assign not2 = ~not1;
    assign not3 = ~(not2 ^ not7);
    assign not4 = ~(not3 ^ not7);
    assign not5 = ~(not4 ^ not7);
    assign not6 = ~not5;
    assign not7 = ~not6;

    // Output
    assign parallel_out = {not1, not2, not3, not4, not5, not6, not7};

endmodule
