#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import copy
import time
import visa
import datetime
import struct
import socket
from usb_iss import UsbIss, defs
from GBCR2_Reg import *
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset
'''
@author: Wei Zhang
@date: 2020-06-03
This script is used for testing GBCR2 chip.
'''
#------------------------------------------------------------------------------------------------#
def capture_screen_image(filename):
    rm = visa.ResourceManager()
    print(rm.list_resources())
    inst = rm.open_resource('GPIB2::7::INSTR')              # connect to SOC
    # print(inst.query("*IDN?"))                              # Instrument ID
    # time.sleep(0.5)

    inst.write("*RST")                                      # reset OSC
    time.sleep(3)

    inst.write(":CHANnel1:DIFFerential ON")                 # Channel 1 and channel 3 differential mode

    inst.write(":AUToscale:VERTical CHAN1")
    time.sleep(1)

    inst.write(":TIMebase:RANGe 2E-9")
    time.sleep(1)

    inst.write(":TRIGger:MODE EDGE")                        # set trigger mode
    # print(inst.query(":TRIGger:MODE?"))
    inst.write(":TRIGger:EDGE:SOURce CHANnel2")             # channel2 is set to Edge trigger source

    inst.write(":DISPlay:PERSistence INFinite")             # Display Persistence Infinite

    # print(inst.query(":HISTogram:MODE?"))
    # time.sleep(1)
    inst.write(":HISTogram:MODE WAVeform")                  # Histogram mode waveform
    time.sleep(0.5)
    inst.write(":HISTogram:AXIS HORizontal")                # Histogram horizontal
    time.sleep(0.5)
    inst.write(":HISTogram:WINDow:SOURce CHANnel1")         # windown source Channel1
    time.sleep(0.5)
    inst.write(":HISTogram:WINDow:LLIMit -600E-12")         #
    time.sleep(0.5)
    inst.write(":HISTogram:WINDow:RLIMit 200E-12")
    time.sleep(1)
    inst.write(":HISTogram:WINDow:BLIMit -1E-3")
    time.sleep(0.5)
    inst.write(":HISTogram:WINDow:TLIMit 1E-3")
    time.sleep(50)


    Hist_Std_Dev = inst.query(":MEASure:HISTogram:STDDev? HISTogram")
    time.sleep(0.5)

    inst.write(':DISK:CDIRectory "D:\GBCR2_Scan_20200603"')         # set screen image store directory
    # inst.write(':DISK:MDIRectory "D:\GBCR2_Scan_20200604"')       # make a directory
    # print(inst.query(":DISK:PWD?"))                                 # current direcotry
    time.sleep(0.5)
    inst.write(':DISK:SAVE:IMAGe "%s",BMP,SCReen'%filename)         # save screen image
    return Hist_Std_Dev
#---------------------------------------------------------------------------------------------#
def main():
    iss = UsbIss()
    iss.open("COM3")
    iss.setup_i2c(clock_khz=100, use_i2c_hardware=True, io1_type=None, io2_type=None)
    I2C_Addr = 0X23
    Chip_ID = 1
    CH_ID = 5
    GBCR2_Reg1 = GBCR2_Reg()
    CH5_Dis_Rx = 0
    CH5_CML_AmplSel = 5
    CH5_Dis_EQ_LF = 0
    CH5_EQ_ATT = 3
    CH5_CTLE_HFSR = 11
    CH5_CTLE_MFSR = 11
    CH5_Dis_DFF = 1
    CH5_Dis_LPF = 0
    with open("Hist_Std_Dev.dat", 'w') as infile:
        for i in range(0,16):
            for j in range(0,16):
                CH5_CTLE_HFSR = i
                CH5_CTLE_MFSR = j
                GBCR2_Reg1.set_CH5_CML_AmplSel(CH5_CML_AmplSel)
                GBCR2_Reg1.set_CH5_CTLE_MFSR(CH5_CTLE_MFSR)
                GBCR2_Reg1.set_CH5_CTLE_HFSR(CH5_CTLE_HFSR)
                filename = "Chip=%1d_CH%1d_Dis_Rx=0_CML_AmplSel=%1d_Dis_EQ_LF=0_EQ_ATT=3_CTLE_HFSR=%02d_CTLE_MFSR=%02d_Dis_DFF=1_Dis_LPF=0"%(Chip_ID,CH_ID,CH5_CML_AmplSel,CH5_CTLE_HFSR,CH5_CTLE_MFSR)
                print(filename)
                Reg_Write_val = GBCR2_Reg1.get_config_vector()
                print(Reg_Write_val)
                iss.i2c.write(I2C_Addr, 0, Reg_Write_val)
                Reg_Read_val = []
                Reg_Read_val = iss.i2c.read(I2C_Addr, 0, 0x20)
                print("GBCR2 I2C Read Back data:")
                print(Reg_Read_val)
                print("\n")
                Hist_Std_Dev = capture_screen_image(filename)
                print(Hist_Std_Dev)
                infile.write("%s %.14f\n"%(filename, float(Hist_Std_Dev)))
    print("Ok!")
#------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    main()
