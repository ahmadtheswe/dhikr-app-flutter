import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String text;

  const MenuTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ));
  }
}
