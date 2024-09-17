

module RO_PUF_5(
    output rand_bit
    );

    // Internal wires
    wire [6:0] par_out_gal;
    wire [6:0] par_out_fib;
    

    // Ring oscillators 5
    RO7_Galois ro1(
        .parallel_out       (par_out_gal)
    );

    // Ring oscillators 7
    RO7_Fib ro2(
        .parallel_out       (par_out_fib)
    );

    // XOR outputs together to create random bit
    assign rand_bit = par_out_gal[6] ^ par_out_fib[6];

endmodule
