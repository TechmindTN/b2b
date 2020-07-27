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
  final List list = [
    "English",
    "Italian",
    // "Spanish",
    //"French",
    "Chinese",
    //"German"
  ];
  final List flag = [
    "https://cdn3.iconfinder.com/data/icons/flags-circle/100/USA_-512.png",
    "https://cdn3.iconfinder.com/data/icons/flags-of-countries-3/128/Italy-512.png",
    // "Spanish",
    //"French",
    "https://cdn4.iconfinder.com/data/icons/flat-country-flag/512/China-512.png",
    //"German"
  ];

  final mList = MyApp.list.map((item) => item.toLanguageTag()).toList();

  String currentLanguage = '';

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    final langs = AppLocalizations.of(context);

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
                child: ListView.builder(
                  itemCount: mList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        setState(() {
                          data.changeLocale(getLocale(mList[index]));
                        });
                      },
                      leading: Image.network(flag[index],
                      height: 30,),
                      title: Text(
                        list[index],
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: mList[index] == currentLanguage
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColorDark,
                              size: 16,
                            )
                          : SizedBox(),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 4,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
