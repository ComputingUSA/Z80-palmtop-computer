Here is the code for a z80 based palm-top computer I designed and built back in 1993.

I used a z80 MCU + static RAM and EPROM to contain the operating system that I wrote.

I wrote the operating system in Z80 Assembler and I designed it in a way similar to how PC operating systems were written at the time,
using establised subroutines to handle basic input and output (a BIOS). I used the a80z Z80 cross-assembler and uploaded the object file to my Jameco EPROM programmer.

I also burned 2 applications on to the EPROM: one to read I/O control lines and another to test the keyboard and display.

Input was via a membrane numeric keypad mapped through another EPROM, and output was to a 2 column LCD display based on a standard Hitachi chipset.

This includes the source code and binaries to the small operating system I wrote and EPROM image of the keyboard encoder I designed.

The WKS file is Lotus spreadsheet for parts order from Jameco.
The Z80 microprocessor cost only $1.49, so I bought 2 just in case!
The TXT files are just pinouts for the chips I needed to build the computer circuits.

"Z80OS2.ASM" is my main OS image :)
