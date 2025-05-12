import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  final EdgeInsets? margin;
  final bool? isIconOnTop;

  const MenuTitle({super.key, required this.text, this.icon, this.margin, this.isIconOnTop = false});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.blueGrey;

    return Container(
        margin: margin ?? const EdgeInsets.only(bottom: 20),
        child: isIconOnTop == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) _iconButton(icon!, textColor),
                  _text(text, textColor),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) _iconButton(icon!, textColor),
                  Flexible(child: _text(text, textColor)),
                ],
              ));
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

  IconButton _iconButton(IconData icon, Color textColor) {
    return IconButton(
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
    );
  }
}
