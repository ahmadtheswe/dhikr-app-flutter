import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';

class AlarmElevatedButton extends StatelessWidget {
  final String dhikrTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimeOfDay? selectedTime;
  final double? width;
  final double? height;

  const AlarmElevatedButton({super.key, required this.onTimeChanged, required this.dhikrTime, this.selectedTime, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: Size(width != null ? width! : 250, height != null ? height! : 60), textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () async {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: selectedTime != null ? selectedTime! : TimeOfDay.now(),
          );

          if (pickedTime != null) {
            onTimeChanged(pickedTime);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${dhikrTime == DhikrTime.MORNING ? languageService.getText('morningAlarm') : languageService.getText('eveningAlarm')}: ${selectedTime?.format(context) ?? '--:-- ---'}'),
            const SizedBox(width: 10),
          ],
        ));
  }
}
