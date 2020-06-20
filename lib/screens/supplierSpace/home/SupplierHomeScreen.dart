import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/screens/supplierSpace/Shops/Shops&ManagersScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/catalogues/ProductScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/orders/OrdersScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/profile/MyProfile.dart';
import 'package:siyou_b2b/widgets/SupplierProfilPage.dart';



class SupplierHomeScreen extends StatefulWidget {
  @override
  _SupplierHomeScreenState createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
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
              icon: Icon(Iconic.box),
              title: Text('My Products'),
              activeColor: Colors.red),
          BottomNavyBarItem(
              icon: Icon(Icons.view_list),
              title: Text('Orders'),
              activeColor: Colors.red),
          BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Stores'),
              activeColor: Colors.red),
          BottomNavyBarItem(
              icon: Icon(Icons.more),
              title: Text('More'),
              activeColor: Colors.red),
        ],
      ),
    );
  }

  getWidget() {
    switch (currentIndex) {
      case 0:
        return MyProfile(); //SupplierHomePage();
      case 1:
        return ProductsListSScreen();
      case 2:
        return SuppOrdersScreen();
      case 3:
        return ShopsManagersScreen();//StoresListScreen();
      case 4:
        return Container(
            color: Colors.white,
            child: LanguageProvider(child: SupplierProfilePage()));
    }
  }
}
