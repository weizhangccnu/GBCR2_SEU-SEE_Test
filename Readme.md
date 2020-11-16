## GBCR2 SEE/SEU Test firmware and software development
  - GBCR2 is a gigabit transceiver ASIC for the Phase-II upgrade of the ATLAS Inner Tracker pixel detector. It consists of seven uplink channels that works at 1.28 Gbps and two downlink channels that works at 160 Mbps.
  - This repo is used to management GBCR2 SEU/SEE test firmware and software. we will detailed introduce firmware and software structure in below sections. 
  - During SEU/SEE test, we will test all the seven uplink channels and one downlink channel and record bit error number for each channel.

### GBCR2 SEE/SEU test firmware 
#### 1. **Hardware platform**
  - The Xilinx KC705 EVB was chosen as a controller that generates PRBS31 signal, sends the signal for each uplink and downlink channel, receives GBCR2 output signals, and finally reocrds bit error number in received signals.
  - The KC705 EVB picture is shown as below:
  ![KC705 EVB Picture](https://github.com/weizhangccnu/Python_Script/blob/master/ETROC1_TDC_Test_Software/Img/KC705_EVB.png)
  - The PC was connected with KC705 EVB through 1000M ethernet cable and can read each channel bit error number. The IP address of KC705 is `192.168.2.x`, the x is configurable via switch (DIP switch SW11 positions 1 and 2 control the value of x)
  - An I2C master is implemented into the FPGA (on KC705 EVB) to configure GBCR2 chip. The I2C interface (on connector **J46** at KC705 EVB) mapping is shown in below figure:
  ![I2C interface Mapping](https://github.com/weizhangccnu/Python_Script/blob/master/ETROC1_TDC_Test_Software/Img/I2C_Interface_Mapping.png)
  - Seven GT (gigabit transceiver) are used to sent PRBS31 signal for each uplink channel and receive uplink channel output signal. The seven GT are wired to the PCI Express x8 endpoint edge connector (P1) fingers. We used a PCIe extension board to convert the edge fingers to SMA connectors that are easy to connect with GBCR2 test board.
#### 2. **Firmware design**
  * The firmware for GBCR2 SEU/SEE test is composed by uplink channel data checker module, downlink channel data checker module, I2C module, control_interface module, and ethernet module.
  * The uplink channel date checker module includes seven PRBS31 generator, seven GTXs (X0Y0, X0Y1, ..., X0Y6), and seven PRBS31 bit error checker.
  * The downlink channel data checker module includes one PRBS31 generator, one 32:1 serializer, one 1:32 deserializer, and one PRBS31 bit error checker.
  * An I2C master was implemented into the FPGA to configure I2C target in GBCR2 chip.
  * The ethernet module is used to provide 1000M TCP/IP interface between FPGA and PC.
### GBCR2 SEE/SEU test software
