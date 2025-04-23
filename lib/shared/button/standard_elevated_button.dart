import 'package:flutter/material.dart';

class StandardElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final IconData? icon;

  const StandardElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width != null ? width! : 270, height != null ? height! : 60),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: icon != null ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (icon != null)
              IconButton(
                icon: Icon(
                  icon,
                  color: textColor,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  maxWidth: 20,
                  maxHeight: 20,
                ),
                onPressed: () {},
              ),
            Text(text, style: TextStyle(color: textColor)),
            const SizedBox(width: 10),
          ],
        ));
  }
}
