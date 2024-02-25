import "dart:io";

void main() {
  print("Vas a ingresar valores que se visualizarán en un array.");
  print("¿Cuántos valores quieres ingresar?");
  int? cantidad = int.parse(stdin.readLineSync()!);
  var array = []..length = cantidad;
  for (int i = 0; i < cantidad; i++) {
  print("Ingresa el valor con posición $i");
  double? numero = double.parse(stdin.readLineSync()!);
  array[i] = numero;
  }
  print("Array: $array");
}