import 'package:flutter/material.dart';

import '../shared/button/alarm_elevated_button.dart';
import '../static/dhikr_time.dart';

class AlarmWidget extends StatelessWidget {
  final TimeOfDay? morningTime;
  final TimeOfDay? eveningTime;
  final Function(TimeOfDay) onMorningTimeChanged;
  final Function(TimeOfDay) onEveningTimeChanged;

  const AlarmWidget({
    Key? key,
    this.morningTime,
    this.eveningTime,
    required this.onMorningTimeChanged,
    required this.onEveningTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AlarmElevatedButton(
          selectedTime: morningTime,
          dhikrTime: DhikrTime.MORNING,
          onTimeChanged: onMorningTimeChanged,
        ),
        const SizedBox(
          height: 20,
        ),
        AlarmElevatedButton(
          selectedTime: eveningTime,
          dhikrTime: DhikrTime.EVENING,
          onTimeChanged: onEveningTimeChanged,
        ),
      ],
    );
  }
}