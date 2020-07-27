import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/appprop.dart';
import 'ArchivedOrders.dart';
import 'OrdersStatus.dart';
import 'PaidOrders.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations lang = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(lang.tr('shopOwner.orders'),
              style: TextStyle(color: darkGrey)),
          bottom: TabBar(
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lang.tr('shopOwner.invalid'),
                  style: TextStyle(fontSize: 18.0, color: darkGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lang.tr('shopOwner.valid'),
                  style: TextStyle(fontSize: 18.0, color: darkGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lang.tr('shopOwner.paid'),
                  style: TextStyle(fontSize: 18.0, color: darkGrey),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[OrdersStatus(), ArchivedOrders(), PaidOrders()],
        ),
      ),
    );
  }
}
