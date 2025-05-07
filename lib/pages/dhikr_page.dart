import 'package:dhikr_app/helpers/ad_helper.dart';
import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/shared/title/page_subtitle.dart';
import 'package:dhikr_app/static/bismillah.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../service/language_service.dart';
import '../shared/button/leading_back_button.dart';
import '../shared/title/page_title.dart';

class DhikrPage extends StatefulWidget {
  const DhikrPage({super.key, required this.dhikrList, required this.initialIndex, required this.isMorningDhikr});

  final List<Dhikr> dhikrList;
  final int initialIndex;
  final bool isMorningDhikr;

  @override
  State<DhikrPage> createState() => _DhikrPage();
}

class _DhikrPage extends State<DhikrPage> {
  late int currentIndex;
  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _loadBannerAd();
  }

  void _loadBannerAd() async {
    final ad = BannerAd(
      adUnitId: await AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() {}),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    ad.load();

    setState(() {
      bannerAd = ad;
    });
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }

  void _goToFirst() {
    setState(() => currentIndex = 0);
  }

  void _goToPrevious() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void _goToNext() {
    if (currentIndex < widget.dhikrList.length - 1) {
      setState(() => currentIndex++);
    }
  }

  void _goToLast() {
    setState(() => currentIndex = widget.dhikrList.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    final Dhikr dhikr = widget.dhikrList[currentIndex];
    final arabicTextColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        leading: const LeadingBackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageSubTitle(text: widget.isMorningDhikr ? languageService.getText('morning') : languageService.getText('evening')),
            PageTitle(text: dhikr.title[languageService.currentLanguage] ?? ''),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            _goToNext();
          } else if (details.primaryVelocity! > 0) {
            _goToPrevious();
          }
        },
        child: ListView(
          children: [
            if (dhikr.readTime != null) ...[_readTimeText(dhikr.readTime!, dhikr.isReadTimeForWholeDay, languageService)],
            if (dhikr.isShowBismillah) ...[
              _bismillahText(Bismillah.BISMILAH, arabicTextColor),
            ],
            _arabicText(dhikr.arabicText, arabicTextColor),
            const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
            if (dhikr.pronounceText != null) ...[
              _latinText(dhikr.pronounceText!),
              const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
            ],
            _latinText(dhikr.translation[languageService.currentLanguage] ?? ''),
            if (dhikr.references.isNotEmpty) ...[
              const Divider(height: 20, thickness: 1, indent: 20, endIndent: 20, color: Colors.grey),
              _referenceText(dhikr.references[languageService.currentLanguage] ?? []),
            ]
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buttonAppBar(languageService, currentIndex + 1, widget.dhikrList.length),
            if (bannerAd != null)
              SizedBox(
                height: bannerAd!.size.height.toDouble(),
                width: bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ),
          ],
        ),
      ),
    );
  }

  _bismillahText(String text, Color arabicTextColor) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(arabicTextColor, BlendMode.srcIn),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'AmiriQuran',
                height: 2,
              ),
            ),
          ),
        ));
  }

  _arabicText(String text, Color arabicTextColor) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(arabicTextColor, BlendMode.srcIn),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 23,
                fontFamily: 'AmiriQuran',
                height: 2.5,
              ),
            ),
          ),
        ));
  }

  _latinText(String text) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 17),
          ),
        ));
  }

  _readTimeText(List<int> readTime, bool isReadTimeForWholeDay, LanguageService languageService) {
    var readTimeString = readTime.length > 1
        ? languageService.getText('readTimeOr').replaceAll('{count1}', readTime[0].toString()).replaceAll('{count2}', readTime[1].toString())
        : languageService.getText('readTime').replaceAll('{count}', readTime[0].toString());

    if (isReadTimeForWholeDay) {
      readTimeString += ' ${languageService.getText('inADayText')}';
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            readTimeString,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.greenAccent : Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ));
  }

  _referenceText(List<String> texts) {
    if (texts.length == 1) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          texts[0],
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 15),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: texts.map((ref) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('\u2022 ', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: Text(
                      ref,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
  }

  _buttonAppBar(LanguageService languageService, int currentIndex, int length) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_left),
              onPressed: currentIndex > 1 ? _goToFirst : null,
              tooltip: languageService.getText('first'),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentIndex > 1 ? _goToPrevious : null,
              tooltip: languageService.getText('previous'),
            ),
            Text('$currentIndex/$length'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: currentIndex < widget.dhikrList.length ? _goToNext : null,
              tooltip: languageService.getText('next'),
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_double_arrow_right),
              onPressed: currentIndex < widget.dhikrList.length ? _goToLast : null,
              tooltip: languageService.getText('last'),
            ),
          ],
        ),
      ),
    );
  }
}
