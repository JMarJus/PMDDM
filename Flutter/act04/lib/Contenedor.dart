import 'package:flutter/material.dart';

class Contenedor extends StatelessWidget {
  final color;
  final alto;
  final ancho;
  final texto;
  final padding;
  final alignmentX;
  final alignmentY;

  Contenedor(this.color, this.alto, this.ancho, this.texto, this.padding,
      this.alignmentX, this.alignmentY);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: this.color,
        width: this.ancho,
        height: this.alto,
        child: Center(
          child: Text(this.texto),
        ),
        padding: EdgeInsetsDirectional.all(this.padding),
        alignment: Alignment(this.alignmentX, this.alignmentY));
  }
}
