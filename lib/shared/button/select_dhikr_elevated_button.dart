import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:flutter/material.dart';

class SelectDhikrElevatedButton extends StatelessWidget {
  final String text;
  final String dhikrTime;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const SelectDhikrElevatedButton({
    super.key,
    required this.text,
    required this.dhikrTime,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            backgroundColor: backgroundColor),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              dhikrTime == DhikrTime.MORNING ? 'assets/icons/icons8/morning-office-l/icons8-morning-100.png' : 'assets/icons/icons8/evening-office-l/icons8-evening-100.png',
              width: 100,
              height: 100,
            ),
            Text(text, style: TextStyle(color: textColor)),
          ],
        ));
  }
}
