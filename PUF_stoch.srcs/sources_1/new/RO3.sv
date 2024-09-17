// Oscillator module
// Based on: https://ieeexplore.ieee.org/document/7195665 and https://github.com/stnolting/neoTRNG?tab=readme-ov-file

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO3(
    output [2:0] parallel_out
);
    
    // Internal wires
    (* keep = "true" *) wire not1, not2, not3;

    // Create NOT gates
    assign not1 = ~not3;
    assign not2 = ~not1;
    assign not3 = ~not2;

    // Output
    assign parallel_out = {not1, not2, not3};


endmodule