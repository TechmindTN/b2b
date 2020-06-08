import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/screens/supplierSpace/catalogues/MyCatalogues.dart';
import 'package:siyou_b2b/screens/supplierSpace/stores/StoresListScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/orders/SupplierOrdersScreen.dart';

import 'SupplierHomePage.dart';

class SupplierHomeScreen extends StatefulWidget {
  @override
  _SupplierHomeScreenState createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.collections),
              title: Text('My Catalogues'),
              activeColor: Colors.lightGreen),
          BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('Orders'),
              activeColor: Colors.orange),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Stores'),
              activeColor: Colors.blue),
        ],
      ),
    );
  }

  getWidget() {
    switch (currentIndex) {
      case 0:
        return SupplierHomePage();
      case 1:
        return MyCatalogues();
      case 2:
        return SupplierOrdersScreen();
      case 3:
        return StoresListScreen();
    }
  }
}
