import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final logoColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;

    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 10.0),
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: IconButton(
          icon: Icon(
            Icons.turn_left,
            color: logoColor,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            maxWidth: 35,
            maxHeight: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
