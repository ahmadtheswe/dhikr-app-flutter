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
    final backgroundColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;
    final buttonWidth = width ?? 270;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(buttonWidth, height ?? 60),
          maximumSize: Size(buttonWidth, double.infinity),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          backgroundColor: backgroundColor,
        ),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              dhikrTime == DhikrTime.MORNING ? Icons.sunny : Icons.wb_twilight,
              color: textColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                '${dhikrTime == DhikrTime.MORNING ? languageService.getText('morningAlarm') : languageService.getText('eveningAlarm')}: ${selectedTime?.format(context) ?? '--:-- ---'}',
                softWrap: true,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ));
  }
}
