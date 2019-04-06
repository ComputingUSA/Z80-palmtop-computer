Here is the code for a Zilog Z80 based palm-top computer I designed and built back in 1993 for around $50.
I designed and built it because I wanted a portable computer, but since I was just a student studying electrical engineering, I couldn't afford to buy one :)

"Z80OS2.ASM" is my main OS image :)
KBENCODR.ROM is the ROM mapping for the keyboard circuit.
The TXT files are just pinouts for the chips I needed to build the computer circuits.
JMCO0793.WKS is a Lotus 1-2-3 clone spreadsheet for the parts order from Jameco. The Z80 microprocessor cost only $1.49, and I could barely even afford that back then.

I used a Z80 MCU + static RAM + EPROM to contain the operating system that I wrote. I also based the keyboard circuit on another EPROM and LCD was connected using the serial interface using it's Hitachi chipset to the Intel 8255 PPI. Input was via a membrane numeric keypad and output was to a 2 column LCD display.

I wrote the operating system in Z80 Assembler and I designed it in a way similar to how PC operating systems were written at the time, using establised subroutines to handle basic input and output (a BIOS). I used the a80z Z80 cross-assembler and uploaded the object file to a Jameco EPROM programmer.

I also burned 2 applications on to the EPROM: one to read/write I/O control lines and another to test the keyboard and display. I also had a help screen option. These were selectable via menus with the keypad and LCD.

This includes the source code and binaries to the small operating system I wrote and EPROM image of the keyboard encoder I designed.

The built-in help screen says: "This operating system is meant to provide a kernal of routines to support the IO from this computer device. IO is based around an 8255 PPI. The LCD uses port pins b0-b7, c0, and c2. The keypad, with an onboard EPROM keymap, uses c4-c7 of the PPI. The 8255 is based at control ports 00h-03h. Port A is freely available for any use. Left and right LCD scrolling is availiable through * and # keys - Peter Ungsunan 1993. "


Z80 CPU Board:

Date: 01/08/93.
ICs: Z80 CPU, 6116, 2716. 7805 Voltage Regulator on Board.
External Bus Pinout:

        1 Ground         2 +5v
        3 D0             4 D1
        5 D2             6 D3
        7 D4             8 D5
        9 D6            10 D7
       11 -WR           12 -RD
       13 -MEMRQ        14 -IORQ
       15 -INT          16 A0
       17 A1            18 A2
       19 A3            20 A4
       21 A5            22 A6
       23 A7            24 A8
       25 A9            26 A10
[(-) before a pin function means negative logic.]

Memory Map:

        0000-07FF       2716 EPROM
        0800-0FFF       6116 Static RAM

Switches:
        Monomentary On  Reset

Indicators:
        Red     Power
