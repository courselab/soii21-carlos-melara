

bin = eg-01

all:
	@echo "You need to specify a target"

# Very simple example to illustrate the build steps

eg-01 : % : %.o %.i
	gcc -m32 -Wall $< -o $@
	# ld -melf_i386 /usr/lib/bcc/crt0.o /usr/lib32/crt1.o  $< -o $@

eg-01.o : %.o : %.s
	as -32 $< -o $@

eg-01.s : %.s : %.i
	gcc -Wall -O0 -m32 -masm=intel -fno-pic -fno-asynchronous-unwind-tables -fcf-protection=none -S $< -o $@

eg-01.i : %.i : %.c
	cpp -Wall $< -o $@


# Another build example with static library

main : main.o foobar.h libfoobar.a
	gcc $< -o $@ -L. -lfoobar

libfoobar.a : foo.o bar.o
	ar rcs $@ $^

main.o foo.o bar.o : %.o : %.c 
	gcc -Wall -I. -c $< -o $@

# Disassemble

diss:  $(IMG)
	objdump -M intel -m i386 -d $< ; \




.PHONY: clean

clean:
	rm -f $(bin) *.o *.i *.a main
