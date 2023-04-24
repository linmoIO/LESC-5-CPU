int fibonacci(int n) {
  if (n == 1 || n == 2) // 数列前两项
  {
    return 1;
  } else // 从第三项开始
  {
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
  return 0;
}

const int RIGHT_ANS = 21;

int main() {
  int n = 8;              // 结果存储在a0寄存器中
  int ret = fibonacci(n); // 计算斐波那契数列
  if (ret == RIGHT_ANS) {
    return 12345678;
  }
  return ret;
}
