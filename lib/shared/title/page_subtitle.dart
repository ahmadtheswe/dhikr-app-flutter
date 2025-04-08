import 'package:flutter/material.dart';

class PageSubTitle extends StatelessWidget {
  final String text;

  const PageSubTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.blueGrey),
    );
  }
}
