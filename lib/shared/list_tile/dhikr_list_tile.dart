import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/dhikr_page.dart';
import '../../service/language_service.dart';
import '../../static/dhikr_time.dart';

class DhikrListTile extends StatelessWidget {
  final int index;
  final Dhikr dhikr;
  final List<Dhikr> dhikrList;
  final String dhikrTime;
  final VoidCallback onTap;

  const DhikrListTile({super.key, required this.index, required this.dhikr, required this.dhikrList, required this.dhikrTime, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final listTextColor = Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.blueGrey;
    final numberingTextColor = Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: listTextColor, width: 0.5),
          bottom: BorderSide(color: listTextColor, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: listTextColor,
          child: Text('${index + 1}', style: TextStyle(color: numberingTextColor, fontWeight: FontWeight.bold)),
        ),
        title: Text(dhikr.title[languageService.currentLanguage] ?? '', style: TextStyle(color: listTextColor, fontWeight: FontWeight.bold)),
        subtitle: dhikr.readTime != null
            ? Text(
                _readTimeText(dhikr.readTime!, dhikr.isReadTimeForWholeDay, languageService),
                style: TextStyle(color: listTextColor),
              )
            : const Text(''),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DhikrPage(
                        dhikrList: dhikrList,
                        initialIndex: index,
                        isMorningDhikr: dhikrTime == DhikrTime.MORNING,
                      )));
        },
      ),
    );
  }

  _readTimeText(List<int> readTime, bool isReadTimeForWholeDay, LanguageService languageService) {
    var readTimeString = readTime.length > 1
        ? languageService.getText('readTimeOr').replaceAll('{count1}', readTime[0].toString()).replaceAll('{count2}', readTime[1].toString())
        : languageService.getText('readTime').replaceAll('{count}', readTime[0].toString());

    if (isReadTimeForWholeDay) {
      readTimeString += ' ${languageService.getText('inADayText')}';
    }

    return readTimeString;
  }
}
