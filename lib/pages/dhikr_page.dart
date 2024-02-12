import 'package:dhikr_app/model/Dhikr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DhikrPage extends StatelessWidget {
  const DhikrPage({super.key, required this.dhikr});

  final Dhikr dhikr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dhikr.title),
      ),
    );
  }
}
