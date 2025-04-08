import 'package:flutter/material.dart';

class StandardElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const StandardElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size(250, 60), textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(width: 10),
          ],
        ));
  }
}
