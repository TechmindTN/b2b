import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/models/order.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/Costum_backgroud.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

class ConOrder extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<ConOrder> {
  AppLocalizations lang;
  CartProvider _cartProvider;

  String img =
      'https://manversusweb.com/wp-content/uploads/2019/03/checkout.png';

  final ApiProvider _api = ApiProvider();
  List<Payments> payments = [
    Payments('Credit Card', Icon(FontAwesome.credit_card)),
    Payments('Paypal', Icon(FontAwesome.cc_paypal)),
    Payments('Bank Transfers', Icon(FontAwesome.credit_card)),
    Payments('Bank check', Icon(FontAwesome.bank)),
    Payments('payment on delivery', Icon(FontAwesome.money)),
  ];

  String currentpayment = '';

  @override
  void initState() {
    super.initState();
    _cartProvider = Provider.of<CartProvider>(context, listen: false);

    /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1) _productProvider.getProducts(context);
      }
    });*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
  }

  @override
  void dispose() {
    // _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
            lang.tr('shopOwner.checkout'),
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => itemcartWidget()),
        ),
      ),
    );
  }

  caltotal(List<Items> list) {
    double t;
    list.forEach((e) => t += e.itemOfflinePrice);
    print(t);
    return t;
  }

  addOrder(Order order) async {
    loadingDialog(context, lang);
    try {
      final d = order.toJson();
      print(d);
      final data = await _api.addOrder(d);

      if (checkorder(
        data,
      )) {
        try {
          Navigator.pop(context);

          return true;
        } catch (e) {
          Navigator.pop(context);
          showAlertDialog(context, " Error", e);
          print(e);
          return false;
        }
      } else {
        Navigator.pop(context);
        showAlertDialog(context, "", 'error');
        return false;
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showAlertDialog(context, "Error", e.toString());
      return false;
    }
  }

  Widget itemcartWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        if (provider.orders != null && provider.orders.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.orders.length,
                    itemBuilder: (ctx, i) {
                      return ExpandableNotifier(
                          child: ScrollOnExpand(
                        scrollOnExpand: false,
                        scrollOnCollapse: true,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                provider.orders[i].supplier
                                                        .firstName
                                                        .toUpperCase() +
                                                    ' ' +
                                                    provider.orders[i].supplier
                                                        .lastName
                                                        .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "Order #1GF5D6H${provider.orders[i].supplierId}",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      //flex: 1,
                                      child: Text(
                                        "\€ ${provider.orders[i].orderTotalPrice.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          provider.orders.removeAt(i);
                                          provider.notify();
                                        },
                                        icon: Container(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 5,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'Shipping Price :To be negotiated !'),
                                        flex: 3,
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          // print(provider.orders[i].orderTotalPrice);
                                          _onItemPressed(context, i);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: provider.orders[i]
                                                            .orderTotalPrice >=
                                                        100.00 ||
                                                    provider.orders[i]
                                                            .paymentid !=
                                                        null
                                                ? Color(0xff3ed3d3)
                                                : Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5.0),
                                              child: Icon(
                                                Icons.payment,
                                                color: Colors.white,
                                                size: 35,
                                              )),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            "Purchase date - ${DateTime.now().toString().substring(0, 10)}"),
                                        flex: 3,
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          if (provider.orders[i]
                                                      .orderTotalPrice >=
                                                  provider.orders[i].supplier
                                                      .minorder &&
                                              provider.orders[i].paymentid !=
                                                  null) {
                                            bool confirm = await addOrder(
                                                provider.orders[i]);
                                            if (confirm) {
                                              provider.orders.removeAt(i);
                                              provider.notify();
                                            }
                                          }
                                        },
                                        child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: provider.orders[i]
                                                              .orderTotalPrice >=
                                                          provider
                                                              .orders[i]
                                                              .supplier
                                                              .minorder &&
                                                      provider.orders[i]
                                                              .paymentid !=
                                                          null
                                                  ? Color(0xff3ed3d3)
                                                  : Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16.0)),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2.0),
                                                child: Text(
                                                  "Confirm Order",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                      )),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "Minimum Order Amount: € ${provider.orders[i].supplier.minorder}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "The Supplier didn't set up the logistics and shipping fee. Please create an order first and contact the supplier to discuss shipping detaiils.",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ),
                                ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: false,
                                  child: ExpandablePanel(
                                    tapHeaderToExpand: true,
                                    tapBodyToCollapse: false,
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Products List" +
                                              '  (' +
                                              provider.orders[i]
                                                  .orderProductsList.length
                                                  .toString() +
                                              ')',
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        )),
//                          collapsed: Text("loremIpsum", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    expanded: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        for (var x in provider
                                            .orders[i].orderProductsList)
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 3,
                                                  child: ListTile(
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(x.productname,
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        Text(x.itemBarcode,
                                                            style: TextStyle(
                                                                fontSize: 12))
                                                      ],
                                                    ),
                                                    leading: SizedBox(
                                                      width: 35,
                                                      child: x.itemimage ==
                                                                  null ||
                                                              x.itemimage == ""
                                                          ? Image.asset(
                                                              "assets/png/empty_cart.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  x.itemimage,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  CircularProgressIndicator(),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ), /*CachedNetworkImage(
                                                        imageUrl: img,
                                                      ),*/
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColorDark,
                                                              ),
                                                              child:
                                                                  x.itemQuantity >
                                                                          0
                                                                      ? Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              12,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .delete_forever,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              12,
                                                                        )),
                                                          onTap: () {
                                                            if (x.itemQuantity ==
                                                                0) {
                                                              provider.orders[i]
                                                                  .orderProductsList
                                                                  .remove(x);
                                                              provider.notify();
                                                            } else {
                                                              print(x.itemPrice *
                                                                  x.itemPackage);
                                                              x.itemQuantity -=
                                                                  x.itemPackage;
                                                              provider.orders[i]
                                                                  .orderTotalPrice -= x
                                                                      .itemPrice *
                                                                  x.itemPackage;
                                                              provider.orders[i]
                                                                  .orderWeight -= x
                                                                      .itemweight *
                                                                  x.itemweight;
                                                              provider.notify();
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          x.itemQuantity
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .title,
                                                        ),
                                                        SizedBox(width: 5),
                                                        GestureDetector(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark,
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            print(x.itemPrice *
                                                                x.itemPackage);
                                                            x.itemQuantity +=
                                                                x.itemPackage;
                                                            provider.orders[i]
                                                                .orderTotalPrice += x
                                                                    .itemPrice *
                                                                x.itemPackage;
                                                            provider.orders[i]
                                                                .orderWeight += x
                                                                    .itemweight *
                                                                x.itemPackage;
                                                            provider.notify();
                                                          },
                                                        ),
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child:
                                                      Text("\€${x.itemPrice}"),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 5, right: 5, bottom: 10),
                                        child: Expandable(
                                          collapsed: collapsed,
                                          expanded: expanded,
                                          crossFadePoint: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                  ),
                ),
                Divider(),
              ],
            ),
          );
        } else
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(lang.tr('shopOwner.emptycart')),
                  ),
                ),
                Divider(),
              ],
            ),
          );
      },
    );
  }

  void _onItemPressed(BuildContext context, int i) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(32.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, left: 24.0, right: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Set Payment Method',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        Container(
                          //color: Colors.white,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          height: 300,
                          child: ListView.builder(
                            itemCount: payments.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    currentpayment = payments[index].name;
                                  });
                                  _cartProvider.orders[i].paymentid = index + 1;

                                  //print(index);
                                  Navigator.pop(context);
                                },
                                leading: payments[index].icon,
                                title: Text(
                                  payments[index].name,
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: payments[index].name == currentpayment
                                    ? Icon(
                                        Icons.check_circle,
                                        color: yellow,
                                        size: 16,
                                      )
                                    : SizedBox(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 85.0,
                  right: 60.0,
                  child: GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black87, shape: BoxShape.circle),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

class Payments {
  String name;
  Icon icon;
  Payments(this.name, this.icon);
}
