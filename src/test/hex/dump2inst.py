
import sys


def main():
    f_dump = open(str(sys.argv[1]), 'r', encoding='utf-8')
    f_hex = open(str(sys.argv[2]), 'w')
    repair_strage = str(sys.argv[3])
    # 为 ret 则需要进行 ret 指令的调整
    # 为 last 则需要对最后的一条指令进行调整
    inst = False    # 是否开始处理指令
    main = False    # 标志进入main函数
    while True:
        buf = f_dump.readline()
        if len(buf) > 0:
            if inst:
                buf = buf.replace('\t', ' ')
                buf_split = buf.split(':', 1)
                if len(buf_split) > 1 and buf_split[0].find('<') == -1:
                    buf_hex = buf_split[1].strip().split(' ', 1)
                    res = buf_hex[0].strip()
                    if res == '00008067' and main and repair_strage == 'ret':
                        f_hex.write('00000000\n')
                    else:
                        need = 8 - len(res)
                        for i in range(0, need):
                            res = '0' + res
                        f_hex.write(res+'\n')
                        # f_hex.write(buf_split[0] + ':' + res+'\n')
                if buf_split[0].find('<main>') != -1:
                    main = True
            elif buf.find('>:') != -1:
                inst = True
                if buf.find('<main>:') != -1:
                    main = True
                else:
                    main = False
        else:
            break
    if repair_strage == 'last':
        f_hex.seek(f_hex.tell() - 9)
        f_hex.truncate()
        f_hex.write('00000000\n')


if __name__ == '__main__':
    main()
