import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Home_Screen.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/productlistScreenCategorie.dart';
import 'package:siyou_b2b/widgets/profile.dart';


class Online extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _OnlineState createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  int _currentPage = 0;
  AppLocalizations lang;
  final List<Widget> _pages = [
    LanguageProvider(
      child: HomeScreen(),
    ),
    LanguageProvider(
      child: ProductsListScreen(),
    ),
  /*  LanguageProvider(
      child: ProductsListScreen(),
    ),
    LanguageProvider(
      child: ProductsListBrand(),
    ),*/
    //Cart(),
    Cart(),
    Container(color: Colors.white, child:LanguageProvider(child: ProfilePage())),
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentPage,
        onTap: (i) {
          setState(() {
            _currentPage = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Home')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.search,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Supplier')),
          ),
          /*BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tags,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Category')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tradeFederation,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Brand')),
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Cart')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text(lang.tr('shopOwner.Profile')),
          ),
        ],
      ),
      body: SafeArea(
        child: _pages[_currentPage],
      ),
    );
  }
}


