set -xe
nasm -f elf64 -o dfBinaryCompiler.o dfBinaryCompiler.asm
ld -o dfBinaryCompiler dfBinaryCompiler.o
rm dfBinaryCompiler.o
