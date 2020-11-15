## GBCR2 SEE/SEU Test firmware and software development
  - GBCR2 is a gigabit transceiver ASIC for the Phase-II upgrade of the ATLAS Inner Tracker pixel detector. It consists of seven uplink channels that works at 1.28 Gbps and two downlink channels that works at 160 Mbps.
  - This repo is used to management GBCR2 SEU/SEE test firmware and software. we will detailed introduce firmware and software structure in below sections 
  - During SEU/SEE test, we will test all the seven uplink channels and one downlink channel and record bit error number for each channel.

### GBCR2 SEE/SEU test firmware 
#### 1.**Hardware platform**
  - The Xilinx KC705 EVB was chosen as a controller that generates PRBS31 signal, sends the signal for each uplink and downlink channel, receives GBCR2 output signals, and finally reocrds bit error number in received signals.
  - The KC705 EVB picture is shown as below:
  ![KC705 EVB Picture](https://github.com/weizhangccnu/Python_Script/blob/master/ETROC1_TDC_Test_Software/Img/KC705_EVB.png)
  - The PC was connected with KC705 EVB through 1000M ethernet cable and can read each channel bit error number. The IP address of KC705 is `192.168.2.x`, the x is configurable via switch(DIP switch SW11 positions 1 and 2 control the value of x)

### GBCR2 SEE/SEU test software
