
module PUF_rand_bit_test(
    input sys_clk
    );

    localparam NUM_TESTS = 200;

    // wires
    wire reset;
    wire clk;
    assign clk = sys_clk;


    ////////////// RO_PUF_4 /////////////////
    /*
    // stoch wires
    wire [199:0] rand_bit;

    // RO_SNG 1
    genvar i;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            RO_PUF_4 PUF(
                .rand_bit               (rand_bit[i])
            );
        end
    endgenerate
    */

    ////////////// RO_PUF_2 /////////////////
    /*
    // stoch wires
    wire [199:0] rand_bit;
    wire [7:0] rand_bytes [0:24];

    // RO_SNG 1
    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            RO_PUF_2_feedback PUF(
                .clk                    (clk),
                .rand_num               (rand_bytes[i])
            );
        end
    endgenerate

    genvar j;
    generate
        for (j=0; j<25; j=j+1) begin
            assign rand_bit[(j*8)+7 : j*8] = rand_bytes[j];
        end
    endgenerate
    */

    ////////////// RO_PUF_5 /////////////////
    /*
    // stoch wires
    wire [199:0] rand_bit;
    wire [7:0] rand_bytes [0:24];

    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            RO_PUF_5_top PUF(
                .clk                    (clk),
                .rand_num               (rand_bytes[i])
            );
        end
    endgenerate

    genvar j;
    generate
        for (j=0; j<25; j=j+1) begin
            assign rand_bit[(j*8)+7 : j*8] = rand_bytes[j];
        end
    endgenerate
    */

    ////////////// RO_PUF_2_feedback /////////////////
    // stoch wires
    wire [199:0] rand_bit;
    wire [7:0] rand_bytes [0:24];

    // RO_SNG 1
    genvar i;
    generate
        for (i=0; i<25; i=i+1) begin
            RO_PUF_2_feedback PUF(
                .clk                    (clk),
                .rand_num               (rand_bytes[i])
            );
        end
    endgenerate

    genvar j;
    generate
        for (j=0; j<25; j=j+1) begin
            assign rand_bit[(j*8)+7 : j*8] = rand_bytes[j];
        end
    endgenerate
    

    // ILA
    ila_4 ila_randbit(
        .clk                (clk),
        .probe0             (rand_bit[0]),
        .probe1             (rand_bit[1]),
        .probe2             (rand_bit[2]),
        .probe3             (rand_bit[3]),
        .probe4             (rand_bit[4]),
        .probe5             (rand_bit[5]),
        .probe6             (rand_bit[6]),
        .probe7             (rand_bit[7]),
        .probe8             (rand_bit[8]),
        .probe9             (rand_bit[9]),
        .probe10             (rand_bit[10]),
        .probe11             (rand_bit[11]),
        .probe12             (rand_bit[12]),
        .probe13             (rand_bit[13]),
        .probe14             (rand_bit[14]),
        .probe15             (rand_bit[15]),
        .probe16             (rand_bit[16]),
        .probe17             (rand_bit[17]),
        .probe18             (rand_bit[18]),
        .probe19             (rand_bit[19]),
        .probe20             (rand_bit[20]),
        .probe21             (rand_bit[21]),
        .probe22             (rand_bit[22]),
        .probe23             (rand_bit[23]),
        .probe24             (rand_bit[24]),
        .probe25             (rand_bit[25]),
        .probe26             (rand_bit[26]),
        .probe27             (rand_bit[27]),
        .probe28             (rand_bit[28]),
        .probe29             (rand_bit[29]),
        .probe30             (rand_bit[30]),
        .probe31             (rand_bit[31]),
        .probe32             (rand_bit[32]),
        .probe33             (rand_bit[33]),
        .probe34             (rand_bit[34]),
        .probe35             (rand_bit[35]),
        .probe36             (rand_bit[36]),
        .probe37             (rand_bit[37]),
        .probe38             (rand_bit[38]),
        .probe39             (rand_bit[39]),
        .probe40             (rand_bit[40]),
        .probe41             (rand_bit[41]),
        .probe42             (rand_bit[42]),
        .probe43             (rand_bit[43]),
        .probe44             (rand_bit[44]),
        .probe45             (rand_bit[45]),
        .probe46             (rand_bit[46]),
        .probe47             (rand_bit[47]),
        .probe48             (rand_bit[48]),
        .probe49             (rand_bit[49]),
        .probe50             (rand_bit[50]),
        .probe51             (rand_bit[51]),
        .probe52             (rand_bit[52]),
        .probe53             (rand_bit[53]),
        .probe54             (rand_bit[54]),
        .probe55             (rand_bit[55]),
        .probe56             (rand_bit[56]),
        .probe57             (rand_bit[57]),
        .probe58             (rand_bit[58]),
        .probe59             (rand_bit[59]),
        .probe60             (rand_bit[60]),
        .probe61             (rand_bit[61]),
        .probe62             (rand_bit[62]),
        .probe63             (rand_bit[63]),
        .probe64             (rand_bit[64]),
        .probe65             (rand_bit[65]),
        .probe66             (rand_bit[66]),
        .probe67             (rand_bit[67]),
        .probe68             (rand_bit[68]),
        .probe69             (rand_bit[69]),
        .probe70             (rand_bit[70]),
        .probe71             (rand_bit[71]),
        .probe72             (rand_bit[72]),
        .probe73             (rand_bit[73]),
        .probe74             (rand_bit[74]),
        .probe75             (rand_bit[75]),
        .probe76             (rand_bit[76]),
        .probe77             (rand_bit[77]),
        .probe78             (rand_bit[78]),
        .probe79             (rand_bit[79]),
        .probe80             (rand_bit[80]),
        .probe81             (rand_bit[81]),
        .probe82             (rand_bit[82]),
        .probe83             (rand_bit[83]),
        .probe84             (rand_bit[84]),
        .probe85             (rand_bit[85]),
        .probe86             (rand_bit[86]),
        .probe87             (rand_bit[87]),
        .probe88             (rand_bit[88]),
        .probe89             (rand_bit[89]),
        .probe90             (rand_bit[90]),
        .probe91             (rand_bit[91]),
        .probe92             (rand_bit[92]),
        .probe93             (rand_bit[93]),
        .probe94             (rand_bit[94]),
        .probe95             (rand_bit[95]),
        .probe96             (rand_bit[96]),
        .probe97             (rand_bit[97]),
        .probe98             (rand_bit[98]),
        .probe99             (rand_bit[99]),
        .probe100             (rand_bit[100]),
        .probe101             (rand_bit[101]),
        .probe102             (rand_bit[102]),
        .probe103             (rand_bit[103]),
        .probe104             (rand_bit[104]),
        .probe105             (rand_bit[105]),
        .probe106             (rand_bit[106]),
        .probe107             (rand_bit[107]),
        .probe108             (rand_bit[108]),
        .probe109             (rand_bit[109]),
        .probe110             (rand_bit[110]),
        .probe111             (rand_bit[111]),
        .probe112             (rand_bit[112]),
        .probe113             (rand_bit[113]),
        .probe114             (rand_bit[114]),
        .probe115             (rand_bit[115]),
        .probe116             (rand_bit[116]),
        .probe117             (rand_bit[117]),
        .probe118             (rand_bit[118]),
        .probe119             (rand_bit[119]),
        .probe120             (rand_bit[120]),
        .probe121             (rand_bit[121]),
        .probe122             (rand_bit[122]),
        .probe123             (rand_bit[123]),
        .probe124             (rand_bit[124]),
        .probe125             (rand_bit[125]),
        .probe126             (rand_bit[126]),
        .probe127             (rand_bit[127]),
        .probe128             (rand_bit[128]),
        .probe129             (rand_bit[129]),
        .probe130             (rand_bit[130]),
        .probe131             (rand_bit[131]),
        .probe132             (rand_bit[132]),
        .probe133             (rand_bit[133]),
        .probe134             (rand_bit[134]),
        .probe135             (rand_bit[135]),
        .probe136             (rand_bit[136]),
        .probe137             (rand_bit[137]),
        .probe138             (rand_bit[138]),
        .probe139             (rand_bit[139]),
        .probe140             (rand_bit[140]),
        .probe141             (rand_bit[141]),
        .probe142             (rand_bit[142]),
        .probe143             (rand_bit[143]),
        .probe144             (rand_bit[144]),
        .probe145             (rand_bit[145]),
        .probe146             (rand_bit[146]),
        .probe147             (rand_bit[147]),
        .probe148             (rand_bit[148]),
        .probe149             (rand_bit[149]),
        .probe150             (rand_bit[150]),
        .probe151             (rand_bit[151]),
        .probe152             (rand_bit[152]),
        .probe153             (rand_bit[153]),
        .probe154             (rand_bit[154]),
        .probe155             (rand_bit[155]),
        .probe156             (rand_bit[156]),
        .probe157             (rand_bit[157]),
        .probe158             (rand_bit[158]),
        .probe159             (rand_bit[159]),
        .probe160             (rand_bit[160]),
        .probe161             (rand_bit[161]),
        .probe162             (rand_bit[162]),
        .probe163             (rand_bit[163]),
        .probe164             (rand_bit[164]),
        .probe165             (rand_bit[165]),
        .probe166             (rand_bit[166]),
        .probe167             (rand_bit[167]),
        .probe168             (rand_bit[168]),
        .probe169             (rand_bit[169]),
        .probe170             (rand_bit[170]),
        .probe171             (rand_bit[171]),
        .probe172             (rand_bit[172]),
        .probe173             (rand_bit[173]),
        .probe174             (rand_bit[174]),
        .probe175             (rand_bit[175]),
        .probe176             (rand_bit[176]),
        .probe177             (rand_bit[177]),
        .probe178             (rand_bit[178]),
        .probe179             (rand_bit[179]),
        .probe180             (rand_bit[180]),
        .probe181             (rand_bit[181]),
        .probe182             (rand_bit[182]),
        .probe183             (rand_bit[183]),
        .probe184             (rand_bit[184]),
        .probe185             (rand_bit[185]),
        .probe186             (rand_bit[186]),
        .probe187             (rand_bit[187]),
        .probe188             (rand_bit[188]),
        .probe189             (rand_bit[189]),
        .probe190             (rand_bit[190]),
        .probe191             (rand_bit[191]),
        .probe192             (rand_bit[192]),
        .probe193             (rand_bit[193]),
        .probe194             (rand_bit[194]),
        .probe195             (rand_bit[195]),
        .probe196             (rand_bit[196]),
        .probe197             (rand_bit[197]),
        .probe198             (rand_bit[198]),
        .probe199             (rand_bit[199])
    );

endmodule
