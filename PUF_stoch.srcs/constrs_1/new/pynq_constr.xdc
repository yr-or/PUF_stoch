set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sys_clk }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sys_clk }];

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].PUF/genblk*[*].ro_puf/ro*/not*]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].PUF/ro*/not*]

# RO_PUF_5 mult_test
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].ro_sng*/rng/genblk1[*].ro_puf/ro*/not*]

# RO_PUF_5 rand_bit_test
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].PUF/genblk*[*].ro_puf/ro*/not*]

# RO_PUF_4/2 rand_bit_test
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].PUF/ro*/not*]

# RO_PUF_4 mult test
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].ro_sng*/rng/genblk1[*].ro_puf/ro*/not*]

# RO_PUF_3
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng1/rng/ro1/not1]

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng/rng/ro1/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng/rng/ro2/parallel_out[*]]

# RO_PUF_2 mult test
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk*[*].ro_sng*/rng/ro*/not*]

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets dut/genblk1[*].sng_puf/rng/ro1/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets dut/genblk1[*].sng_puf/rng/ro2/parallel_out[*]]