import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';

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
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    newarrivals = Provider.of<HomeProvider>(context, listen: false);
    //newarrivals?.getnewarrivals(context,widget.supplierid);
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
    return InkWell(
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
        child: Stack(
          children: <Widget>[
            Row(
              //mainAxisAlignment:MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Container(
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
                ),
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
                        Text(
                          newarrivals.lastadded[index].product.productName,
                          style: TextStyle(
                            //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'NunitoSans',
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: newarrivals.lastadded[index].id
                                          .toString() +
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
                height: 40,
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
                              newarrivals.lastadded[index].quantity -
                                          newarrivals
                                              .lastadded[index].itemPackage >
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
                                size: 10,
                              ),
                            ),
                            onTap: () {
                              newarrivals.lastadded[index].quantity +=
                                  newarrivals.lastadded[index].itemPackage;
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
        ));
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
                  'Search',
                  style: Theme.of(context)
                      .textTheme
                      .body2
                      .copyWith(color: Colors.black),
                )
              ],
            ),
            onTap: () async {},
          ),
          GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.filter_list),
                Text('filter',
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.black))
              ],
            ),
            onTap: () async {},
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
            onTap: () async {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        getWidget(),
        Positioned(
          child: filterWidget(),
          bottom: 2,
          left: 12,
        )
      ],
    );
  }
}