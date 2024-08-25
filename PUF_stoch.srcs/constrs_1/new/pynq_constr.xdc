set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { sys_clk }]; #IO_L13P_T2_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sys_clk }];

set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng/rng/ro1/parallel_out[*]]
set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng/rng/ro2/parallel_out[*]]

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng1/rng/ro1/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk1[*].ro_sng1/rng/ro2/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk2[*].ro_sng2/rng/ro1/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets genblk2[*].ro_sng2/rng/ro2/parallel_out[*]]

#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets dut/genblk1[*].sng_puf/rng/ro1/parallel_out[*]]
#set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets dut/genblk1[*].sng_puf/rng/ro2/parallel_out[*]]