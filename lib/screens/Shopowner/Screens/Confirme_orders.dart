import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
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
  int _total = 0;
  String img =
      'https://manversusweb.com/wp-content/uploads/2019/03/checkout.png';
  // final ApiProvider _api = ApiProvider();
  //final ScrollController _scrollController = new ScrollController();
  final ApiProvider _api = ApiProvider();

  @override
  void initState() {
    super.initState();

    /* _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1) _productProvider.getProducts(context);
      }
    });*/
  }
  /*intil()async{
    await _productProvider.getLists(context);
    print('intial');
    
  }*/

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
    list.forEach((e) => t += e.itemOnlinePrice);
    print(t);
    return t;
  }

  Widget itemcartWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        if (provider.orders != null && provider.orders.isNotEmpty) {
          addOrder(Order order) async {
            loadingDialog(context, lang);
            try {
              final d = order.toJson();
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

          return Padding(
            padding: const EdgeInsets.all(15.0),
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
                                      flex: 4,
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            /*child: CachedNetworkImage(
                          alignment: Alignment.centerLeft,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                backgroundImage: imageProvider,
                              ),
                          imageUrl: "${item["image"]}",
                        ),*/
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Supplier ' +
                                                    provider
                                                        .orders[i].supplierId
                                                        .toString(),
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
                                      child: Text(
                                        "\€${provider.orders[i].orderTotalPrice}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () => null,
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
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'Shipping Price :To be negotiated !' ),
                                        flex: 3,
                                      ),
                                      
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
                                            "Purchase date - ${DateTime.now()}"),
                                        flex: 3,
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          if (provider.orders[i].orderTotalPrice>=100.00){
                                            bool confirm = await addOrder(
                                              provider.orders[i]);
                                          if (confirm) {
                                            provider.orders.removeAt(i);
                                            provider.notify();
                                          }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: provider.orders[i].orderTotalPrice>=100.00?Color(0xff3ed3d3):Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2.0),
                                            child: Text(
                                              "Confirm Order",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ))
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
                                            "Minimum Order Amount: € 100.00",
                                            style: TextStyle(color: Colors.red),),
                                ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                            "The Supplier didn't set up the logistics and shipping fee. Please create an order first and contact the supplier to discuss shipping detaiils.",
                                            style: TextStyle(fontSize: 10,color: Colors.grey),),
                                ),

                                ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: false,
                                  child: ExpandablePanel(
                                    tapHeaderToExpand: true,
                                    tapBodyToCollapse: true,
                                    headerAlignment:
                                        ExpandablePanelHeaderAlignment.center,
                                    header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          "Products List",
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
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 4,
                                                  child: ListTile(
                                                    title: Column(
                                                      children: <Widget>[
                                                        Text(x.productname,style: TextStyle(fontSize: 15 )),
                                                        Text(x.itemBarcode,style: TextStyle(fontSize: 12 ))
                                                      ],
                                                    ),
                                                    leading: SizedBox(
                                                      width: 60,
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
                                                  child: Text(
                                                      "Qty ${x.itemQuantity}"),
                                                ),
                                                Expanded(
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
                /* Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TOTAL",
                              style: Theme.of(context).textTheme.subtitle),
                          Text("€. ${provider.total}",
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
                ),*/
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
}
