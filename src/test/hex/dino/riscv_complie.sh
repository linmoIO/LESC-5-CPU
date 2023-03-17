OPT=$1
SRC=src
TARGET=target
RISCV=riscv64-unknown-elf
SRC_RISCV=$(find ./$SRC -type f -name "*.riscv")

if [ x"$1" = x ]; then
    echo "无指定操作, 请检查"
    echo "all:创建   clean:清除"
    exit
fi

if [ $1 = "print" ]; then
    for n in $SRC_RISCV
    do
        name=$(basename $n .riscv)
        echo -ne "(\"src/test/hex/dino/target/$name\", \"$name\", 0x0),\n"
    done
fi

if [ $1 = "all" ]; then
    cd $TARGET

    echo -e "\n==================== \033[45;37m 添加环境变量 \033[0m ===================\n"
    export PATH=$PATH:/home/labuser/work/MyExperimentWork/RISC-V/riscv64-tools-default/bin
    $RISCV-gcc -v

    echo -e "\n==================== \033[45;37m 开始遍历处理 \033[0m ===================\n"
    for n in $SRC_RISCV
    do
        name=$(basename $n .riscv)
        echo -e "[INFO] deal with $name"
        mkdir $name # 创建文件夹
        cp ../$SRC/$name.riscv $name/ # 把*.riscv copy 到文件夹里

        # 进入文件夹
        cd $name
        rm -f *.hex *.dump *.elf *.bin # 清空

        # 编译
        $RISCV-as  $name.riscv -march=rv64i -mabi=lp64 -o $name.elf
        $RISCV-ld -Ttext 0x0 -Tdata 0x400  $name.elf -o $name
        $RISCV-objdump -d $name > $name.dump

        rm -r -f inst
        mkdir inst
        rm -r -f data
        mkdir data

        python3 ../../../dump2inst.py $name.dump ./inst/$name.hex
        $RISCV-objcopy -I elf64-littleriscv -O verilog $name.elf $name.verilog
        python3 ../../../verilog2data.py 0x400 $name.verilog ./data/$name.hex

        # 退出文件夹
        cd ..
        # exit
    done;
fi
