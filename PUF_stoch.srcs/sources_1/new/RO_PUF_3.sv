// RO RNG PUF with 2 ROs, with no latches
// Trying to minimise area with this one

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO_PUF_3(
    input clk,
    output [7:0] rand_num
    );

    // Internal wires
    wire [4:0] par_out5;
    wire [2:0] par_out3;

    wire [7:0] xor_out;
    

    // Ring oscillators 5
    RO5 ro1(
        .parallel_out       (par_out5)
    );

    // Ring oscillators 3
    RO3 ro2(
        .parallel_out       (par_out3)
    );

    // XOR outputs together random combinations
    assign xor_out[0] = par_out5[0] ^ par_out3[1];
    assign xor_out[1] = par_out5[3] ^ par_out3[0];
    assign xor_out[2] = par_out5[4] ^ par_out3[0];
    assign xor_out[3] = par_out5[2] ^ par_out3[2];
    assign xor_out[4] = par_out5[1] ^ par_out3[1];
    assign xor_out[5] = par_out5[3] ^ par_out3[1];
    assign xor_out[6] = par_out5[4] ^ par_out3[2];
    assign xor_out[7] = par_out5[1] ^ par_out3[0];

    // Store in 8 regs;
    reg [7:0] num;
    always @(posedge clk) begin
        num <= xor_out;
    end

    assign rand_num = num;

endmodule
