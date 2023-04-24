static int a = 1;
static int b = 2;
static int n = 27;
static int res = 0;

const int RIGHT_ANS = 317811;

int main() {
  for (int i = 3; i <= n; i++) {
    res = a + b;
    a = b;
    b = res;
  }
  int result[] = {res};
  if (result[0] == RIGHT_ANS) {
    return 12345678;
  }
  return result[0];
}