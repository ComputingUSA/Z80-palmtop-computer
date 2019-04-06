l44
q %1.asm
\prg\asm\z80\a80z %1.asm
hex2bin %1.obj %1.bin i
del %1.obj
copy %1.bin d:d
pause
l44
list
cd \cad\eprom
epp-01
cd \cad\project
