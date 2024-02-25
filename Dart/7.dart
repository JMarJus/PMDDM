void main() {
  print("Creación de un array del 1 al 50.");
  var arrayNormal = <int>{};
  for (int i = 1; i < 51; i++) {
    arrayNormal.add(i);
  }
  print("Array completo: $arrayNormal");
  print("Selección de números divisibles entre 3.");
  var arrayDivisibles = <int>{};
  for (int i = 1; i < 51; i++) {
    if (i%3 == 0) {
      arrayDivisibles.add(i);
    }
  }
  print("Array reducido: $arrayDivisibles");
}