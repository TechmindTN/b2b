

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/NotificationEmpty.dart';
import 'package:siyou_b2b/widgets/NotificationItem.dart';

class SupplierNotificationScreen extends StatefulWidget {
  @override
  _SupplierNotificationScreenState createState() => _SupplierNotificationScreenState();
}

class _SupplierNotificationScreenState extends State<SupplierNotificationScreen> {
  final List<Map<String, dynamic>> notifs = [
    {
      "title": "Your have a new order",
      "icon": "assets/svg/notification_warning.svg",
      "iconColor": Color(0xfff5a623),
      "background": Color(0xfffcf3df),
    },
    {
      "title": "You have a new message",
      "icon": "assets/svg/notification_message.svg",
      "iconColor": Color(0xff00aefc),
      "background": Color(0xffe6f7ff),
    },
    {
      "title": "Order was cancelled by shop",
      "icon": "assets/svg/notification_error.svg",
      "iconColor": Color(0xffdb493c),
      "background": Color(0xffffebe9),
    },
    {
      "title": "Your have a new order",
      "icon": "assets/svg/notification_warning.svg",
      "iconColor": Color(0xfff5a623),
      "background": Color(0xfffcf3df),
    },
  ];

  bool empty = false;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(lang.tr("notificationScreen.title")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.toll), onPressed: () {
            setState(() {
              empty = !empty;
            });
          },)
        ],
      ),
      body: empty
          ? Container(
        child: NotificationEmpty(),
      )
          : ListView.builder(
        shrinkWrap: true,
        itemCount: notifs.length,
        itemBuilder: (_, index) => NotificationItem(
          title: notifs[index]["title"],
          icon: notifs[index]["icon"],
          iconColor: notifs[index]["iconColor"],
          background: notifs[index]["background"],
          markAsRead: () => null,
          remove: () => null,
        ),
      ),
    );
  }
}
