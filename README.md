# DeadFish to binary (.bin) compiler
Written for educational purposes
## about
- AMD64 Assembly
- no libraries needed
- needs NASM assembler to compile
- runs only on Linux 64 bit (compiler, not binary file)
## preparation for use
``` shell
git clone https://github.com/Hukasx0/deadfish-binary-compiler
cd deadfish-binary-compiler/
chmod +x compile.sh && ./compile.sh
```
## usage
``` shell
./dfBinaryCompiler [dfCodeFile].df [fileName].bin
```
## How to execute .bin file?
- on your hardware
- on virtual machine
``` shell
qemu-system-x86_64 [fileName].bin
```