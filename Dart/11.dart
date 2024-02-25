import 'dart:io';

class Persona {
  String? nombre;
  String? apellidos;
  String? dni;
  String? direccion;
  String? cp;
  String? ciudad;
  int fechaNacimiento = 0;
}

class Alumno extends Persona {
  String? codAlumno;
  String? estudios;
  String? curso;
  int edad = 0;
}

main() {
  bool loop = true;
  List<Persona> personas = ([]);
  List<Alumno> alumnos = ([]);
  while (loop) {
    print("¿Quieres registrar a una nueva persona (0), a un alumno a partir de una persona ya existente (1), o comprobar los datos de alguien (2)?");
    int? registro = int.parse(stdin.readLineSync()!);
    if (registro == 0) {
      var currentPersona = new Persona();
      print("Ingresa su nombre.");
      currentPersona.nombre = stdin.readLineSync()!;
      print("Ingresa sus apellidos.");
      currentPersona.apellidos = stdin.readLineSync()!;
      print("Ingresa su DNI.");
      currentPersona.dni = stdin.readLineSync()!;
      print("Ingresa su dirección.");
      currentPersona.direccion = stdin.readLineSync()!;
      print("Ingresa su código postal.");
      currentPersona.cp = stdin.readLineSync()!;
      print("Ingresa su ciudad.");
      currentPersona.ciudad = stdin.readLineSync()!;
      print("Ingresa su fecha de nacimiento (año).");
      currentPersona.fechaNacimiento = int.parse(stdin.readLineSync()!);
      personas.add(currentPersona);
    } else if (registro == 1) {
      print("Ingresa el dni de la persona que quieres registrar como alumno.");
      String currentDni = stdin.readLineSync()!;
      for (int i = 0; i < personas.length; i++) {
        if (personas[i].dni == currentDni) {
          String? nombre = personas[i].nombre;
          String? apellidos = personas[i].apellidos;
          String? dni = personas[i].dni;
          print("Se registrará a $nombre $apellidos con DNI $dni como alumn@.");
          var currentAlumno = new Alumno();
          currentAlumno.nombre = personas[i].nombre;
          currentAlumno.apellidos = personas[i].apellidos;
          currentAlumno.dni = personas[i].dni;
          currentAlumno.direccion = personas[i].direccion;
          currentAlumno.cp = personas[i].cp;
          currentAlumno.ciudad = personas[i].ciudad;
          currentAlumno.fechaNacimiento = personas[i].fechaNacimiento;
          print("Ingresa su código de alumno.");
          currentAlumno.codAlumno = stdin.readLineSync()!;
          print("Ingresa sus estudios.");
          currentAlumno.estudios = stdin.readLineSync()!;
          print("Ingresa su curso.");
          currentAlumno.curso = stdin.readLineSync()!;
          currentAlumno.edad = 2023 - personas[i].fechaNacimiento;
          alumnos.add(currentAlumno);
        }
      }
    } else if (registro == 2) {
      print("Ingresa el dni de quien cuyos datos quieres comprobar.");
      String currentDni = stdin.readLineSync()!;
      for (int i = 0; i < personas.length; i++) {
        if (personas[i].dni == currentDni) {
          String? nombre = personas[i].nombre;
          String? apellidos = personas[i].apellidos;
          String? direccion = personas[i].direccion;
          String? cp = personas[i].cp;
          String? ciudad = personas[i].ciudad;
          int? fechaNacimiento = personas[i].fechaNacimiento;
          print("Nombre completo: $nombre $apellidos.");
          print("Fecha de nacimiento: $fechaNacimiento.");
          print("Ciudad: $ciudad.");
          print("Código postal: $cp.");
          print("Dirección: $direccion.");
          if (alumnos[i].dni == currentDni) {
            String? codAlumno = alumnos[i].codAlumno;
            String? estudios = alumnos[i].estudios;
            String? curso = alumnos[i].curso;
            int? edad = alumnos[i].edad;
            print("Código de alumn@: $codAlumno.");
            print("Edad: $edad.");
            print("Estudios: $estudios.");
            print("Curso: $curso.");
          }
        }
      }
    } else {
      print("Debes ingresar 0, 1 o 2.");
    }
  }
}