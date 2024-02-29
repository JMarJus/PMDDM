import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exporter.dart';

class Button extends ConsumerWidget {
  const Button({Key? key, this.text, this.icon, required this.onPressed})
      : super(key: key);

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (icon != null) {
      // Undo, Restart and Exit buttons
      return Container(
          decoration: BoxDecoration(
              color: scoreColor, borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              color: textColorWhite,
              onPressed: onPressed,
              icon: Icon(icon, size: 24)));
    }
    // Try Again button
    return ElevatedButton(
        style: ButtonStyle(
            padding:
                MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor)),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }
}
