// Oscillator module
// Based on: https://ieeexplore.ieee.org/document/7195665 and https://github.com/stnolting/neoTRNG?tab=readme-ov-file

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO7_xor_feedback(
    input xor_2,
    output [6:0] parallel_out
);
    
    // Internal wires
    (* keep = "true" *) wire not1, not2, not3, not4, not5, not6, not7;

    // Create NOT gates
    assign not1 = ~(not7 ^ xor_2);
    assign not2 = ~not1;
    assign not3 = ~not2;
    assign not4 = ~not3;
    assign not5 = ~not4;
    assign not6 = ~not5;
    assign not7 = ~not6;

    // Output
    assign parallel_out = {not1, not2, not3, not4, not5, not6, not7};


endmodule