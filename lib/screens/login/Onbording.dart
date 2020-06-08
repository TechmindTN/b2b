

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyou_b2b/libs/fancy_on_boarding.dart';
import 'package:siyou_b2b/libs/page_model.dart';


class OnboardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final lang = AppLocalizations.of(context);

    final pageList = [
      PageModel(
          color: const Color(0xFFe10a25),
          heroAssetPath: 'assets/png/Dior1.jpg',
          title: Text(lang.tr('Dior'),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 34.0,
              )),
          body: Text(lang.tr('onBoardingScreen.view1'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          iconAssetPath: 'assets/svg/card.svg'),
      PageModel(
          color: const Color(0xFFe10a25),
          heroAssetPath: 'assets/svg/undraw_data_primary.svg',
          title: Text(lang.tr('onBoardingScreen.titleView2'),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 34.0,
              )),
          body: Text(lang.tr('onBoardingScreen.view2'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          iconAssetPath: 'assets/svg/card.svg'),
      PageModel(
        color: const Color(0xFFe10a25),
        heroAssetPath: 'assets/svg/undraw_finance.svg',
        title: Text(lang.tr('onBoardingScreen.titleView3'),
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(lang.tr('onBoardingScreen.view3'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/svg/cart.svg',
      ),
    ];

    return Scaffold(
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '//',
        onDone: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('firstStart', true);
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
    );
  }
}
