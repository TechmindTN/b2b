import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/widgets/CategoryFilter.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

import '../../../../main.dart';
import '../Itemdetails.dart';

class NewArrivals extends StatefulWidget {
  final int supplierid;

  const NewArrivals({Key key, this.supplierid}) : super(key: key);
  @override
  _NewArrivalsState createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  AppLocalizations lang;
  HomeProvider newarrivals;
  CartProvider cartProvider;
  int categoryid;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    newarrivals = Provider.of<HomeProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context);

    //newarrivals?.getnewarrivals(context,id:widget.supplierid);
  }

  Widget getWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.lastadded != null && provider.lastadded.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.lastadded.length,
            itemBuilder: (context, index) => _getItemWidget(index),
          );
        } else
          return Container(
            child: Center(
              child: Text("No Orders Found ! "),
            ),
          );
      },
    );
  }

  Widget _getItemWidget(
    int index,
  ) {
    return Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Row(
            //mainAxisAlignment:MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => LanguageProvider(
                          child: ChangeNotifierProvider(
                            child: ItemDetailsScreen(
                              product: newarrivals.lastadded[index],
                              supplierid: widget.supplierid,
                            ),
                            create: (_) => ProductListProvider(),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: new EdgeInsets.all(10.0),
                    child: Material(
                      // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      // elevation: 10.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 85.0,
                          width: 80.0,
                          child: newarrivals.lastadded[index].images == null ||
                                  newarrivals.lastadded[index].images.isEmpty
                              ? Image.asset(
                                  "assets/png/empty_cart.png",
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                )
                              : CachedNetworkImage(
                                  imageUrl: newarrivals
                                      .lastadded[index].images[0].imageUrl,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    ),
                  )),
              Row(
                //mainAxisAlignment: MainAxisAlignment.s,
                // crossAxisAlignment: CrossAxisAlignment.end,

                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          width: 165,
                          child: Text(
                            newarrivals.lastadded[index].product.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                              fontWeight: FontWeight.bold,
                              // fontFamily: 'NunitoSans',
                              fontSize: 16.0,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    newarrivals.lastadded[index].id.toString() +
                                        '/' +
                                        newarrivals.lastadded[index].itemBarcode
                                            .toString(),
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: ' Box: ' +
                                    newarrivals.lastadded[index].itemBox
                                        .toString() +
                                    ' Package: ' +
                                    newarrivals.lastadded[index].itemPackage
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                            WidgetSpan(
                              child: SizedBox(
                                width: 20,
                              ),
                            ),
                            /*TextSpan(
                          text: newarrivals.suppliers[index].country +
                              ',' +
                              newarrivals.suppliers[index].region,
                          style: TextStyle(color: Color(0xFF959ca6))),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Positioned(
            child: Text(
              '€ ' +
                  newarrivals.lastadded[index].itemOfflinePrice
                      .toStringAsFixed(2),
              style: TextStyle(
                color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                fontWeight: FontWeight.w500,
                // fontFamily: 'NunitoSans',
                fontSize: 17.0,
              ),
            ),
            right: 15,
            top: 20,
          ),
          Positioned(
            child: Container(
              height: 90,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5),
                  Container(
                    //width: 135,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 9.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                        child: Row(
                      children: <Widget>[
                        if (newarrivals.lastadded[index].quantity > 0)
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
                                size: 18,
                              ),
                            ),
                            onTap: () {
                              newarrivals.lastadded[index].quantity -
                                          newarrivals
                                              .lastadded[index].itemPackage >=
                                      0
                                  ? newarrivals.lastadded[index].quantity -=
                                      newarrivals.lastadded[index].itemPackage
                                  : newarrivals.lastadded[index].quantity = 0;
                              newarrivals.notify();
                            },
                          ),
                        SizedBox(width: 15),
                        Text(
                          newarrivals.lastadded[index].quantity.toString(),
                          style: Theme.of(context).textTheme.title,
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
                              size: 18,
                            ),
                          ),
                          onTap: () {
                            //  newarrivals.lastadded[index].quantity +=
                            //    newarrivals.lastadded[index].itemPackage;

                            cartProvider.addCartItems(
                                newarrivals.lastadded[index],
                                newarrivals.lastadded[index].itemPackage,
                                widget.supplierid);
                            newarrivals.notify();
                          },
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
            right: 0,
            top: 40,
          )
        ],
      ),
      Divider(
        thickness: 2,
        color: Colors.black12,
        height: 5,
      ),
      if (index == newarrivals.lastadded.length - 1)
        SizedBox(
          height: 65,
        )
    ]);
  }

  void _onSortPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            child: Wrap(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          ' Name A-Z',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((a, b) =>
                              Comparable.compare(a.product.productName,
                                  b.product.productName));
                          newarrivals.notify();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          ' Name Z-A',
                        ),
                        onTap: () {
                          newarrivals.lastadded.sort((a, b) =>
                              Comparable.compare(b.product.productName,
                                  a.product.productName));
                          newarrivals.notify();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          ' Price Low-High',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((a, b) =>
                              Comparable.compare(
                                  a.itemOfflinePrice, b.itemOfflinePrice));

                          newarrivals.notify();
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text(
                          ' Price High-Low',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((b, a) =>
                              Comparable.compare(
                                  a.itemOfflinePrice, b.itemOfflinePrice));
                          newarrivals.notify();
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 4.0,
                  right: 4.0,
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
            ]),
          );
        });
  }

  filterWidget() {
    return Container(
      width: MediaQuery.of(context).size.width - 25,
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorDark),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Theme.of(context).primaryColorDark,
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(MaterialCommunityIcons.format_list_bulleted_type),
                Text(
                  'Category',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black),
                )
              ],
            ),
            onTap: () => categorypressed(widget.supplierid),
          ),
          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.sort),
                Text('sort',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black))
              ],
            ),
            onTap: () => _onSortPressed(context),
          ),
          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.filter_list),
                Text('Scan',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black))
              ],
            ),
            onTap: () async {},
          ),
        ],
      ),
    );
  }

  void categorypressed(int id) {
    final edgeInsets = const EdgeInsets.all(8.0);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(children: <Widget>[
            Container(
              padding: edgeInsets,
              child: Text(lang.tr('shopOwner.Category'),
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25)),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newarrivals.categories.length,
                itemBuilder: (_, index) {
                  return (ExpansionTile(
                    title: Text(newarrivals.categories[index].categoryName,
                        style: Theme.of(context).textTheme.subhead),
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newarrivals
                              .categories[index].subCategories.length,
                          itemBuilder: (_, i) {
                            return (ListTile(
                              onTap: () {
                                /*setState(() {
                                  categoryid ==
                                          newarrivals.categories[index]
                                              .subCategories[i].id
                                      ? categoryid = null
                                      : categoryid = categoryid =
                                          newarrivals.categories[index]
                                              .subCategories[i].id;
                                });*/
                                print(newarrivals
                                    .categories[index].subCategories[i].id);
                                Navigator.pop(context);
                                newarrivals.resetList(
                                  context,
                                  supplierid: id,
                                  category: newarrivals
                                      .categories[index].subCategories[i].id,
                                );
                              },
                              title: Text(
                                newarrivals.categories[index].subCategories[i]
                                    .categoryName,
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: categoryid ==
                                      newarrivals
                                          .categories[index].subCategories[i].id
                                  ? Icon(
                                      Icons.check_circle,
                                      color: yellow,
                                      size: 23,
                                    )
                                  : SizedBox(),
                            ));
                          })
                    ],
                  ));
                })
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          getWidget(),
          Positioned(
            child: filterWidget(),
            bottom: 2,
            left: 12,
          )
        ],
      ),
    );
  }
}
