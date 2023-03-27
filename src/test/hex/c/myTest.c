int a = 1;
int b = 2;
int n = 27;
int res = 0;

int main() {
  for (int i = 3; i <= n; i++) {
    res = a + b;
    a = b;
    b = res;
  }
  int result[] = {res};
  return result[0];
}