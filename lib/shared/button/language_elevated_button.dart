import 'package:flutter/material.dart';

class LanguageElevatedButton extends StatelessWidget {
  final String languageTitle;
  final String icon;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const LanguageElevatedButton({
    super.key,
    required this.languageTitle,
    required this.icon,
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
          fixedSize: Size(width != null ? width! : 270, height != null ? height! : 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageTitle,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            ClipOval(
              child: Image.asset(
                icon,
                package: 'country_icons',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          ],
        ));
  }
}
