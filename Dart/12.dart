// Para generar un número aleatorio en Dart, utilizamos la clase Random, de la librería dart:math.

import 'dart:math';

main() {
  
  // Primero seleccionamos el tipo de variable que nos devolverá este método: Int, Double o Bool.
  bool randomBool = Random().nextBool(); // Nos devuelve true o false aleatoriamente.
  double randomDouble = Random().nextDouble(); // Nos devuelve un valor decimal aleatorio entre 0 y 1.
  
  // Para que nos devuelva un Int, debemos especificar el rango. Esto lo hacemos escribiendo la cantidad mínima sumada tras el método, y la cantidad máxima dentro del segundo paréntesis, una vez substraida la cantidad mínima de este valor.
  int randomInt = Random().nextInt(10) + 10; // Nos devuelve un valor decimal aleatorio entre 10 y 20.
  int random = Random().nextInt(11) + 1; // Nos devuelve lo pedido por el ejercicio: un valor aleatorio entre 1 y 10.

  print("$randomBool $randomDouble $randomInt $random");
}