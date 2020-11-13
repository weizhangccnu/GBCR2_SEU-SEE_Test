`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Southern Methodist University
// Engineer: Wei Zhang
// 
// Create Date: 11/08/2020 04:12:00 PM
// Design Name: GBCR2_SEU_Test
// Module Name: GBCR2_SEU_Test
// Project Name: GBCR2_SER_Test_7RX
// Target Devices: KC705
// Tool Versions: Vivado 2018.2
// Description: This firmware is used to test GBCR2 SEU/SEE.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module GBCR2_SEU_Test(
//---------------------< system clock and reset
input SYS_RST,              //system reset
input SYS_CLK_P,            //system clock 200MHz
input SYS_CLK_N,
//---------------------< GTX fro Rx
input Q0_CLK1_GTREFCLK_PAD_N_IN,
input Q0_CLK1_GTREFCLK_PAD_P_IN,
input [6:0] RXN_IN,
input [6:0] RXP_IN,
output [6:0] TXN_OUT,
output [6:0] TXP_OUT
//---------------------< Ethernet
);
//---------------------------------------------------------< global_clock_reset
wire reset;
wire sys_clk;
wire clk_20MHz;
wire clk_50MHz;
wire clk_100MHz;
wire clk_160MHz;
wire clk_200MHz;
global_clock_reset global_clock_reset_inst(
    .SYS_CLK_P(SYS_CLK_P),
    .SYS_CLK_N(SYS_CLK_N),
    .FORCE_RST(SYS_RST),
    // output
    .GLOBAL_RST(reset),
    .SYS_CLK(sys_clk),
    .CLK_OUT1(clk_25MHz),
    .CLK_OUT2(clk_50MHz),
    .CLK_OUT3(clk_100MHz),
    .CLK_OUT4(clk_160MHz),
    .CLK_OUT5(clk_200MHz)
  );    
//---------------------------------------------------------> global_clock_reset

//---------------------------------------------------------> GTX PCIe6
wire [31:0] gt0_rxdata_i;
wire [31:0] gt0_txdata_i;
wire [31:0] gt1_rxdata_i;
wire [31:0] gt1_txdata_i;
wire [31:0] gt2_rxdata_i;
wire [31:0] gt2_txdata_i;
wire [31:0] gt3_rxdata_i;
wire [31:0] gt3_txdata_i;
wire [31:0] gt4_rxdata_i;
wire [31:0] gt4_txdata_i;
wire [31:0] gt5_rxdata_i;
wire [31:0] gt5_txdata_i;
wire [31:0] gt6_rxdata_i;
wire [31:0] gt6_txdata_i;
wire gt0_rxusrclk2_i;
wire gt0_txusrclk2_i;
wire gt1_rxusrclk2_i;
wire gt1_txusrclk2_i;
wire gt2_rxusrclk2_i;
wire gt2_txusrclk2_i;
wire gt3_rxusrclk2_i;
wire gt3_txusrclk2_i;
wire gt4_rxusrclk2_i;
wire gt4_txusrclk2_i;
wire gt5_rxusrclk2_i;
wire gt5_txusrclk2_i;
wire gt6_rxusrclk2_i;
wire gt6_txusrclk2_i;

gtwizard_0_exdes gtwizard_0_exdes_inst(
.Q0_CLK1_GTREFCLK_PAD_N_IN(Q0_CLK1_GTREFCLK_PAD_N_IN),
.Q0_CLK1_GTREFCLK_PAD_P_IN(Q0_CLK1_GTREFCLK_PAD_P_IN),
.DRPCLK_IN(clk_100MHz),
.TRACK_DATA_OUT("open"),
.RXN_IN(RXN_IN),
.RXP_IN(RXP_IN),
.TXN_OUT(TXN_OUT),
.TXP_OUT(TXP_OUT),
.gt0_rxdata_i(gt0_rxdata_i),
.gt0_txdata_i(gt0_txdata_i),
.gt1_rxdata_i(gt1_rxdata_i),
.gt1_txdata_i(gt1_txdata_i),
.gt2_rxdata_i(gt2_rxdata_i),
.gt2_txdata_i(gt2_txdata_i),
.gt3_rxdata_i(gt3_rxdata_i),
.gt3_txdata_i(gt3_txdata_i),
.gt4_rxdata_i(gt4_rxdata_i),
.gt4_txdata_i(gt4_txdata_i),
.gt5_rxdata_i(gt5_rxdata_i),
.gt5_txdata_i(gt5_txdata_i),
.gt6_rxdata_i(gt6_rxdata_i),
.gt6_txdata_i(gt6_txdata_i),
.gt0_rxusrclk2_i(gt0_rxusrclk2_i),
.gt0_txusrclk2_i(gt0_txusrclk2_i),
.gt1_rxusrclk2_i(gt1_rxusrclk2_i),
.gt1_txusrclk2_i(gt1_txusrclk2_i),
.gt2_rxusrclk2_i(gt2_rxusrclk2_i),
.gt2_txusrclk2_i(gt2_txusrclk2_i),
.gt3_rxusrclk2_i(gt3_rxusrclk2_i),
.gt3_txusrclk2_i(gt3_txusrclk2_i),
.gt4_rxusrclk2_i(gt4_rxusrclk2_i),
.gt4_txusrclk2_i(gt4_txusrclk2_i),
.gt5_rxusrclk2_i(gt5_rxusrclk2_i),
.gt5_txusrclk2_i(gt5_txusrclk2_i),
.gt6_rxusrclk2_i(gt6_rxusrclk2_i),
.gt6_txusrclk2_i(gt6_txusrclk2_i)
);
//---------------------------------------------------------< GTX PCIe6

//---------------------------------------------------------> PRBS31Gen32b
wire [31:0] Tx0_PRBS31Gen32b;
wire [31:0] Tx1_PRBS31Gen32b;
wire [31:0] Tx2_PRBS31Gen32b;
wire [31:0] Tx3_PRBS31Gen32b;
wire [31:0] Tx4_PRBS31Gen32b;
wire [31:0] Tx5_PRBS31Gen32b;
wire [31:0] Tx6_PRBS31Gen32b;
PRBS31Gen32b PRBS31Gen32b_inst0(
.clk(gt0_txusrclk2_i),
.random(Tx0_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst1(
.clk(gt1_txusrclk2_i),
.random(Tx1_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst2(
.clk(gt2_txusrclk2_i),
.random(Tx2_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst3(
.clk(gt3_txusrclk2_i),
.random(Tx3_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst4(
.clk(gt4_txusrclk2_i),
.random(Tx4_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst5(
.clk(gt5_txusrclk2_i),
.random(Tx5_PRBS31Gen32b)
);
PRBS31Gen32b PRBS31Gen32b_inst6(
.clk(gt6_txusrclk2_i),
.random(Tx6_PRBS31Gen32b)
);
genvar i;
generate 
    for(i=0;i<32;i=i+1) begin
        assign gt0_txdata_i[i] = Tx0_PRBS31Gen32b[31-i];
        assign gt1_txdata_i[i] = Tx1_PRBS31Gen32b[31-i]; 
        assign gt2_txdata_i[i] = Tx2_PRBS31Gen32b[31-i];
        assign gt3_txdata_i[i] = Tx3_PRBS31Gen32b[31-i];
        assign gt4_txdata_i[i] = Tx4_PRBS31Gen32b[31-i]; 
        assign gt5_txdata_i[i] = Tx5_PRBS31Gen32b[31-i];
        assign gt6_txdata_i[i] = Tx6_PRBS31Gen32b[31-i]; 
    end
endgenerate

//---------------------------------------------------------< PRBS31Gen32b

//---------------------------------------------------------> PRBS31_Data_Checker
wire [63:0] Rx0_Error_bit_Count;
wire [63:0] Rx1_Error_bit_Count;
wire [63:0] Rx2_Error_bit_Count;
wire [63:0] Rx3_Error_bit_Count;
wire [63:0] Rx4_Error_bit_Count;
wire [63:0] Rx5_Error_bit_Count;
wire [63:0] Rx6_Error_bit_Count;
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst0(
.clock(gt0_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt0_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx0_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst1(
.clock(gt1_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt1_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx1_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst2(
.clock(gt2_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt2_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx2_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst3(
.clock(gt3_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt3_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx3_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst4(
.clock(gt4_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt4_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx4_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst5(
.clock(gt5_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt5_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx5_Error_bit_Count)
);
PRBS31_Data_Checker PRBS31_Data_Checker_Rxinst6(
.clock(gt6_rxusrclk2_i),            // Data check clock
.reset(reset),
.DataIn(gt6_rxdata_i),              // 32-bit data
.Error_bit_Count(Rx6_Error_bit_Count)
);
//---------------------------------------------------------< PRBS31_Data_Checker

//---------------------------------------------------------> ila_debug
wire [95:0] probe0 = {gt0_rxdata_i,Rx0_Error_bit_Count};
wire [95:0] probe1 = {gt1_rxdata_i,Rx1_Error_bit_Count};
wire [95:0] probe2 = {gt2_rxdata_i,Rx2_Error_bit_Count};
wire [95:0] probe3 = {gt3_rxdata_i,Rx3_Error_bit_Count};
wire [95:0] probe4 = {gt4_rxdata_i,Rx4_Error_bit_Count};
wire [95:0] probe5 = {gt5_rxdata_i,Rx5_Error_bit_Count};
wire [95:0] probe6 = {gt6_rxdata_i,Rx6_Error_bit_Count};

ila_0 ila_0_inst (
	.clk(gt0_rxusrclk2_i),     // input wire clk
	.probe0(probe0), // input wire [95:0]  probe0  
	.probe1(probe1), // input wire [95:0]  probe1 
	.probe2(probe2), // input wire [95:0]  probe2 
	.probe3(probe3), // input wire [95:0]  probe3 
	.probe4(probe4), // input wire [95:0]  probe4 
	.probe5(probe5), // input wire [95:0]  probe5 
	.probe6(probe6) // input wire [95:0]  probe6
);
//---------------------------------------------------------< ila_debug
endmodule
