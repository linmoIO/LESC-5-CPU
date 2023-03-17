SRC=$1
DIR=$SRC
RISCV=riscv64-unknown-elf
# RISCV=riscv64-unknown-linux-gnu
SRC_C=../c/$SRC.c

if [ x"$1" = x ]; then
    echo "无输入文件, 请检查"
    exit
fi


echo -e "\n==================== \033[45;37m 添加环境变量 \033[0m ===================\n"
export PATH=$PATH:/home/labuser/work/MyExperimentWork/RISC-V/riscv64-tools-default/bin
$RISCV-gcc -v

echo -e "\n==================== \033[45;37m 清空 \033[0m ===================\n"
# rm -f -r $DIR
mkdir $DIR
cd $DIR

rm -f *.hex *.dump *.elf *.bin

echo -e "\n==================== \033[45;37m 编译 $SRC \033[0m ===================\n"
$RISCV-gcc -S $SRC_C -march=rv64i -mabi=lp64 -malign-data=xlen -mstrict-align -o $SRC.riscv
# $RISCV-gcc -S ../$SRC.c -o $SRC.riscv
$RISCV-as  $SRC.riscv -march=rv64i -mabi=lp64 -o $SRC.elf

$RISCV-ld -e 0x98 -Ttext 0x0 -Tdata 0x400  $SRC.elf -o $SRC

$RISCV-objdump -d $SRC > $SRC.dump

rm -r -f inst
mkdir inst
rm -r -f data
mkdir data
python3 ../dump2inst.py $SRC.dump ./inst/$SRC.hex
$RISCV-objcopy -I elf64-littleriscv -O verilog $SRC.elf $SRC.verilog
python3 ../verilog2data.py 0x400 $SRC.verilog ./data/$SRC.hex