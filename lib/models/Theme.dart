import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyThemes {
  static final List<ThemeData> themes = [
    ThemeData(
      primaryColor: Color(0xffe31313),
      primaryColorDark: Color(0xffcd0714),
      primaryColorLight: Color(0xffff593f),
      accentColor: Color(0xff3b318a),

    ),
    ThemeData(
      primaryColor: Color(0xfffe661b),
      primaryColorDark: Color(0xffc33300),
      primaryColorLight: Color(0xffff984c),
      accentColor: Color(0xff3b318a),
    ),
    ThemeData(
      primaryColor: Color(0xff3b318a),
      primaryColorDark: Color(0xff000b5c),
      primaryColorLight: Color(0xff6c5bbb),
      accentColor: Color(0xfffe661b),
    ),
    ThemeData(
      primaryColor: Color(0xffA60000),
      primaryColorDark: Color(0xff840000),
      primaryColorLight: Color(0xffFE4C4B),
      accentColor: Color(0xff1E88E5),
    ),
    ThemeData(
      primaryColor: Color(0xff55185d),
      primaryColorDark: Color(0xff84458b),
      primaryColorLight: Color(0xffb572bb),
      accentColor: Color(0xffECB602),
    ),
    ThemeData(
      primaryColor: Color(0xff40a8c4),
      primaryColorDark: Color(0xff003f5a),
      primaryColorLight: Color(0xffbcdbdf),
      accentColor: Color(0xfffea02f),
    ),
    ThemeData(
      primaryColor: Color(0xff656E69),
      primaryColorDark: Color(0xff3b433e),
      primaryColorLight: Color(0xffAFB3A5),
      accentColor: Color(0xff63752B),
    ),
  ];

  static final accentDark = [
    Color(0xff000b5c),
    Color(0xff000b5c),
    Color(0xffc33300),
    Color(0xff005cb2),
    Color(0xffb58700),
    Color(0xffc67100),
    Color(0xff364900)
  ];
  static final accentLight = [
    Color(0xff289cef),
    Color(0xff289cef),
    Color(0xffff984c),
    Color(0xff6ab7ff),
    Color(0xffffe84c),
    Color(0xffffd161),
    Color(0xff92a457),
  ];

  static final titleColor = [
    Color(0xffcd0714),
    Color(0xfffe661b),
    Color(0xff3b318a),
    Color(0xffA60000),
    Color(0xff55185d),
    Color(0xff40a8c4),
    Color(0xff656E69),
  ];

  static ThemeData getThemeFromIndex(String index) {
    try {
      return themes[int.parse(index)];
    } catch (e) {
      return themes[0];
    }
  }

  static Color getAccentDark(BuildContext context) {
    final th = Theme.of(context);
    final index = themes.indexWhere((theme) =>
    theme.primaryColor == th.primaryColor);
    return accentDark[index != -1 ? index : 0];
  }

  static Color getAccentLight(BuildContext context) {
    final th = Theme.of(context);
    final index = themes.indexWhere((theme) =>
    theme.primaryColor == th.primaryColor);
    return accentLight[index != -1 ? index : 0];
  }

  static Color getTitleColor(BuildContext context) {
    final th = Theme.of(context);
    final index = themes.indexWhere((theme) =>
    theme.primaryColor == th.primaryColor);
    return titleColor[index != -1 ? index : 0];
  }

  static Future<ThemeData> getSavedTheme() async {
    String index = await getSavedThemeIndex();
    return getThemeFromIndex(index != null ? index : "0");
  }

  static Future<String> getSavedThemeIndex() async {
    final pref = await SharedPreferences.getInstance();
    final index = pref.getString("ui_theme");
    return index;
  }
}
