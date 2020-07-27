import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Home_Screen.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/product/productlistScreenCategorie.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/wishlist.dart';
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
    ChangeNotifierProvider(
      create: (_) => ProductListProvider(),
      child: LanguageProvider(
        child: ProductsListScreen(),
      ),
    ),
    WishList(),
    Cart(),
    Container(
        color: Colors.white, child: LanguageProvider(child: ProfilePage())),
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
        selectedItemColor: Theme.of(context).primaryColorDark,
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
              FontAwesomeIcons.safari,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Discovery')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              RpgAwesome.glass_heart,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Wishlist')),
          ),
          /*BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tradeFederation,
              size: 20,
            ),
            title: Text(lang.tr('shopOwner.Brand')),
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Entypo.bag,
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
