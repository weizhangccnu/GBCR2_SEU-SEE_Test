# KC705 configuration
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]

# 200MHz onboard diff clock
create_clock -name system_clock -period 5.0 [get_ports SYS_CLK_P]# KC705 configuration
# false path of resetter
set_false_path -from [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *GLOBAL_RST_reg*}] -filter {NAME =~ *C}]
#-------------------------------------------------------------< System Clock Interface
# PadFunction: IO_L12P_T1_MRCC_33
set_property IOSTANDARD DIFF_SSTL15 [get_ports SYS_CLK_P]
set_property PACKAGE_PIN AD12 [get_ports SYS_CLK_P]
# PadFunction: IO_L12N_T1_MRCC_33
set_property IOSTANDARD DIFF_SSTL15 [get_ports SYS_CLK_N]
set_property PACKAGE_PIN AD11 [get_ports SYS_CLK_N]
#-------------------------------------------------------------> System Clock Interface
#-------------------------------------------------------------< System reset Interface
# Bank: 33 - GPIO_SW_7 (CPU_RESET)
set_property VCCAUX_IO DONTCARE [get_ports SYS_RST]
set_property SLEW SLOW [get_ports SYS_RST]
set_property IOSTANDARD LVCMOS15 [get_ports SYS_RST]
set_property LOC AB7 [get_ports SYS_RST]
#-------------------------------------------------------------> System reset Interface

####################### GT reference clock constraints #########################
create_clock -period 6.25 [get_ports Q0_CLK1_GTREFCLK_PAD_P_IN]

set_false_path -to [get_pins -hierarchical -filter {NAME =~ *_txfsmresetdone_r*/CLR}]
set_false_path -to [get_pins -hierarchical -filter {NAME =~ *_txfsmresetdone_r*/D}]

################################# RefClk Location constraints #####################
set_property LOC U7 [get_ports  Q0_CLK1_GTREFCLK_PAD_N_IN ]         # GTX1
set_property LOC U8 [get_ports  Q0_CLK1_GTREFCLK_PAD_P_IN ]

set_property LOC AA4 [get_ports RXP_IN[0]]          # GTX2 X0Y0 PCIe7
set_property LOC AA3 [get_ports RXN_IN[0]]

set_property LOC Y2 [get_ports TXP_OUT[0]]          
set_property LOC Y1 [get_ports TXN_OUT[0]]

set_property LOC Y6 [get_ports RXP_IN[1]]          # GTX2 X0Y1 PCIe6
set_property LOC Y5 [get_ports RXN_IN[1]]

set_property LOC V2 [get_ports TXP_OUT[1]]          
set_property LOC V1 [get_ports TXN_OUT[1]]

set_property LOC W4 [get_ports RXP_IN[2]]          # GTX2 X0Y2 PCIe5
set_property LOC W3 [get_ports RXN_IN[2]]

set_property LOC U4 [get_ports TXP_OUT[2]]          
set_property LOC U3 [get_ports TXN_OUT[2]]

set_property LOC V6 [get_ports RXP_IN[3]]          # GTX2 X0Y3 PCIe4
set_property LOC V5 [get_ports RXN_IN[3]]

set_property LOC T2 [get_ports TXP_OUT[3]]          
set_property LOC T1 [get_ports TXN_OUT[3]]

set_property LOC T6 [get_ports RXP_IN[4]]          # GTX2 X0Y4 PCIe3
set_property LOC T5 [get_ports RXN_IN[4]]

set_property LOC P2 [get_ports TXP_OUT[4]]          
set_property LOC P1 [get_ports TXN_OUT[4]]

set_property LOC R4 [get_ports RXP_IN[5]]          # GTX2 X0Y5 PCIe2
set_property LOC R3 [get_ports RXN_IN[5]]

set_property LOC N4 [get_ports TXP_OUT[5]]          
set_property LOC N3 [get_ports TXN_OUT[5]]

set_property LOC P6 [get_ports RXP_IN[6]]          # GTX2 X0Y6 PCIe1
set_property LOC P5 [get_ports RXN_IN[6]]

set_property LOC M2 [get_ports TXP_OUT[6]]          
set_property LOC M1 [get_ports TXN_OUT[6]]