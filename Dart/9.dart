import 'dart:io';

class Coche {
  String? _matricula;
  String? modelo;
  
  void setMatricula(matricula) {
    _matricula = matricula;
  }
  String? getMatricula() {
    return _matricula;
  }
  @override
  String toString() {
    return "Coche con matrícula $_matricula y de modelo $modelo";
  }
}

main() {
  print("Se van a registrar los datos de un coche.");
  final coche = Coche();
  print("Ingresa la matrícula del coche:");
  coche.setMatricula(stdin.readLineSync());
  print("Ingresa el modelo del coche:");
  coche.modelo = stdin.readLineSync();
  print(coche.toString());
}