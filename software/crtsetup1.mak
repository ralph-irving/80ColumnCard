SRC = crtsetup1.s

all: crtsetup1.bin
	@echo Done.

%.o: %.s
	ca65 --listing "$<".lst --target apple2 -o "$@" "$<"

%.bin: %.o
	ld65 --config apple2-asm.cfg -o "$@" "$<"

clean:
	rm -f crtsetup1.bin crtsetup1.o
