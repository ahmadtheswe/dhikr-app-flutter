import 'package:flutter/material.dart';

class LanguageElevatedButton extends StatelessWidget {
  final String languageTitle;
  final String icon;
  final VoidCallback? onPressed;

  const LanguageElevatedButton({
    super.key,
    required this.languageTitle,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size(250, 60)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languageTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
