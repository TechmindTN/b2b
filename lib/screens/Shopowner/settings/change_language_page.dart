
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

import '../../../main.dart';

class ChangeLanguagePage extends StatefulWidget {
  @override
  _ChangeCountryPageState createState() => _ChangeCountryPageState();
}

class _ChangeCountryPageState extends State<ChangeLanguagePage> {
  List<String> languages = [
    'Chinesse',
    'Spanish',
    'English',
    'Romanian',
    'German',
    'Portuguese',
    'Bengali',
    'Russian',
    'Japanese',
    'French',
  ];
  final mList = MyApp.list.map((item) => item.toLanguageTag()).toList();

  String currentLanguage = '';

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    final langs = AppLocalizations.of(context);
    /*final List list = [
      "English",
      "Italian",
      "Spanish",
      "French",
      "Chinese",
      "German"
    ];*/
     currentLanguage = mList.firstWhere((item) =>
        item.toString().toLowerCase().substring(0, 2) ==
        langs.locale.languageCode);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Language A / का',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: mList
                      .map((l) => ListTile(
                            onTap: () {
                              setState(() {
                                data.changeLocale(getLocale(l));
                              });
                            },
                            title: Text(
                              l,
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: l == currentLanguage
                                ? Icon(
                                    Icons.check_circle,
                                    color: yellow,
                                    size: 16,
                                  )
                                : SizedBox(),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
