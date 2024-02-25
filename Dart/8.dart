import 'dart:io';

class Coche {
  String? matricula;
  String? modelo;
  
  @override
  String toString() {
    return "Coche con matrícula $matricula y de modelo $modelo";
  }
}

main() {
  print("Se van a registrar los datos de un coche.");
  final coche = Coche();
  print("Ingresa la matrícula del coche:");
  coche.matricula = stdin.readLineSync();
  print("Ingresa el modelo del coche:");
  coche.modelo = stdin.readLineSync();
  print(coche.toString());
}