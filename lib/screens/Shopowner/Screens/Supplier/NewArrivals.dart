import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/Itemdetails.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/ScanbarcodeWidget.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import '../../../../main.dart';


class NewArrivals extends StatefulWidget {
  final int supplierid;
  final Suppliers supplier;

  const NewArrivals({Key key, this.supplierid, this.supplier})
      : super(key: key);
  @override
  _NewArrivalsState createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  AppLocalizations lang;
  HomeProvider newarrivals;
  CartProvider cartProvider;
  int categoryid;
  ScrollController _scrollController = new ScrollController();
  int id;

  @override
  void initState() {
    super.initState();
    id = widget.supplierid;
  }

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
          return OpssWidget(
            onPress: newarrivals.resetList(context, supplierid: id),
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
                              description: newarrivals
                                  .lastadded[index].product.productDescription,
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
                color: Theme.of(context).primaryColorDark, //Color(0xFFB7B7B7),
                fontWeight: FontWeight.w500,
                // fontFamily: 'NunitoSans',
                fontSize: 17.0,
              ),
            ),
            right: 15,
            top: 15,
          ),
          newarrivals.lastadded[index].itemQuantity > 0
              ? Positioned(
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
                            border:
                                Border.all(color: Colors.transparent, width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                              child: Row(
                            children: <Widget>[
                              if (cartProvider.checkinCart(
                                      newarrivals.lastadded[index]) >
                                  -1)
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    child: cartProvider
                                                .itmes[cartProvider.checkinCart(
                                                    newarrivals
                                                        .lastadded[index])]
                                                .quantity >
                                            cartProvider
                                                .itmes[cartProvider.checkinCart(
                                                    newarrivals
                                                        .lastadded[index])]
                                                .itemPackage
                                        ? Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        : Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                  ),
                                  onTap: () => cartProvider.removeCartItem(
                                      newarrivals.lastadded[index]),
                                ),
                              SizedBox(width: 15),
                              cartProvider.checkinCart(
                                          newarrivals.lastadded[index]) ==
                                      -1
                                  ? Text(
                                      newarrivals.lastadded[index].quantity
                                          .toString(),
                                      style: Theme.of(context).textTheme.title,
                                    )
                                  : Text(
                                      cartProvider
                                          .itmes[cartProvider.checkinCart(
                                              newarrivals.lastadded[index])]
                                          .quantity
                                          .toString(),
                                      style: Theme.of(context).textTheme.title,
                                    ),
                              SizedBox(width: 15),
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColorDark,
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
                                      widget.supplierid,
                                      widget.supplier);
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
              : Positioned(
                  child: Text(
                    lang.tr('shopOwner.outofstock'),
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  right: 20,
                  top: 60,
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
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Material(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            child: Wrap(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(FontAwesome.sort_alpha_asc),
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
                        leading: Icon(FontAwesome.sort_alpha_desc),
                        title: Text(
                          ' Name Z-A',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((b, a) =>
                              Comparable.compare(a.product.productName,
                                  b.product.productName));
                          newarrivals.notify();
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(FontAwesome.sort_amount_asc),
                        title: Text(
                          ' Price Low-High',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((b, a) =>
                              Comparable.compare(
                                  a.itemOfflinePrice, b.itemOfflinePrice));

                          newarrivals.notify();
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(FontAwesome.sort_amount_desc),
                        title: Text(
                          ' Price High-Low',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          newarrivals.lastadded.sort((a, b) =>
                              Comparable.compare(
                                  a.itemOfflinePrice, b.itemOnlinePrice));
                          newarrivals.notify();
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
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
    final edgeInsets = const EdgeInsets.only(left: 8, right: 8, top: 15);
    int _selectTempFirstLevelIndex = -1;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Padding(
                    padding: edgeInsets,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: ListView(
                            children: newarrivals.categories.map((item) {
                              int index1 = newarrivals.categories.indexOf(item);
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectTempFirstLevelIndex = index1;
                                    });
                                  },
                                  child: Container(
                                      height: 50,
                                      color:
                                          _selectTempFirstLevelIndex == index1
                                              ? Colors.grey[200]
                                              : Colors.white,
                                      alignment: Alignment.center,
                                      child: _selectTempFirstLevelIndex ==
                                              index1
                                          ? Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 40,
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.imgUrl,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: Text(
                                                    '${textWidget(item)}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        fontSize: 15),
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 4,
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 20,
                                                  width: 40,
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.imgUrl,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: Text(
                                                    '${textWidget(item)}',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 4,
                                                  ),
                                                )
                                              ],
                                            )));
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.grey[200],
                            child: _selectTempFirstLevelIndex == -1
                                ? Container()
                                : ListView(
                                    children: newarrivals
                                        .categories[_selectTempFirstLevelIndex]
                                        .subCategories
                                        .map((item) {
                                      int index = newarrivals
                                          .categories[
                                              _selectTempFirstLevelIndex]
                                          .subCategories
                                          .indexOf(item);
                                      return GestureDetector(
                                          onTap: () {
                                            /* _selectSecondLevelIndex = index;
                                  _selectFirstLevelIndex =
                                      _selectTempFirstLevelIndex;
                                  if (_selectSecondLevelIndex == 0) {
                                    itemOnTap(
                                        firstLevels[_selectFirstLevelIndex]);
                                  } else {
                                    itemOnTap(item);
                                  }*/
                                            Navigator.pop(context);
                                            newarrivals.resetList(context,
                                                supplierid: id,
                                                category: newarrivals
                                                    .categories[
                                                        _selectTempFirstLevelIndex]
                                                    .subCategories[index]
                                                    .id);
                                          },
                                          child: Container(
                                            height: 40,
                                            alignment: Alignment.centerLeft,
                                            child: Row(children: <Widget>[
                                              SizedBox(
                                                width: 20,
                                              ),
                                              //_selectFirstLevelIndex ==
                                              //      _selectTempFirstLevelIndex &&
                                              //    _selectSecondLevelIndex == index
                                              Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 20,
                                                    width: 40,
                                                    child: CachedNetworkImage(
                                                      imageUrl: item.imgUrl
                                                              .toString() ??
                                                          ' ',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: Text(
                                                      '${textSubWidget(item)}',
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark,
                                                          fontSize: 15),
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 4,
                                                    ),
                                                  )
                                                ],
                                              )
                                              //: Text('${item.categoryName}'),
                                            ]),
                                          ));
                                    }).toList(),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ));
        });
  }

  String textWidget(Categories categories) {
    if (lang.locale.languageCode.toUpperCase() == 'EN')
      return categories.categoryName.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'ZH' &&
        categories.categoryCn != null)
      return categories.categoryCn.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'FR' &&
        categories.categoryFr != null)
      return categories.categoryFr.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'IT' &&
        categories.categoryIt != null)
      return categories.categoryIt.toString();
    else
      return categories.categoryName.toString();
  }

  String textSubWidget(SubCategories categories) {
    if (lang.locale.languageCode.toUpperCase() == 'EN')
      return categories.categoryName.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'ZH' &&
        categories.categoryCn != null)
      return categories.categoryCn.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'FR' &&
        categories.categoryFr != null)
      return categories.categoryFr.toString();
    else if (lang.locale.languageCode.toUpperCase() == 'IT' &&
        categories.categoryIt != null)
      return categories.categoryIt.toString();
    else
      return categories.categoryName.toString();
  }

  void _renderFilterDialog() async {
    final Widget child = FilterDialogWidget1();
    showPlatformDialog(
      context,
      child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).primaryColor,
        //itemBorderRadius:200,
        iconSize: 20,
        borderRadius: 20,
        onTap: (int val) {
          //returns tab id which is user tapped
          print(val);
          switch (val) {
            case 0:
              {
                categorypressed(widget.supplierid);
              }
              break;

            case 1:
              {
                _onSortPressed(context);
              }
              break;
            case 2:
              {
                _renderFilterDialog();
              }
              break;
          }
        },
        currentIndex: -1,
        items: [
          FloatingNavbarItem(
              icon: MaterialCommunityIcons.format_list_bulleted_type,
              title: lang.tr('shopOwner.Category')),
          FloatingNavbarItem(
            icon: Icons.sort,
            title: lang.tr('shopOwner.Sort'),
          ),
          FloatingNavbarItem(
              icon: FontAwesome.barcode, title: lang.tr('shopOwner.Scan')),
        ],
      ),
      body: Stack(
        children: <Widget>[
          getWidget(),
          /*Positioned(
            child: filterWidget(),
            bottom: 2,
            left: 12,
          )*/
        ],
      ),
    );
  }
}
