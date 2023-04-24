#!/bin/bash

RISCV=riscv64-unknown-elf
# RISCV=riscv64-unknown-linux-gnu
C_DIR=./c
BENCH_MARK_DIR=./c_benchmark

DATA_ADDRESS=0x20000 # 128k, 数据存储在128KB之外

check_input(){
    if [ x"$1" = x ]; then
        echo "无输入文件, 请检查"
        exit
    fi
}

set_env(){
    echo -e "\n==================== \033[45;37m 添加环境变量 \033[0m ===================\n"
    export PATH=$PATH:/home/labuser/work/MyExperimentWork/RISC-V/riscv64-tools-default/bin
    $RISCV-gcc -v
}

complie(){
    SRC=$1
    DIR=$SRC
    SRC_FILE=$2

    echo -e "\n==================== \033[45;37m 清空 $DIR 文件夹 \033[0m ===================\n"
    # rm -f -r $DIR
    mkdir $DIR
    cd $DIR

    rm -f *.hex *.dump *.elf *.bin

    echo -e "\n==================== \033[45;37m 编译 $SRC \033[0m ===================\n"
    if [[ $SRC_FILE =~ \.riscv$ ]]; then # .risc 文件
        cp ../$SRC_FILE ./$SRC
        REPAIR=last
    fi

    if [[ $SRC_FILE =~ \.c$ ]]; then # .c 文件
        $RISCV-gcc -S $SRC_FILE -march=rv64i -mabi=lp64 -malign-data=xlen -mstrict-align -o $SRC.riscv

        $RISCV-as $SRC.riscv -march=rv64i -mabi=lp64 -o $SRC.elf

        $RISCV-ld -e main --no-relax -Ttext 0x0 -Tdata $DATA_ADDRESS $SRC.elf -o $SRC
        REPAIR=ret
    fi

    complie_riscv $SRC $REPAIR

    cd ..
}

complie_riscv(){
    SRC=$1
    REPAIR=$2

    $RISCV-objdump -d $SRC > $SRC.dump

    rm -r -f inst
    mkdir inst
    rm -r -f data
    mkdir data
    python3 ../dump2inst.py $SRC.dump ./inst/$SRC.hex $REPAIR
    $RISCV-objcopy -I elf64-littleriscv -O verilog $SRC $SRC.verilog
    python3 ../verilog2data.py $DATA_ADDRESS $SRC.verilog ./data/$SRC.hex
}

check_input $1

set_env

for file in $C_DIR/*.c
do
    SRC=$(basename "$file" .c)

    if [ "$1" = "all" ] || [ "$1" = "$SRC" ]; then
        complie $SRC ../$C_DIR/$SRC.c
    fi
done

bmarks="median qsort rsort towers vvadd multiply"

for name in $bmarks; do
    if [ "$1" = "all" ] || [ "$1" = "$name" ]; then
        FILE=$BENCH_MARK_DIR/$name.riscv
        if [[ -f "$FILE" ]]; then
            # echo $FILE
            complie $name $FILE
        fi
    fi
done

echo -e "\n==================== \033[45;37m 处理完毕 \033[0m ===================\n"