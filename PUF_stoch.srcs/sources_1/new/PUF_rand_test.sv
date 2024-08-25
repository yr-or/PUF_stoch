

module PUF_rand_test(
    input sys_clk
    );

    localparam NUM_TESTS = 200;

    // wires
    wire reset;
    wire clk;
    assign clk = sys_clk;

    wire done [0:NUM_TESTS-1];
    wire enable;

    wire [7:0] stb_out [0:NUM_TESTS-1];

    // stoch wires
    wire num_stoch [0:NUM_TESTS-1];

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

    // STB relu res
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            StochToBin8 stb(
                .clk                (clk),
                .reset              (reset),
                .enable             (enable),
                .bit_stream         (num_stoch[i]),
                .bin_number         (stb_out[i]),
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
        .probe2             (stb_out[0]),
        .probe3             (stb_out[1]),
        .probe4             (stb_out[2]),
        .probe5             (stb_out[3]),
        .probe6             (stb_out[4]),
        .probe7             (stb_out[5]),
        .probe8             (stb_out[6]),
        .probe9             (stb_out[7]),
        .probe10             (stb_out[8]),
        .probe11             (stb_out[9]),
        .probe12             (stb_out[10]),
        .probe13             (stb_out[11]),
        .probe14             (stb_out[12]),
        .probe15             (stb_out[13]),
        .probe16             (stb_out[14]),
        .probe17             (stb_out[15]),
        .probe18             (stb_out[16]),
        .probe19             (stb_out[17]),
        .probe20             (stb_out[18]),
        .probe21             (stb_out[19]),
        .probe22             (stb_out[20]),
        .probe23             (stb_out[21]),
        .probe24             (stb_out[22]),
        .probe25             (stb_out[23]),
        .probe26             (stb_out[24]),
        .probe27             (stb_out[25]),
        .probe28             (stb_out[26]),
        .probe29             (stb_out[27]),
        .probe30             (stb_out[28]),
        .probe31             (stb_out[29]),
        .probe32             (stb_out[30]),
        .probe33             (stb_out[31]),
        .probe34             (stb_out[32]),
        .probe35             (stb_out[33]),
        .probe36             (stb_out[34]),
        .probe37             (stb_out[35]),
        .probe38             (stb_out[36]),
        .probe39             (stb_out[37]),
        .probe40             (stb_out[38]),
        .probe41             (stb_out[39]),
        .probe42             (stb_out[40]),
        .probe43             (stb_out[41]),
        .probe44             (stb_out[42]),
        .probe45             (stb_out[43]),
        .probe46             (stb_out[44]),
        .probe47             (stb_out[45]),
        .probe48             (stb_out[46]),
        .probe49             (stb_out[47]),
        .probe50             (stb_out[48]),
        .probe51             (stb_out[49]),
        .probe52             (stb_out[50]),
        .probe53             (stb_out[51]),
        .probe54             (stb_out[52]),
        .probe55             (stb_out[53]),
        .probe56             (stb_out[54]),
        .probe57             (stb_out[55]),
        .probe58             (stb_out[56]),
        .probe59             (stb_out[57]),
        .probe60             (stb_out[58]),
        .probe61             (stb_out[59]),
        .probe62             (stb_out[60]),
        .probe63             (stb_out[61]),
        .probe64             (stb_out[62]),
        .probe65             (stb_out[63]),
        .probe66             (stb_out[64]),
        .probe67             (stb_out[65]),
        .probe68             (stb_out[66]),
        .probe69             (stb_out[67]),
        .probe70             (stb_out[68]),
        .probe71             (stb_out[69]),
        .probe72             (stb_out[70]),
        .probe73             (stb_out[71]),
        .probe74             (stb_out[72]),
        .probe75             (stb_out[73]),
        .probe76             (stb_out[74]),
        .probe77             (stb_out[75]),
        .probe78             (stb_out[76]),
        .probe79             (stb_out[77]),
        .probe80             (stb_out[78]),
        .probe81             (stb_out[79]),
        .probe82             (stb_out[80]),
        .probe83             (stb_out[81]),
        .probe84             (stb_out[82]),
        .probe85             (stb_out[83]),
        .probe86             (stb_out[84]),
        .probe87             (stb_out[85]),
        .probe88             (stb_out[86]),
        .probe89             (stb_out[87]),
        .probe90             (stb_out[88]),
        .probe91             (stb_out[89]),
        .probe92             (stb_out[90]),
        .probe93             (stb_out[91]),
        .probe94             (stb_out[92]),
        .probe95             (stb_out[93]),
        .probe96             (stb_out[94]),
        .probe97             (stb_out[95]),
        .probe98             (stb_out[96]),
        .probe99             (stb_out[97]),
        .probe100             (stb_out[98]),
        .probe101             (stb_out[99]),
        .probe102             (stb_out[100]),
        .probe103             (stb_out[101]),
        .probe104             (stb_out[102]),
        .probe105             (stb_out[103]),
        .probe106             (stb_out[104]),
        .probe107             (stb_out[105]),
        .probe108             (stb_out[106]),
        .probe109             (stb_out[107]),
        .probe110             (stb_out[108]),
        .probe111             (stb_out[109]),
        .probe112             (stb_out[110]),
        .probe113             (stb_out[111]),
        .probe114             (stb_out[112]),
        .probe115             (stb_out[113]),
        .probe116             (stb_out[114]),
        .probe117             (stb_out[115]),
        .probe118             (stb_out[116]),
        .probe119             (stb_out[117]),
        .probe120             (stb_out[118]),
        .probe121             (stb_out[119]),
        .probe122             (stb_out[120]),
        .probe123             (stb_out[121]),
        .probe124             (stb_out[122]),
        .probe125             (stb_out[123]),
        .probe126             (stb_out[124]),
        .probe127             (stb_out[125]),
        .probe128             (stb_out[126]),
        .probe129             (stb_out[127]),
        .probe130             (stb_out[128]),
        .probe131             (stb_out[129]),
        .probe132             (stb_out[130]),
        .probe133             (stb_out[131]),
        .probe134             (stb_out[132]),
        .probe135             (stb_out[133]),
        .probe136             (stb_out[134]),
        .probe137             (stb_out[135]),
        .probe138             (stb_out[136]),
        .probe139             (stb_out[137]),
        .probe140             (stb_out[138]),
        .probe141             (stb_out[139]),
        .probe142             (stb_out[140]),
        .probe143             (stb_out[141]),
        .probe144             (stb_out[142]),
        .probe145             (stb_out[143]),
        .probe146             (stb_out[144]),
        .probe147             (stb_out[145]),
        .probe148             (stb_out[146]),
        .probe149             (stb_out[147]),
        .probe150             (stb_out[148]),
        .probe151             (stb_out[149]),
        .probe152             (stb_out[150]),
        .probe153             (stb_out[151]),
        .probe154             (stb_out[152]),
        .probe155             (stb_out[153]),
        .probe156             (stb_out[154]),
        .probe157             (stb_out[155]),
        .probe158             (stb_out[156]),
        .probe159             (stb_out[157]),
        .probe160             (stb_out[158]),
        .probe161             (stb_out[159]),
        .probe162             (stb_out[160]),
        .probe163             (stb_out[161]),
        .probe164             (stb_out[162]),
        .probe165             (stb_out[163]),
        .probe166             (stb_out[164]),
        .probe167             (stb_out[165]),
        .probe168             (stb_out[166]),
        .probe169             (stb_out[167]),
        .probe170             (stb_out[168]),
        .probe171             (stb_out[169]),
        .probe172             (stb_out[170]),
        .probe173             (stb_out[171]),
        .probe174             (stb_out[172]),
        .probe175             (stb_out[173]),
        .probe176             (stb_out[174]),
        .probe177             (stb_out[175]),
        .probe178             (stb_out[176]),
        .probe179             (stb_out[177]),
        .probe180             (stb_out[178]),
        .probe181             (stb_out[179]),
        .probe182             (stb_out[180]),
        .probe183             (stb_out[181]),
        .probe184             (stb_out[182]),
        .probe185             (stb_out[183]),
        .probe186             (stb_out[184]),
        .probe187             (stb_out[185]),
        .probe188             (stb_out[186]),
        .probe189             (stb_out[187]),
        .probe190             (stb_out[188]),
        .probe191             (stb_out[189]),
        .probe192             (stb_out[190]),
        .probe193             (stb_out[191]),
        .probe194             (stb_out[192]),
        .probe195             (stb_out[193]),
        .probe196             (stb_out[194]),
        .probe197             (stb_out[195]),
        .probe198             (stb_out[196]),
        .probe199             (stb_out[197]),
        .probe200             (stb_out[198]),
        .probe201             (stb_out[199])
    );

endmodule
