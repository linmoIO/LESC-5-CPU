int fibonacci(int n) {
  if (n == 1 || n == 2) { // 数列前两项
    return 1;
  } else { // 从第三项开始
    int a = 1;
    int b = 1;
    int res = 0;
    for (int i = 3; i <= n; i++) {
      res = a + b;
      a = b;
      b = res;
    }
    return res;
  }
}

int main() {
  int n = 17;
  int ret = fibonacci(n); // 计算斐波那契数列
  return ret;             // 结果存在a0寄存器中
}