import 'package:flutter/material.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/orders/OrdersStatus.dart';

import 'package:siyou_b2b/widgets/appprop.dart';

import 'ArchivedOrders.dart';
import 'PaidOrders.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          title: Text("Orders", style: TextStyle(color: darkGrey)),
          bottom: TabBar(
            tabs: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Invalid",
                  style: TextStyle(fontSize: 18.0, color: darkGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "valid",
                  style: TextStyle(fontSize: 18.0, color: darkGrey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Paid",
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
