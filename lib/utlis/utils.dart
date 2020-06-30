import 'dart:async';
import 'dart:io';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';

import '../main.dart';
import 'Keys.dart';

//import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart' as pdf;
//import 'package:printing/printing.dart';

enum QuickType { zebra, discount }
Locale getLocale(String val) {
  return MyApp.list
      .firstWhere((item) => val == "${item.languageCode}-${item.countryCode}");
}

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

// User Token
void saveUserToken(String token) async {
  final pref = await SharedPreferences.getInstance();
  await getUserPrefsUX();
  pref.setString(Keys.usertoken, token);
}

void saveUserInfo(String token) async {
  final pref = await SharedPreferences.getInstance();
  await getUserPrefsUX();
  pref.setString('INFO', token);
}

Future<String> getUserInfo() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('INFO');
}

Future<String> getUserToken() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(Keys.usertoken);
}

Future<void> getUserPrefsUX() async {}

// User Role
void saveUserRole(int role) async {
  final pref = await SharedPreferences.getInstance();
  pref.setInt(Keys.userRole, role);
}

void saveUserid(int id) async {
  final pref = await SharedPreferences.getInstance();
  pref.setInt('id', id);
}

Future<int> getUserid() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getInt('id');
}

Future<int> getUserRole() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getInt(Keys.userRole);
}

// selected Chain id
Future<void> addSelectedStoreToPref(String id) async {
  final pref = await SharedPreferences.getInstance();
  return pref.setString(Keys.selectedStore, id);
}

Future<String> getSelectedStoreFromPref() async {
  final pref = await SharedPreferences.getInstance();
  final id = pref.getString(Keys.selectedStore);
  if (!checkChainId(id)) return id;
  return "0";
}

Future<String> getSelectedStoreFromPref1() async {
  final pref = await SharedPreferences.getInstance();
  final id = pref.getString(Keys.selectedStore);

  return id;
}

// saved shop id
Future<void> addCurrentShopToPref(String shopId) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString(Keys.shopID, shopId);
}

Future<String> getCurrentShopFromPref() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(Keys.shopID);
}

bool checkServerResponse(Map<String, dynamic> data, BuildContext context) {
  if (data["msg"] == '2' || data["msg"] == 'Unauthorized') {
    showLogoutDialog(context);
    return false;
  } else
    return true;
}

Future<String> scanCode(BuildContext context, AppLocalizations lang) async {
  try {
    return await BarcodeScanner.scan();
  } catch (e) {
    showAlertDialog(context, lang.tr('scanScreen.barcodeError'),
        lang.tr('scanScreen.barcodeErrorText'));
    return null;
  }
}

void showSnackBar(
    GlobalKey<ScaffoldState> scaffoldKey, String text, BuildContext context,
    {Duration duration = const Duration(seconds: 2)}) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16.0,
      ),
    ),
    backgroundColor: Colors.white,
    duration: duration,
  ));
}

void showLogoutDialog(BuildContext context) {
  final lang = AppLocalizations.of(context);

  if (Platform.isAndroid)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () => logoutUser(context),
            child: Text(lang.tr('serverError.okay')),
          )
        ],
        title: Text(lang.tr('serverError.session_exp')),
        content: Text(lang.tr('serverError.session_error')),
      ),
    );
  else
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () => logoutUser(context),
                  child: Text(lang.tr('serverError.okay')),
                )
              ],
              title: Text(lang.tr('serverError.session_exp')),
              content: Text(lang.tr('serverError.session_error')),
            ));
}

String getServerErrorMsg(Map<String, dynamic> map, BuildContext context) {
  final lang = AppLocalizations.of(context);
  switch (map["msg"]) {
    case "1":
      return lang.tr('serverError.1');
    case "2":
      return lang.tr('serverError.2');
    case "3":
      return "${lang.tr('serverError.3')}, ${map["data"]}";
    case "4":
      return lang.tr('serverError.4');
    case "5":
      return lang.tr('serverError.5');
    default:
      return "${lang.tr('serverError.else')} ${map["data"]}";
  }
}

void logoutUser(BuildContext context) async {
  await clearPref();
  Navigator.pushNamedAndRemoveUntil(
      context, "/", (Route<dynamic> route) => false);
}

Future<void> clearPref() async {
  saveUserRole(0);
  saveUserToken("");
  await addCurrentShopToPref("");
  await addSelectedStoreToPref("");
}

bool checkChainId(String id) {
  if (id == null || id == "" || id == "0") return true;
  return false;
}

String titleCase(String textToConvert) {
  String text = textToConvert.toLowerCase();

  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

String fromDoubleToInt(String number) {
  var myDouble = double.parse(number);
  assert(myDouble is double);

  return myDouble
      .toStringAsFixed(myDouble.truncateToDouble() == myDouble ? 0 : 2)
      .toString();
}

showAlertDialog(BuildContext context, String title, String content) {
  if (Platform.isAndroid)
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Okay"),
                )
              ],
              title: Text(title),
              content: Text(content),
            ),
        barrierDismissible: false);
  else
    return showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Okay"),
          )
        ],
        title: Text(title),
        content: Text(content),
      ),
    );
}

bool checkwishlist(
  Map<String, dynamic> data,
) {
  if ((data["msg"] == 'product has been added to favorit list') ||
      (data["msg"] == 'product has been removed from favorit list')) {
    return true;
  }
  print(data["status"]);
  return false;
}

bool checkorder(
  Map<String, dynamic> data,
) {
  if ((data["msg"] == "Order has been added Successfully !") ||
      (data["msg"] == "Order Updated Succeffully !")) {
    return true;
  }
  print(data["msg"]["errorInfo"]);
  return false;
}

void loadingDialog(BuildContext context, AppLocalizations lang) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoPopupSurface(
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CupertinoActivityIndicator(),
                      Text(lang.tr("loading"))
                    ],
                  ),
                ),
              ),
            ));
  } else {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              child: Container(
                height: 80,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ProgressIndicatorWidget(),
                      Text(lang.tr("loading"))
                    ],
                  ),
                ),
              ),
            ));
  }
}

void showPlatformDialog(BuildContext context, Widget child, {String code}) {
  final width = MediaQuery.of(context).size.width;

  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(width: width, child: child),
          ));
}

void showPlatformDialog1(BuildContext context, Widget child, String code) {
  final width = MediaQuery.of(context).size.width;

  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(width: width, child: child),
          ));
}
