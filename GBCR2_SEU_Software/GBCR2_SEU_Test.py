#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import copy
import time
import visa
import datetime
import struct
import socket
from GBCR2_Reg import *
from command_interpret import *
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset
'''
@author: Wei Zhang
@date: 2020-11-14
This script is used to test GBCR2 SEU. It mainly includes I2C communication, Ethernet communication, and eight channels bit error record.
'''
hostname = '192.168.2.3'                # FPGA IP address
port = 1024                             # port number
#------------------------------------------------------------------------------------------------#
## IIC write slave device
# @param mode[1:0] : '0'is 1 bytes read or wirte, '1' is 2 bytes read or write, '2' is 3 bytes read or write
# @param slave[7:0] : slave device address
# @param wr: 1-bit '0' is write, '1' is read
# @param reg_addr[7:0] : register address
# @param data[7:0] : 8-bit write data
def iic_write(mode, slave_addr, wr, reg_addr, data):
    val = mode << 24 | slave_addr << 17 | wr << 16 | reg_addr << 8 | data
    cmd_interpret.write_config_reg(4, 0xffff & val)
    cmd_interpret.write_config_reg(5, 0xffff & (val>>16))
    time.sleep(0.01)
    cmd_interpret.write_pulse_reg(0x0001)           # reset ddr3 data fifo
    time.sleep(0.01)
#---------------------------------------------------------------------------------------------#
## IIC read slave device
# @param mode[1:0] : '0'is 1 bytes read or wirte, '1' is 2 bytes read or write, '2' is 3 bytes read or write
# @param slave[6:0]: slave device address
# @param wr: 1-bit '0' is write, '1' is read
# @param reg_addr[7:0] : register address
def iic_read(mode, slave_addr, wr, reg_addr):
    val = mode << 24 | slave_addr << 17 |  0 << 16 | reg_addr << 8 | 0x00     # write device addr and reg addr
    cmd_interpret.write_config_reg(4, 0xffff & val)
    cmd_interpret.write_config_reg(5, 0xffff & (val>>16))
    time.sleep(0.01)
    cmd_interpret.write_pulse_reg(0x0001)                                     # Sent a pulse to IIC module

    val = mode << 24 | slave_addr << 17 | wr << 16 | reg_addr << 8 | 0x00     # write device addr and read one byte
    cmd_interpret.write_config_reg(4, 0xffff & val)
    cmd_interpret.write_config_reg(5, 0xffff & (val>>16))
    time.sleep(0.01)
    cmd_interpret.write_pulse_reg(0x0001)                                     # Sent a pulse to IIC module
    time.sleep(0.01)                                                          # delay 10ns then to read data
    return cmd_interpret.read_status_reg(0) & 0xff
#---------------------------------------------------------------------------------------------#
## Bit error record
# @param channel: 0-6 represents Rx channel 0-6, 7 represents Tx channel
# @return: channel bit error record number
#---------------------------------------------------------------------------------------------#
def main():
    Slave_Addr = 0x23 

    # Rx channel 1 settings
    GBCR2_Reg1.set_CH1_CML_AmplSel(7)
    GBCR2_Reg1.set_CH1_CTLE_MFSR(10)
    GBCR2_Reg1.set_CH1_CTLE_HFSR(7)

    iic_write_val = GBCR2_Reg1.get_config_vector()

    print(iic_write_val)
    ## write data into I2C register one by one
    for i in range(len(iic_write_val)):
        iic_write(1, Slave_Addr, 0, i, iic_write_val[i])

    iic_read_val = []
    ## read back  data from I2C register one by one
    for i in range(len(iic_write_val)):
        iic_read_val += [iic_read(0, Slave_Addr, 1, i)]
    print(iic_read_val)
    
    if iic_read_val == iic_write_val:
        print("Wrote into data matches with read back data!")
    else:
        print("Wrote into data doesn't match with read back data!")
    print("Ok!")
#------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)   #initial socket
    s.connect((hostname, port))                             #connect socket
    cmd_interpret = command_interpret(s)                    #Class instance
    GBCR2_Reg1 = GBCR2_Reg()                                # New a class
    main()                                                  #execute main function
    s.close()                                               #close socket
