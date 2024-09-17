// 8-bit Galois ring oscillator
// https://www.researchgate.net/figure/An-example-of-a-7-bit-LFSR_fig5_292130031

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO7_Fib(
    output [6:0] parallel_out
    );

    // Internal wires
    (* keep = "true" *) wire not1, not2, not3, not4, not5, not6, not7;

    // XOR gates
    (* keep = "true" *) wire xor1, xor2;
    assign xor1 = not5 ^ not7;
    assign xor2 = xor1 ^ not1;

    // Create NOT gates
    assign not1 = ~xor2;
    assign not2 = ~not1;
    assign not3 = ~(not2 ^ not6);
    assign not4 = ~(not3 ^ not6);
    assign not5 = ~(not4 ^ not6);
    assign not6 = ~not5;
    assign not7 = ~not6;

    // Output
    assign parallel_out = {not1, not2, not3, not4, not5, not6, not7};

endmodule
