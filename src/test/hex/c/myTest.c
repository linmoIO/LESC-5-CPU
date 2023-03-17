int main() {
  int n = 17;
  int a = 1;
  int b = 1;
  int res = 0;
  for (int i = 3; i <= n; i++) {
    res = a + b;
    a = b;
    b = res;
  }
  int result[] = {res};
  return 0;
}