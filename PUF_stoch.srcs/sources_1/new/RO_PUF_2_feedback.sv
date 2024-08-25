// RO RNG PUF with 3 ROs and XOR gate, outputs 8-bits every clk cycle

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module RO_PUF_2_feedback(
    input clk,
    input reset,
    input enable,
    output [7:0] rand_num
    );

    // Internal wires
    wire [4:0] par_out5;
    wire [6:0] par_out7;

    wire [7:0] xor_out;
    

    // Ring oscillators 5
    RO5 ro1(
        .en                 (enable),
        .parallel_out       (par_out5)
    );

    // Ring oscillators 7
    RO7_xor_feedback ro2(
        .en                 (enable),
        .xor_2              (par_out5[4]),
        .parallel_out       (par_out7)
    );

    // XOR outputs together random combinations
    assign xor_out[0] = par_out5[0] ^ par_out7[1];
    assign xor_out[1] = par_out5[3] ^ par_out7[2];
    assign xor_out[2] = par_out5[4] ^ par_out7[6];
    assign xor_out[3] = par_out5[2] ^ par_out7[5];
    assign xor_out[4] = par_out5[1] ^ par_out7[4];
    assign xor_out[5] = par_out5[3] ^ par_out7[6];
    assign xor_out[6] = par_out5[4] ^ par_out7[5];
    assign xor_out[7] = par_out5[1] ^ par_out7[3];

    // Store in 8 regs;
    reg [7:0] num;
    always @(posedge clk) begin
        num <= xor_out;
    end

    assign rand_num = num;

endmodule
