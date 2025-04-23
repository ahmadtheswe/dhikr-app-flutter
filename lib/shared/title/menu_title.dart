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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              IconButton(
                icon: Icon(
                  icon,
                  color: textColor,
                  size: 30,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  maxWidth: 30,
                  maxHeight: 30,
                ),
                onPressed: () {},
              ),
            Flexible(
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible)),
          ],
        ));
  }
}
