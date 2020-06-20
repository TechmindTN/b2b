import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/settings/Support.dart';
import 'package:siyou_b2b/screens/Shopowner/settings/settings_page.dart';
import 'package:siyou_b2b/screens/supplierSpace/orders/OrdersScreen.dart';
import '../main.dart';
import 'faq_page.dart';

class SupplierProfilePage extends StatelessWidget {
  HomeProvider userProvider; 
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    userProvider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: 56),
            child: Column(
              children: <Widget>[
                 CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: NetworkImage(userProvider.user.avatar),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userProvider.user.userNickname+' '+userProvider.user.userAccount,
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
                    title: Text(lang.tr('shopOwner.orders')),
                    subtitle: Text(lang.tr('shopOwner.orderlist')),
                    leading: Image.asset(
                      'assets/icons/orders.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: Icon(Icons.chevron_right,
                        color: Theme.of(context).primaryColor),
                    onTap: () =>
                        Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SuppOrdersScreen())),
                    ),
                Divider(),
                ListTile(
                  title: Text(lang.tr('shopOwner.Settings')),
                  subtitle: Text(lang.tr('shopOwner.privacy')),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
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
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
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
                  leading: Image.asset('assets/icons/faq.png'),
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
