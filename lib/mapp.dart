import 'dart:async';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyou_b2b/models/Theme.dart';

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstStart();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // getSavedTheme();
  }

  getSavedTheme() async {
    final _theme = await MyThemes.getSavedTheme();
    try {
      DynamicTheme.of(context).setThemeData(_theme);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(width: 20.0, height: 100.0),
                  Text(
                    "The day of life starts",
                    style: TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(width: 20.0, height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        "SIYOU !",
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Theme.of(context).primaryColorDark,
                            fontFamily: 'Siyou',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            ),
            /*Center(
              child: Image.asset(
                "assets/png/logo_siyou-02.png",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),*/
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SafeArea(
                  child: Text(
                    "All rights reserved. copyright © SIYOU 2020",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future checkFirstStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('firstStart') ?? false);

    if (_seen) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/", (Route<dynamic> route) => false);
    } else {
//      prefs.setBool('firstStart', true);
      Navigator.pushNamedAndRemoveUntil(
          context, "/", (Route<dynamic> route) => false);
      /*Navigator.pushNamedAndRemoveUntil(
          context, "/onboarding", (Route<dynamic> route) => false);*/
    }
  }
}

class LanguageProvider extends StatelessWidget {
  final Widget child;

  const LanguageProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: child,
    );
  }
}
