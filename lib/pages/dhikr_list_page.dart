import 'dart:convert';

import 'package:dhikr_app/models/dhikr_model.dart';
import 'package:dhikr_app/pages/dhikr_page.dart';
import 'package:dhikr_app/shared/button/leading_back_button.dart';
import 'package:dhikr_app/shared/button/setting_button.dart';
import 'package:dhikr_app/shared/list_tile/dhikr_list_tile.dart';
import 'package:dhikr_app/static/dhikr_time.dart';
import 'package:dhikr_app/static/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../helpers/ad_helper.dart';
import '../service/language_service.dart';
import '../shared/title/page_title.dart';

class DhikrListPage extends StatefulWidget {
  final String dhikrTime;

  const DhikrListPage({super.key, required this.dhikrTime});

  @override
  State<DhikrListPage> createState() => _DhikrListPage();
}

class _DhikrListPage extends State<DhikrListPage> {
  List<Dhikr> dhikr = [];

  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadDhikr();
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

  Future<void> loadDhikr() async {
    final languageService = context.watch<LanguageService>(); // Listen for language changes
    String? language = languageService.currentLanguage;
    String jsonString = await rootBundle.loadString(
        'assets/dhikr/${widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening'}/dhikr_${widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening'}_${language == Languages.ENGLISH_CODE ? 'en' : 'id'}.json');

    final jsonResponse = json.decode(jsonString);
    List<Dhikr> dhikrs = (jsonResponse as List<dynamic>).map((item) => Dhikr.fromJson(item)).toList();

    setState(() {
      dhikr = dhikrs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const LeadingBackButton(),
        title: PageTitle(text: languageService.getText(widget.dhikrTime == DhikrTime.MORNING ? 'morning' : 'evening')),
        actions: const [
          SettingButton()
        ],
      ),
      body: ListView.builder(
        itemCount: dhikr.length,
        itemBuilder: (context, index) {
          return DhikrListTile(
              index: index,
              dhikr: dhikr[index],
              dhikrList: dhikr,
              dhikrTime: widget.dhikrTime,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DhikrPage(
                              dhikrList: dhikr,
                              initialIndex: index,
                              isMorningDhikr: widget.dhikrTime == DhikrTime.MORNING,
                            )));
              });
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bannerAd != null)
            SafeArea(
                child: SizedBox(
              height: bannerAd!.size.height.toDouble(),
              width: bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: bannerAd!),
            )),
        ],
      ),
    );
  }
}
