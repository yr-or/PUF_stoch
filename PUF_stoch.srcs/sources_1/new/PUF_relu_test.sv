// Hardware testbench for testing PUF with stochastic multiplier

module PUF_relu_test(
    input sys_clk
    );

    localparam NUM_TESTS = 200;

    // wires
    wire reset;
    wire clk;
    assign clk = sys_clk;

    wire done [0:NUM_TESTS-1];
    wire enable;

    wire [7:0] relu_out [0:NUM_TESTS-1];

    // stoch wires
    wire num_stoch [0:NUM_TESTS-1];
    wire relu_out_stoch [0:NUM_TESTS-1];

    // Inputs
    reg [7:0] num1_tests [0:NUM_TESTS-1] = '{250, 47, 191, 225, 118, 27, 72, 235, 116, 5, 230, 242, 73, 57, 218, 252, 164, 124, 13, 127, 109, 158, 51, 24, 140, 50, 111, 181, 173, 84, 128, 57, 246, 188, 236, 211, 2, 218, 34, 161, 115, 67, 54, 182, 31, 37, 127, 243, 111, 28, 49, 182, 191, 102, 60, 123, 221, 62, 1, 201, 54, 233, 20, 99, 57, 67, 3, 181, 40, 170, 73, 109, 4, 248, 197, 248, 133, 193, 117, 248, 135, 79, 123, 142, 50, 78, 17, 123, 179, 244, 75, 135, 60, 253, 237, 142, 6, 137, 114, 249, 76, 27, 120, 95, 97, 223, 147, 162, 183, 133, 99, 150, 212, 158, 13, 76, 152, 89, 13, 35, 94, 220, 56, 145, 168, 189, 9, 0, 66, 231, 206, 183, 146, 34, 246, 112, 20, 117, 62, 105, 230, 171, 81, 146, 221, 158, 92, 214, 226, 98, 205, 223, 113, 10, 161, 112, 21, 100, 75, 41, 98, 88, 207, 186, 203, 190, 50, 110, 189, 45, 148, 76, 56, 134, 157, 207, 188, 43, 43, 153, 183, 54, 112, 16, 237, 60, 72, 147, 16, 81, 29, 223, 215, 229, 71, 202, 221, 236, 152, 94};

    // RO_SNG 1
    genvar i;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            SNG_RO ro_sng(
                .clk                (clk),
                .reset              (reset),
                .enable             (enable),
                .prob               (num1_tests[i]),
                .stoch_num          (num_stoch[i])
            );
        end
    endgenerate

    // Relu FSM
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            ReLU_FSM relu1(                     // Change to relu or sigmoid here
                .clk                (clk),
                .reset              (reset),
                .in_stoch           (num_stoch[i]),
                .out_stoch          (relu_out_stoch[i])
            );
        end
    endgenerate

    // STB relu res
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            StochToBin8 stb_mul(
                .clk                (clk),
                .reset              (reset),
                .enable             (enable),
                .bit_stream         (relu_out_stoch[i]),
                .bin_number         (relu_out[i]),
                .done               (done[i])
            );
        end
        endgenerate

    // VIO
    vio_1 vio(
        .clk                (clk),
        .probe_out0         (reset),
        .probe_out1         (enable)
    );

    // ILA
    ila_2 ila_mult(
        .clk                (clk),
        .probe0             (reset),
        .probe1             (done[0]),
        .probe2             (relu_out[0]),
        .probe3             (relu_out[1]),
        .probe4             (relu_out[2]),
        .probe5             (relu_out[3]),
        .probe6             (relu_out[4]),
        .probe7             (relu_out[5]),
        .probe8             (relu_out[6]),
        .probe9             (relu_out[7]),
        .probe10             (relu_out[8]),
        .probe11             (relu_out[9]),
        .probe12             (relu_out[10]),
        .probe13             (relu_out[11]),
        .probe14             (relu_out[12]),
        .probe15             (relu_out[13]),
        .probe16             (relu_out[14]),
        .probe17             (relu_out[15]),
        .probe18             (relu_out[16]),
        .probe19             (relu_out[17]),
        .probe20             (relu_out[18]),
        .probe21             (relu_out[19]),
        .probe22             (relu_out[20]),
        .probe23             (relu_out[21]),
        .probe24             (relu_out[22]),
        .probe25             (relu_out[23]),
        .probe26             (relu_out[24]),
        .probe27             (relu_out[25]),
        .probe28             (relu_out[26]),
        .probe29             (relu_out[27]),
        .probe30             (relu_out[28]),
        .probe31             (relu_out[29]),
        .probe32             (relu_out[30]),
        .probe33             (relu_out[31]),
        .probe34             (relu_out[32]),
        .probe35             (relu_out[33]),
        .probe36             (relu_out[34]),
        .probe37             (relu_out[35]),
        .probe38             (relu_out[36]),
        .probe39             (relu_out[37]),
        .probe40             (relu_out[38]),
        .probe41             (relu_out[39]),
        .probe42             (relu_out[40]),
        .probe43             (relu_out[41]),
        .probe44             (relu_out[42]),
        .probe45             (relu_out[43]),
        .probe46             (relu_out[44]),
        .probe47             (relu_out[45]),
        .probe48             (relu_out[46]),
        .probe49             (relu_out[47]),
        .probe50             (relu_out[48]),
        .probe51             (relu_out[49]),
        .probe52             (relu_out[50]),
        .probe53             (relu_out[51]),
        .probe54             (relu_out[52]),
        .probe55             (relu_out[53]),
        .probe56             (relu_out[54]),
        .probe57             (relu_out[55]),
        .probe58             (relu_out[56]),
        .probe59             (relu_out[57]),
        .probe60             (relu_out[58]),
        .probe61             (relu_out[59]),
        .probe62             (relu_out[60]),
        .probe63             (relu_out[61]),
        .probe64             (relu_out[62]),
        .probe65             (relu_out[63]),
        .probe66             (relu_out[64]),
        .probe67             (relu_out[65]),
        .probe68             (relu_out[66]),
        .probe69             (relu_out[67]),
        .probe70             (relu_out[68]),
        .probe71             (relu_out[69]),
        .probe72             (relu_out[70]),
        .probe73             (relu_out[71]),
        .probe74             (relu_out[72]),
        .probe75             (relu_out[73]),
        .probe76             (relu_out[74]),
        .probe77             (relu_out[75]),
        .probe78             (relu_out[76]),
        .probe79             (relu_out[77]),
        .probe80             (relu_out[78]),
        .probe81             (relu_out[79]),
        .probe82             (relu_out[80]),
        .probe83             (relu_out[81]),
        .probe84             (relu_out[82]),
        .probe85             (relu_out[83]),
        .probe86             (relu_out[84]),
        .probe87             (relu_out[85]),
        .probe88             (relu_out[86]),
        .probe89             (relu_out[87]),
        .probe90             (relu_out[88]),
        .probe91             (relu_out[89]),
        .probe92             (relu_out[90]),
        .probe93             (relu_out[91]),
        .probe94             (relu_out[92]),
        .probe95             (relu_out[93]),
        .probe96             (relu_out[94]),
        .probe97             (relu_out[95]),
        .probe98             (relu_out[96]),
        .probe99             (relu_out[97]),
        .probe100             (relu_out[98]),
        .probe101             (relu_out[99]),
        .probe102             (relu_out[100]),
        .probe103             (relu_out[101]),
        .probe104             (relu_out[102]),
        .probe105             (relu_out[103]),
        .probe106             (relu_out[104]),
        .probe107             (relu_out[105]),
        .probe108             (relu_out[106]),
        .probe109             (relu_out[107]),
        .probe110             (relu_out[108]),
        .probe111             (relu_out[109]),
        .probe112             (relu_out[110]),
        .probe113             (relu_out[111]),
        .probe114             (relu_out[112]),
        .probe115             (relu_out[113]),
        .probe116             (relu_out[114]),
        .probe117             (relu_out[115]),
        .probe118             (relu_out[116]),
        .probe119             (relu_out[117]),
        .probe120             (relu_out[118]),
        .probe121             (relu_out[119]),
        .probe122             (relu_out[120]),
        .probe123             (relu_out[121]),
        .probe124             (relu_out[122]),
        .probe125             (relu_out[123]),
        .probe126             (relu_out[124]),
        .probe127             (relu_out[125]),
        .probe128             (relu_out[126]),
        .probe129             (relu_out[127]),
        .probe130             (relu_out[128]),
        .probe131             (relu_out[129]),
        .probe132             (relu_out[130]),
        .probe133             (relu_out[131]),
        .probe134             (relu_out[132]),
        .probe135             (relu_out[133]),
        .probe136             (relu_out[134]),
        .probe137             (relu_out[135]),
        .probe138             (relu_out[136]),
        .probe139             (relu_out[137]),
        .probe140             (relu_out[138]),
        .probe141             (relu_out[139]),
        .probe142             (relu_out[140]),
        .probe143             (relu_out[141]),
        .probe144             (relu_out[142]),
        .probe145             (relu_out[143]),
        .probe146             (relu_out[144]),
        .probe147             (relu_out[145]),
        .probe148             (relu_out[146]),
        .probe149             (relu_out[147]),
        .probe150             (relu_out[148]),
        .probe151             (relu_out[149]),
        .probe152             (relu_out[150]),
        .probe153             (relu_out[151]),
        .probe154             (relu_out[152]),
        .probe155             (relu_out[153]),
        .probe156             (relu_out[154]),
        .probe157             (relu_out[155]),
        .probe158             (relu_out[156]),
        .probe159             (relu_out[157]),
        .probe160             (relu_out[158]),
        .probe161             (relu_out[159]),
        .probe162             (relu_out[160]),
        .probe163             (relu_out[161]),
        .probe164             (relu_out[162]),
        .probe165             (relu_out[163]),
        .probe166             (relu_out[164]),
        .probe167             (relu_out[165]),
        .probe168             (relu_out[166]),
        .probe169             (relu_out[167]),
        .probe170             (relu_out[168]),
        .probe171             (relu_out[169]),
        .probe172             (relu_out[170]),
        .probe173             (relu_out[171]),
        .probe174             (relu_out[172]),
        .probe175             (relu_out[173]),
        .probe176             (relu_out[174]),
        .probe177             (relu_out[175]),
        .probe178             (relu_out[176]),
        .probe179             (relu_out[177]),
        .probe180             (relu_out[178]),
        .probe181             (relu_out[179]),
        .probe182             (relu_out[180]),
        .probe183             (relu_out[181]),
        .probe184             (relu_out[182]),
        .probe185             (relu_out[183]),
        .probe186             (relu_out[184]),
        .probe187             (relu_out[185]),
        .probe188             (relu_out[186]),
        .probe189             (relu_out[187]),
        .probe190             (relu_out[188]),
        .probe191             (relu_out[189]),
        .probe192             (relu_out[190]),
        .probe193             (relu_out[191]),
        .probe194             (relu_out[192]),
        .probe195             (relu_out[193]),
        .probe196             (relu_out[194]),
        .probe197             (relu_out[195]),
        .probe198             (relu_out[196]),
        .probe199             (relu_out[197]),
        .probe200             (relu_out[198]),
        .probe201             (relu_out[199])
    );

endmodule
