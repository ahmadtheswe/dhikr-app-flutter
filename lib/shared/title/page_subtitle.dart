import 'package:flutter/material.dart';

class PageSubTitle extends StatelessWidget {
  final String text;

  const PageSubTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.blue;
    return Text(
      text,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
    );
  }
}
