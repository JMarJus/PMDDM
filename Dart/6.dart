import "dart:io";

void main() {
  print("Vas a ingresar valores diferentes que se visualizarán en un array.");
  print("¿Cuántos valores quieres ingresar?");
  int? cantidad = int.parse(stdin.readLineSync()!);
  var array = <double>{};
  for (int i = 0; i < cantidad; i++) {
  print("Ingresa el valor con posición $i");
  double? numero = double.parse(stdin.readLineSync()!);
  array.add(numero);
  }
  print("Array: $array");
}