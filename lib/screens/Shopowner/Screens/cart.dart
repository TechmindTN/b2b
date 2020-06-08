import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';

import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Confirme_orders.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  AppLocalizations lang;
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
    //_productProvider?.getProducts(context);
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
                Text(
                  lang.tr('shopOwner.Cart'),
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.itmes.length,
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 70,
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
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
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
                                  Text(
                                    '${provider.itmes[i].product.productName}',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  Text(
                                    "${provider.itmes[i].itemBarcode}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    "€ ${provider.itmes[i].itemOnlinePrice} x ${provider.itmes[i].quantity} ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
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
                                        GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.red,
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          onTap: () {
                                            provider.itmes[i].quantity -
                                                        provider.itmes[i]
                                                            .itemPackage >
                                                    0
                                                ? provider.itmes[i].quantity -=
                                                    provider
                                                        .itmes[i].itemPackage
                                                : provider.itmes[i].quantity =
                                                    0;

                                            provider.itmes[i].quantity -
                                                        provider.itmes[i]
                                                            .itemPackage >0
                                                    
                                                ? provider.total = provider.total
                                                : provider.total -= provider
                                                        .itmes[i]
                                                        .itemOnlinePrice *
                                                    provider
                                                        .itmes[i].itemPackage;
                                            provider.notify();
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
                                              shape: BoxShape.rectangle,
                                              color: Colors.red,
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 10,
                                            ),
                                          ),
                                          onTap: () {
                                            provider.itmes[i].quantity +=
                                                provider.itmes[i].itemPackage;
                                            provider.total += provider
                                                    .itmes[i].itemOnlinePrice *
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
                          Text("TOTAL",
                              style: Theme.of(context).textTheme.subtitle),
                          Text("€. ${provider.total.toStringAsFixed(2)}",
                              style: Theme.of(context).textTheme.headline),
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
                Text(
                  lang.tr('shopOwner.Cart'),
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(lang.tr('shopOwner.emptycart')),
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
                          Text("€. $_total",
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
