import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String text;

  const MenuTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {

    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.blueGrey;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ))
    );
  }
}
