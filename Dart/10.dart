class Vehiculo {
  String? matricula;
  String? modelo;
}

class Coche extends Vehiculo {
  String? varExCoche;
  String? matricula = "1234BCD"; // no creo que sea lógico hacer esto para el funcionamiento hipotético de la aplicación pero no queda otra
}

class Motocicleta extends Vehiculo {
  String? varExMoto;
  String? modelo = "no sé modelos de motos lmao";
}