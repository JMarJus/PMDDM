void main() {
  int entero = 1;
  double decimal = 1.1;
  String texto = "hola";
  bool booleano = true;
  dynamic dinamico1 = decimal + entero;
  if (booleano) {
    print("$entero + $decimal = $dinamico1");
    print("$texto");
  }
  print("Tan solo podemos operar entre ellos los enteros y decimales. Las variables de cadena de texto y booleanas no pueden actuar como operandos.");
}