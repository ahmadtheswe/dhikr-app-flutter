import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String text;
  final IconData? icon;

  const MenuTitle({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.blueGrey;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 24),
            const SizedBox(height: 8),
          ],
          _text(text, textColor),
        ],
      ),
    );
  }

  Text _text(String text, Color textColor) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
