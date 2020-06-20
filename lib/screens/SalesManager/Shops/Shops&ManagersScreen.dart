import 'package:flutter/material.dart';
import 'package:siyou_b2b/screens/SalesManager/Shops/SalesMangerList.dart';
import 'package:siyou_b2b/screens/SalesManager/Shops/ShopsList.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

class ShopsManagersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Shops & Suppliers",style: TextStyle(color: darkGrey)),
          bottom: TabBar(tabs: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Shops", style: TextStyle(fontSize: 15.0,color: darkGrey ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Suppliers", style: TextStyle(fontSize: 15.0,color: darkGrey ),),
            ),
            
          ],),
        ),
        body: TabBarView(
          children: <Widget>[
            ShopList(),
            MangersList()
           
          ],
        ),
      ),
    );
  }
}
