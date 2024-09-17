
module LFSR_rand_bytes_test(
    input sys_clk
    );

    localparam NUM_TESTS = 200;

    // wires
    wire reset;
    wire clk;
    assign clk = sys_clk;

    reg [7:0] seeds [0:24] = '{25, 100, 223, 237, 78, 172, 216, 206, 132, 220, 105, 242, 209, 151, 135, 28, 36, 169, 113, 4, 17, 132, 51, 108, 105};

    ////////////// LFSR/////////////////
    // stoch wires
    wire [7:0] rand_bytes [0:24];

    // RO_SNG 1
    /*
    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            LFSR8_Galois lfsr(
                .clk                    (clk),
                .reset                  (reset),
                .seed                   (seeds[i]),
                .parallel_out           (rand_bytes[i])
            );
        end
    endgenerate
    */

    // RO_PUF_4
    /*
    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            RO_PUF_4_top PUF(
                .clk                    (clk),
                .rand_num               (rand_bytes[i])
            );
        end
    endgenerate
    */

    // PUF_2
    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            RO_PUF_2_feedback PUF(
                .clk                    (clk),
                .rand_num               (rand_bytes[i])
            );
        end
    endgenerate

    wire [7:0] none;
    vio_1 vio_lfsr(
        .clk                (clk),
        .probe_out0         (reset),
        .probe_out1         (none)
    );

    // ILA
    ila_6 ila_randyte(
        .clk                (clk),
        .probe0             (rand_bytes[0]),
        .probe1             (rand_bytes[1]),
        .probe2             (rand_bytes[2]),
        .probe3             (rand_bytes[3]),
        .probe4             (rand_bytes[4]),
        .probe5             (rand_bytes[5]),
        .probe6             (rand_bytes[6]),
        .probe7             (rand_bytes[7]),
        .probe8             (rand_bytes[8]),
        .probe9             (rand_bytes[9]),
        .probe10             (rand_bytes[10]),
        .probe11             (rand_bytes[11]),
        .probe12             (rand_bytes[12]),
        .probe13             (rand_bytes[13]),
        .probe14             (rand_bytes[14]),
        .probe15             (rand_bytes[15]),
        .probe16             (rand_bytes[16]),
        .probe17             (rand_bytes[17]),
        .probe18             (rand_bytes[18]),
        .probe19             (rand_bytes[19]),
        .probe20             (rand_bytes[20]),
        .probe21             (rand_bytes[21]),
        .probe22             (rand_bytes[22]),
        .probe23             (rand_bytes[23]),
        .probe24             (rand_bytes[24])
    );

endmodule
