

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module PUF_LFSR_comp_synth(
    input clk,
    input reset,
    input enable,
    input [7:0] prob_puf_sng,
    input [15:0] prob_lfsr_sng,

    output stoch_num_puf,
    output stoch_num_lfsr
    );

    SNG_RO sng_puf(
        .clk                (clk),
        .reset              (reset),
        .enable             (enable),
        .prob               (prob_puf_sng),
        .stoch_num          (stoch_num_puf)
    );

    StochNumGen16 sng_lfsr(
        .clk                (clk),
        .reset              (reset),
        .seed               (16'd47384),
        .prob               (prob_lfsr_sng),
        .stoch_num          (stoch_num_lfsr)
    );


endmodule
