
RISCV ?= /home/labuser/work/MyExperimentWork/RISC-V/riscv64-tools-default
RISCVBIN = $(RISCV)/bin


SOURCES = $(wildcard *.riscv)
OBJECTS = $(SOURCES:%.riscv=%.o)
TESTS = $(SOURCES:%.riscv=%)
DUMP = $(SOURCES:%.riscv=%.dump)
HEX = $(SOURCES:%.riscv=%.hex)

all:$(HEX)

$(OBJECTS): %.o: %.riscv
	$(RISCVBIN)/riscv64-unknown-elf-as -march=rv64i $< -o $@

$(TESTS): %: %.o
	$(RISCVBIN)/riscv64-unknown-elf-ld -Ttext 0x0 -Tdata 0x400 $< -o $@

$(DUMP): %.dump: %.o
	$(RISCVBIN)/riscv64-unknown-elf-objdump -d $< > $@

$(HEX): %.hex: %.dump
	python3 ../dump2hex.py $< $@

clean:
	rm -f *.o
	rm -f *.dump
	rm -f *.hex

print:
	echo -ne $(foreach n, $(TESTS), '("$(n)", "", 0x0),') '\n'
