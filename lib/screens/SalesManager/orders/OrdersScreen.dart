import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/appprop.dart';
import 'ArchivedOrders.dart';
import 'OrdersStatus.dart';
import 'PaidOrders.dart';

class SuppOrdersScreen extends StatelessWidget {
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
          title: Text("Orders",style: TextStyle(color: darkGrey)),
          bottom: TabBar(tabs: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Invaild", style: TextStyle(fontSize: 18.0,color: darkGrey ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Vaild", style: TextStyle(fontSize: 18.0,color: darkGrey ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Paid", style: TextStyle(fontSize: 18.0,color: darkGrey ),),
            )
          ],),
        ),
        body: TabBarView(
          children: <Widget>[
            SuppOrdersStatus(),
            SuppArchivedOrders(),
            SuppPaidOrders()
          ],
        ),
      ),
    );
  }
}
