import "dart:io";

void main() {
  print("Ingresa un valor.");
  double? numero = double.parse(stdin.readLineSync()!);
  for (int i = 0; i < 11; i++) {
    dynamic resultado = numero * i;
    print("$numero * $i = $resultado");
  }
}