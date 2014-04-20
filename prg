nsm -f elf -o hello.o $1
ld -m elf_i386 -s -o hello hello.o
./hello
