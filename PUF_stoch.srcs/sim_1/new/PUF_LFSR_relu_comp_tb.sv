`timescale 1ns / 1ps

module PUF_LFSR_relu_comp_tb();

    reg clk = 0;
    reg reset = 0;

    logic [7:0] test_data [0:49] = '{ 99, 34, 36, 30, 184, 149, 230, 221, 82, 96, 190, 104, 180, 90, 137, 115, 110, 103, 254, 59, 226, 167, 104, 150, 116, 147, 66, 120, 24, 161, 205, 63, 7, 101, 83, 78, 201, 175, 170, 51, 253, 85, 46, 211, 188, 229, 96, 1, 55, 61 };

    reg [7:0] input_val;
    wire [7:0] out_val_lfsr;
    wire [7:0] out_val_puf;
    wire done;

    // DUT
    PUF_LFSR_relu_comp dut(
        .clk                (clk),
        .reset              (reset),
        .input_val          (input_val),

        .out_val_lfsr       (out_val_lfsr),
        .out_val_puf        (out_val_puf),
        .done               (done)
    );

    integer i;
    initial begin
        for (i=0; i<50; i=i+1) begin
            reset = 1;
            #75;
            reset = 0;
            input_val = test_data[i];
            # 12800;    // wait 256 clk cycles
        end
    end

    always begin
        #25;
        clk = ~clk;
    end

endmodule
