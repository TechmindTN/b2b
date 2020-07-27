import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';

import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/orders/Confirme_orders.dart';
import 'package:siyou_b2b/utlis/utils.dart';

import 'orders/Confirme_orders.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  AppLocalizations lang;
  // ignore: unused_field
  CartProvider _cartProvider;
  int _total = 0;
  // final ApiProvider _api = ApiProvider();
  //final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    //_cartProvider?.getPaymentList(context);
  }

  @override
  void dispose() {
    /* _scrollController.dispose();
    _productProvider.products.clear();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(
              Entypo.bag,
              size: 20,
            ),
            SizedBox(width: 10),
            Text(
              lang.tr('shopOwner.Cart'),
              style: TextStyle(color: Colors.black),
              //style: Theme.of(context).textTheme.display1.copyWith(
              //  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Spacer(),
            if (_cartProvider.orders.length > 0)
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      MfgLabs.menu,
                      // color: Theme.of(context).primaryColorDark,
                    ),
                    Text('Orders',
                        style: Theme.of(context).textTheme.body2.copyWith(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 12))
                  ],
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => LanguageProvider(
                        child: ConOrder(),
                      ),
                    ),
                  );
                },
              ),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesome.barcode,
                    // color: Theme.of(context).primaryColorDark,
                  ),
                  Text('Quick',
                      style: Theme.of(context).textTheme.body2.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 12))
                ],
              ),
              onTap: () async {
                String code = await scanCode(context, lang);
                print(code);
                if (code != null) {
                  await _cartProvider.searchItems(context, code);
                  // _cartProvider.notify();
                }
              },
            ),
          ],
        ),

        backgroundColor: Colors.white,
        //elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: itemcartWidget(),
        ),
      ),
    );
  }

  Widget itemcartWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        if (provider.itmes != null && provider.itmes.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.itmes.length,
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: provider.itmes[i].images[0].imageUrl ==
                                          null ||
                                      provider.itmes[i].images[0].imageUrl == ""
                                  ? Image.asset(
                                      "assets/png/empty_cart.png",
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          provider.itmes[i].images[0].imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                              /*provider.itmes[i].images!=null? Image.network(
                            "${provider.itmes[i].images[0]}",
                            fit: BoxFit.cover,
                          ):*/
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  provider.itmes[i].product != null
                                      ? Text(
                                          '${provider.itmes[i].product.productName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(fontSize: 12),
                                        )
                                      : Text(
                                          '${provider.itmes[i].productname}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .title
                                              .copyWith(fontSize: 14),
                                        ),
                                  Text(
                                    "${provider.itmes[i].itemBarcode}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  provider.itmes[i].itemDiscountPrice == null
                                      ? Text(
                                          "€ ${provider.itmes[i].itemOfflinePrice} x ${provider.itmes[i].quantity} ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                        )
                                      : Text(
                                          "€ ${provider.itmes[i].itemOfflinePrice} x ${provider.itmes[i].quantity} ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                  if (provider.itmes[i].itemDiscountPrice !=
                                      null)
                                    Text(
                                      "€ ${provider.itmes[i].itemDiscountPrice} x ${provider.itmes[i].quantity} ",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                            Container(
                              // height: 70,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 5),
                                  Container(
                                    //width: 135,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0, vertical: 9.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent, width: 1),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                        child: Row(
                                      children: <Widget>[
                                        // if (provider.itmes[i].quantity > 0)
                                        GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            child:
                                                provider.itmes[i].quantity > 0
                                                    ? Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )
                                                    : Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                          ),
                                          onTap: () {
                                            if (provider.itmes[i].quantity ==
                                                0) {
                                              provider.itmes.removeAt(i);
                                              provider.notify();
                                            } else {
                                              provider.itmes[i].quantity -
                                                          provider.itmes[i]
                                                              .quantity >=
                                                      0
                                                  ? provider
                                                          .itmes[i].quantity -=
                                                      provider
                                                          .itmes[i].itemPackage
                                                  : provider.itmes[i].quantity =
                                                      0;

                                              provider.itmes[i].quantity -
                                                          provider.itmes[i]
                                                              .itemPackage >
                                                      0
                                                  ? provider.total =
                                                      provider.total
                                                  : provider.total -= provider
                                                          .itmes[i]
                                                          .itemOfflinePrice *
                                                      provider
                                                          .itmes[i].itemPackage;
                                              provider.notify();
                                            }
                                          },
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          provider.itmes[i].quantity.toString(),
                                          style:
                                              Theme.of(context).textTheme.title,
                                        ),
                                        SizedBox(width: 15),
                                        GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          onTap: () {
                                            provider.itmes[i].quantity +=
                                                provider.itmes[i].itemPackage;
                                            provider.total += provider
                                                    .itmes[i].itemOfflinePrice *
                                                provider.itmes[i].itemPackage;

                                            provider.notify();
                                          },
                                        ),
                                      ],
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                      //Divider();
                    },
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(lang.tr('shopOwner.Total'),
                              style: Theme.of(context).textTheme.subtitle),
                          Text("€ ${provider.total.toStringAsFixed(2)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontSize: 17)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            lang.tr('shopOwner.clear'),
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () {
                            provider.itmes.clear();
                            provider.total = 0;
                            provider.notify();
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            lang.tr('shopOwner.checkout'),
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () {
                            /* Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Buying not supported yet.')));*/
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => LanguageProvider(
                                  child: ChangeNotifierProvider(
                                    child: ConOrder(),
                                    create: (_) => ProductListProvider(),
                                  ),
                                ),
                              ),
                            );
                            provider.checkout();
                            provider.itmes.clear();
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        } else
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //SizedBox(height: 15),
                Container(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      //height: 250,
                      child: Image.asset(
                        "assets/jpg/EmptyCard3.gif",
                        //height: 250,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Center(
                    child: Text(lang.tr('shopOwner.emptycart')),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Container(),
                  ),
                ),

                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TOTAL",
                              style: Theme.of(context).textTheme.subtitle),
                          Text("€ $_total",
                              style: Theme.of(context).textTheme.headline),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text(
                            lang.tr('shopOwner.checkout'),
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () => null,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
      },
    );
  }
}
