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

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width != null ? width! : 270, height != null ? height! : 60),
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
            IconButton(
              icon: Icon(
                dhikrTime == DhikrTime.MORNING ? Icons.sunny : Icons.wb_twilight,
                color: textColor,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                maxWidth: 20,
                maxHeight: 20,
              ), onPressed: () {  },
            ),
            Text(
                '${dhikrTime == DhikrTime.MORNING ? languageService.getText('morningAlarm') : languageService.getText('eveningAlarm')}: ${selectedTime?.format(context) ?? '--:-- ---'}',
                style: TextStyle(color: textColor)),
            const SizedBox(width: 10),
          ],
        ));
  }
}
