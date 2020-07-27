import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/orders/OrdersScreen.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/wishlist.dart';
import 'package:siyou_b2b/screens/Shopowner/settings/Support.dart';
import 'package:siyou_b2b/screens/Shopowner/settings/settings_page.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import '../main.dart';
import 'faq_page.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  HomeProvider userProvider;
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    userProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
          title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Spacer(),
          GestureDetector(child:SvgPicture.asset(
                'assets/svg/logout.svg',
                width: 30,
                height: 30,
                //color: Colors.red,
              ), onTap: () {
                logoutUser(context);
              }),
          
        ],
      )),
      body: SafeArea(
        //top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: userProvider.user.avatar != null
                      ? NetworkImage(userProvider.user.avatar)
                      : AssetImage('assets/background.jpg'),
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userProvider.user.userNickname.toUpperCase() +
                        ' ' +
                        userProvider.user.userAccount.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                /* Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white10,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset('assets/icons/wallet.png'),
                                onPressed: () =>
                                    null /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => WalletPage())),*/
                                ),
                            Text(
                              lang.tr('shopOwner.Wallet'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset('assets/icons/truck.png'),
                                onPressed: () =>
                                    Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => TrackingPage())),
                                ),
                            Text(
                              lang.tr('shopOwner.shipped'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/card.png'),
                              onPressed: () =>
                                  null /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => PaymentPage()))*/
                              ,
                            ),
                            Text(
                              lang.tr('shopOwner.payment'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/contact_us.png'),
                              onPressed: () {},
                            ),
                            Text(
                              lang.tr('shopOwner.support'),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
                ListTile(
                  title: Text(lang.tr('shopOwner.Wishlist')),
                  subtitle: Text(lang.tr('shopOwner.yourwishlist')),
                  leading: SvgPicture.asset(
                    'assets/svg/wishlist.svg',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Theme.of(context).primaryColor),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LanguageProvider(
                      child: ChangeNotifierProvider(
                        child: WishList(),
                        create: (_) => ProductListProvider(),
                      ),
                    ),
                  )),
                ),
                Divider(),
                ListTile(
                  title: Text(lang.tr('shopOwner.orders')),
                  subtitle: Text(lang.tr('shopOwner.orderlist')),
                  leading: SvgPicture.asset(
                    'assets/svg/order.svg',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Theme.of(context).primaryColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => OrdersScreen())),
                ),
                Divider(),
                ListTile(
                  title: Text(lang.tr('shopOwner.Settings')),
                  subtitle: Text(lang.tr('shopOwner.privacy')),
                  leading: SvgPicture.asset(
                    'assets/svg/Setting.svg',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Theme.of(context).primaryColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text(lang.tr('shopOwner.Help')),
                  subtitle: Text(lang.tr('shopOwner.helpc')),
                  leading: SvgPicture.asset(
                    'assets/svg/Help&Support.svg',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LanguageProvider(
                      child: SupportPage(),
                    ),
                  )),
                ),
                Divider(),
                ListTile(
                  title: Text((lang.tr('shopOwner.FAQ'))),
                  subtitle: Text(lang.tr('shopOwner.questions')),
                  leading: SvgPicture.asset(
                    'assets/svg/FAQ.svg',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: Theme.of(context).primaryColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
