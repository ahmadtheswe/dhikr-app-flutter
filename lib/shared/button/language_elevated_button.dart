import 'package:flutter/material.dart';

class LanguageElevatedButton extends StatelessWidget {
  final String languageTitle;
  final String languageCode;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const LanguageElevatedButton({
    super.key,
    required this.languageTitle,
    required this.languageCode,
    this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;
    final buttonWidth = width ?? 270;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(buttonWidth, height ?? 60),
          maximumSize: Size(buttonWidth, double.infinity),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                languageTitle,
                softWrap: true,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: textColor,
              child: Text(
                languageCode.toUpperCase(),
                style: TextStyle(color: backgroundColor, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            )
          ],
        ));
  }
}
