
module PUF_LFSR_comp_impl(
    input sys_clk
    );

    wire clk;
    assign clk = sys_clk;
    wire enable;

    // wires
    wire [7:0] prob_puf_sng;
    wire [15:0] prob_lfsr_sng;

    wire stoch_num_lfsr;
    wire stoch_num_puf;

    // dut
    PUF_LFSR_comp_synth dut(
        .clk            (clk),
        .reset          (reset),
        .enable         (enable),
        .prob_puf_sng   (prob_puf_sng),
        .prob_lfsr_sng  (prob_lfsr_sng),

        .stoch_num_puf  (stoch_num_puf),
        .stoch_num_lfsr (stoch_num_lfsr)
    );

    vio_0 vio(
        .clk            (clk),
        .probe_out0     (reset),
        .probe_out1     (enable),
        .probe_out2     (prob_puf_sng),
        .probe_out3     (prob_lfsr_sng)
    );

    ila_0 ila(
    .clk                (clk),
    .probe0             (reset),
    .probe1             (stoch_num_lfsr),
    .probe2             (stoch_num_puf)
    );


endmodule
