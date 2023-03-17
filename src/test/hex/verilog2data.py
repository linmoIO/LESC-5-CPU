
import random
import sys


def main():
    data_index = int(sys.argv[1], 16)
    f_verilog = open(str(sys.argv[2]), 'r', encoding='utf-8')
    f_hex = open(str(sys.argv[3]), 'w')
    inst = False # 是否进入inst
    data = False # 是否进入data

    # # 填入前 0x400 的数据
    # for i in range(0, data_index, 8):
    #     number = random.randint(7,0xfffffffffffffffff)
    #     # f_hex.write('0000000000000000\n')
    #     f_hex.write('{:016X}\n'.format(number % 0xffffffffffffffff))

    while True:
        buf = f_verilog.readline()
        if len(buf) > 0:
            if data:
                buf = buf.replace(' ','')
                buf = buf.replace('\n','')
                if len(buf) > 0 :
                    need = 16 - len(buf)
                    for i in range(0, need):
                        buf = buf + '0'
                    for i in range(0, len(buf)-1, 16):
                        hex_data = buf[i:i+2]
                        hex_data = buf[i+2:i+4] + hex_data
                        hex_data = buf[i+4:i+6] + hex_data
                        hex_data = buf[i+6:i+8] + hex_data
                        hex_data = buf[i+8:i+10] + hex_data
                        hex_data = buf[i+10:i+12] + hex_data
                        hex_data = buf[i+12:i+14] + hex_data
                        hex_data = buf[i+14:i+16] + hex_data
                        f_hex.write(hex_data + '\n')
            elif inst:
                if buf.find('@') != -1:
                    data = True
                    # 填入前 0x400 的数据
                    for i in range(0, data_index, 8):
                        f_hex.write('0000000000000000\n')
            elif buf.find('@') != -1:
                inst = True
        else:
            break

    # # 填入后 0x400 的数据
    # for i in range(0, data_index, 8):
    #     number = random.randint(7,0xfffffffffffffffff)
    #     # f_hex.write('0000000000000000\n')
    #     f_hex.write('{:016X}\n'.format(number % 0xffffffffffffffff))


if __name__ == '__main__':
    main()