

module SNG_corr_test(
    input sys_clk
    );

    localparam NUM_TESTS = 100;

    // wires
    wire reset;
    wire clk;
    assign clk = sys_clk;

    wire [7:0] stb_out [0:NUM_TESTS-1];

    // Inputs
    reg [7:0] num1_tests [0:NUM_TESTS-1] = '{124, 252, 25, 99, 238, 250, 61, 22, 31, 14, 97, 30, 111, 114, 4, 222, 155, 4, 172, 180, 152, 193, 155, 33, 139, 143, 188, 209, 202, 254, 220, 37, 43, 63, 158, 223, 132, 26, 107, 203, 201, 167, 234, 17, 213, 129, 81, 88, 81, 64, 17, 162, 72, 149, 230, 153, 250, 19, 179, 182, 11, 223, 45, 169, 42, 182, 252, 3, 212, 65, 175, 224, 43, 169, 133, 59, 59, 66, 111, 201, 53, 36, 7, 114, 94, 139, 117, 148, 208, 119, 50, 175, 178, 29, 17, 63, 247, 35, 207, 110};

    // stoch output bits
    wire [NUM_TESTS-1:0] num_stoch;

    /*
    // RO_SNG 1
    genvar i;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            SNG_RO ro_sng(
                .clk                (clk),
                .reset              (reset),
                .prob               (num1_tests[i]),
                .stoch_num          (num_stoch[i])
            );
        end
    endgenerate
    */

    // LFSR SNG
    reg [7:0] seeds [0:NUM_TESTS-1] = '{38, 179, 183, 25, 199, 96, 173, 72, 52, 79, 24, 223, 117, 63, 235, 89, 54, 17, 247, 241, 111, 135, 63, 190, 29, 199, 208, 160, 51, 221, 34, 68, 22, 53, 85, 85, 136, 191, 150, 93, 193, 248, 225, 15, 99, 132, 212, 163, 235, 163, 15, 241, 47, 94, 14, 169, 67, 224, 223, 131, 14, 192, 160, 108, 213, 33, 188, 218, 105, 51, 30, 84, 213, 54, 244, 162, 141, 166, 192, 181, 131, 237, 155, 154, 123, 89, 216, 129, 136, 108, 89, 141, 156, 91, 174, 225, 52, 9, 244, 21};
    genvar i;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            StochNumGen ro_sng(
                .clk                (clk),
                .reset              (reset),
                .seed               (seeds[i]),
                .prob               (num1_tests[i]),
                .stoch_num          (num_stoch[i])
            );
        end
    endgenerate

    // VIO
    wire [7:0] none;
    vio_1 vio(
        .clk                (clk),
        .probe_out0         (reset),
        .probe_out1         (none)
    );

    // ILA
    ila_5 ila_corr(
        .clk                 (clk),
        .probe0              (num_stoch[0]),
        .probe1              (num_stoch[1]),
        .probe2              (num_stoch[2]),
        .probe3              (num_stoch[3]),
        .probe4              (num_stoch[4]),
        .probe5              (num_stoch[5]),
        .probe6              (num_stoch[6]),
        .probe7              (num_stoch[7]),
        .probe8              (num_stoch[8]),
        .probe9              (num_stoch[9]),
        .probe10             (num_stoch[10]),
        .probe11             (num_stoch[11]),
        .probe12             (num_stoch[12]),
        .probe13             (num_stoch[13]),
        .probe14             (num_stoch[14]),
        .probe15             (num_stoch[15]),
        .probe16             (num_stoch[16]),
        .probe17             (num_stoch[17]),
        .probe18             (num_stoch[18]),
        .probe19             (num_stoch[19]),
        .probe20             (num_stoch[20]),
        .probe21             (num_stoch[21]),
        .probe22             (num_stoch[22]),
        .probe23             (num_stoch[23]),
        .probe24             (num_stoch[24]),
        .probe25             (num_stoch[25]),
        .probe26             (num_stoch[26]),
        .probe27             (num_stoch[27]),
        .probe28             (num_stoch[28]),
        .probe29             (num_stoch[29]),
        .probe30             (num_stoch[30]),
        .probe31             (num_stoch[31]),
        .probe32             (num_stoch[32]),
        .probe33             (num_stoch[33]),
        .probe34             (num_stoch[34]),
        .probe35             (num_stoch[35]),
        .probe36             (num_stoch[36]),
        .probe37             (num_stoch[37]),
        .probe38             (num_stoch[38]),
        .probe39             (num_stoch[39]),
        .probe40             (num_stoch[40]),
        .probe41             (num_stoch[41]),
        .probe42             (num_stoch[42]),
        .probe43             (num_stoch[43]),
        .probe44             (num_stoch[44]),
        .probe45             (num_stoch[45]),
        .probe46             (num_stoch[46]),
        .probe47             (num_stoch[47]),
        .probe48             (num_stoch[48]),
        .probe49             (num_stoch[49]),
        .probe50             (num_stoch[50]),
        .probe51             (num_stoch[51]),
        .probe52             (num_stoch[52]),
        .probe53             (num_stoch[53]),
        .probe54             (num_stoch[54]),
        .probe55             (num_stoch[55]),
        .probe56             (num_stoch[56]),
        .probe57             (num_stoch[57]),
        .probe58             (num_stoch[58]),
        .probe59             (num_stoch[59]),
        .probe60             (num_stoch[60]),
        .probe61             (num_stoch[61]),
        .probe62             (num_stoch[62]),
        .probe63             (num_stoch[63]),
        .probe64             (num_stoch[64]),
        .probe65             (num_stoch[65]),
        .probe66             (num_stoch[66]),
        .probe67             (num_stoch[67]),
        .probe68             (num_stoch[68]),
        .probe69             (num_stoch[69]),
        .probe70             (num_stoch[70]),
        .probe71             (num_stoch[71]),
        .probe72             (num_stoch[72]),
        .probe73             (num_stoch[73]),
        .probe74             (num_stoch[74]),
        .probe75             (num_stoch[75]),
        .probe76             (num_stoch[76]),
        .probe77             (num_stoch[77]),
        .probe78             (num_stoch[78]),
        .probe79             (num_stoch[79]),
        .probe80             (num_stoch[80]),
        .probe81             (num_stoch[81]),
        .probe82             (num_stoch[82]),
        .probe83             (num_stoch[83]),
        .probe84             (num_stoch[84]),
        .probe85             (num_stoch[85]),
        .probe86             (num_stoch[86]),
        .probe87             (num_stoch[87]),
        .probe88             (num_stoch[88]),
        .probe89             (num_stoch[89]),
        .probe90             (num_stoch[90]),
        .probe91             (num_stoch[91]),
        .probe92             (num_stoch[92]),
        .probe93             (num_stoch[93]),
        .probe94             (num_stoch[94]),
        .probe95             (num_stoch[95]),
        .probe96             (num_stoch[96]),
        .probe97             (num_stoch[97]),
        .probe98             (num_stoch[98]),
        .probe99             (num_stoch[99])
    );

endmodule
