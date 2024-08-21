`timescale 1ns / 1ps

module PUF_lfsr_comp_tb();

    reg clk = 0;
    reg reset = 0;
    reg enable = 1;

    reg [15:0]  prob_lfsr = 16'd47368;
    reg [7:0]   prob_puf = 8'd362;

    wire stoch_num_lfsr;
    wire stoch_num_puf;

    // DUT
    PUF_LFSR_comp_synth dut(
        .clk                (clk),
        .reset              (reset),
        .enable             (enable),
        .prob_puf_sng       (prob_puf),
        .prob_lfsr_sng      (prob_lfsr),

        .stoch_num_lfsr     (stoch_num_lfsr),
        .stoch_num_puf      (stoch_num_puf)
    );

    initial begin
        reset = 1;
        #75;
        reset = 0;
    end

    always begin
        #25;
        clk = ~clk;
    end

endmodule
