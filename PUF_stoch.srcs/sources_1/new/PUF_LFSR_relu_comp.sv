

(* keep_hierarchy = "yes" *)
(* DONT_TOUCH = "yes" *)
(* keep = "true" *)
module PUF_LFSR_relu_comp(
    input clk,
    input reset,
    
    output [7:0] out_val_lfsr [0:99],
    output [7:0] out_val_puf [0:99],
    output done
    );

    localparam NUM_TESTS = 100;

    // Input data
    reg [7:0] input_data [0:NUM_TESTS-1] = '{11, 120, 148, 9, 82, 203, 89, 167, 227, 3, 161, 251, 195, 15, 93, 173, 247, 146, 59, 92, 127, 18, 169, 130, 39, 225, 34, 212, 125, 201, 96, 151, 88, 45, 35, 65, 120, 71, 183, 119, 58, 24, 12, 183, 87, 173, 227, 222, 43, 42, 229, 220, 149, 65, 239, 141, 135, 185, 44, 89, 105, 76, 129, 142, 89, 148, 74, 59, 9, 227, 56, 18, 168, 34, 249, 8, 55, 140, 176, 74, 206, 6, 110, 3, 39, 79, 65, 197, 49, 177, 76, 222, 116, 36, 236, 90, 39, 109, 133, 233};

    // stoch wires
    wire stoch_num_puf [0:NUM_TESTS-1];
    wire stoch_num_lfsr [0:NUM_TESTS-1];
    wire relu1_out_stoch [0:99];
    wire relu2_out_stoch [0:99];

    // Instantiate 100 SNGs of lfsr and puf
    genvar i;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            SNG_RO sng_puf(
                .clk                (clk),
                .reset              (reset),
                .enable             (1'b1),
                .prob               (input_data[i]),
                .stoch_num          (stoch_num_puf[i])
            );
        end
    endgenerate

    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            StochNumGen sng_lfsr(
                .clk                (clk),
                .reset              (reset),
                .seed               (8'd374),
                .prob               (input_data[i]),
                .stoch_num          (stoch_num_lfsr[i])
            );
        end
    endgenerate

    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            Sigmoid_FSM sig1(
                .clk                (clk),
                .reset              (reset),
                .in_stoch           (stoch_num_puf[i]),
                .out_stoch          (relu1_out_stoch[i])
            );
            Sigmoid_FSM sig2(
                .clk                (clk),
                .reset              (reset),
                .in_stoch           (stoch_num_lfsr[i]),
                .out_stoch          (relu2_out_stoch[i])
            );
        end
    endgenerate

    wire [99:0] done_arr;
    generate
        for (i=0; i<NUM_TESTS; i=i+1) begin
            StochToBin8 STB1(
                .clk                (clk),
                .reset              (reset),
                .enable             (1'b1),
                .bit_stream         (relu1_out_stoch[i]),
                .bin_number         (out_val_puf[i]),
                .done               (done_arr[i])
            );
            StochToBin8 STB2(
                .clk                (clk),
                .reset              (reset),
                .enable             (1'b1),
                .bit_stream         (relu2_out_stoch[i]),
                .bin_number         (out_val_lfsr[i])
            );
        end
    endgenerate

    assign done = &(done_arr);

endmodule
