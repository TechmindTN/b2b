import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/Itemdetails.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/LoadingWidget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../../main.dart';

class Discount extends StatefulWidget {
  final int supplierid;
  final Suppliers supplier;
  final List<Categories> categorylist;

  const Discount({Key key, this.supplierid, this.supplier, this.categorylist})
      : super(key: key);
  @override
  _DiscountState createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  AppLocalizations lang;
  HomeProvider newarrivals;
  CartProvider cartProvider;
  ScrollController _scrollController = new ScrollController();
  int categoryid;
  int id;
  String category = '';
  String sort = '';
  GlobalKey _stackKey = GlobalKey();
  int _selectTempFirstLevelIndex = -1;
  GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();

  @override
  void initState() {
    super.initState();
    newarrivals = Provider.of<HomeProvider>(context, listen: false);
    id = widget.supplierid;
    newarrivals?.getdiscounts(context, supplierid: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    category = lang.tr('shopOwner.Category');
    sort = lang.tr('shopOwner.Sort');
    cartProvider = Provider.of<CartProvider>(context);
  }

  Widget getWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return OpssWidget(
            onPress: newarrivals.resetList(context, supplierid: id),
          );
        else if (provider.loading)
          return ListView(
            children: <Widget>[
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
            ],
          );
        else if (provider.discounts != null && provider.discounts.isNotEmpty) {
          if (!provider.isGrid)
            return ListView.builder(
              controller: _scrollController,
              itemCount: provider.discounts.length,
              itemBuilder: (context, index) => _getItemWidget(index),
            );
          else
            return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: provider.discounts.length,
              itemBuilder: (context, index) => _getItemWidgetGrid(index),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              crossAxisCount: 4,
            );
        } else
          return Container(
            child: Center(
              child: Text("No Data Found ! "),
            ),
          );
      },
    );
  }

  Widget _getItemWidget(
    int index,
  ) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
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
                                product: newarrivals.discounts[index],
                                supplierid: widget.supplierid,
                                description: newarrivals.discounts[index]
                                    .product.productDescription,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          child: Container(
                            height: 85.0,
                            width: 80.0,
                            child: newarrivals.discounts[index].images ==
                                        null ||
                                    newarrivals.discounts[index].images.isEmpty
                                ? Image.asset(
                                    "assets/png/empty_cart.png",
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: newarrivals
                                        .discounts[index].images[0].imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => LanguageProvider(
                                        child: ChangeNotifierProvider(
                                          child: ItemDetailsScreen(
                                            product:
                                                newarrivals.discounts[index],
                                            supplierid: widget.supplierid,
                                            description: newarrivals
                                                .discounts[index]
                                                .product
                                                .productDescription,
                                          ),
                                          create: (_) => ProductListProvider(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  newarrivals
                                      .discounts[index].product.productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: newarrivals.discounts[index].id
                                          .toString() +
                                      '/' +
                                      newarrivals.discounts[index].itemBarcode
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
                                      newarrivals.discounts[index].itemBox
                                          .toString() +
                                      ' Package: ' +
                                      newarrivals.discounts[index].itemPackage
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                              WidgetSpan(
                                child: SizedBox(
                                  width: 20,
                                ),
                              ),
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
                '€ ' + newarrivals.discounts[index].itemOfflinePrice.toString(),
                style: TextStyle(
                  color: Colors.black, //Color(0xFFB7B7B7),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  // fontFamily: 'NunitoSans',
                  fontSize: 16.0,
                ),
              ),
              right: 15,
              top: 35,
            ),
            Positioned(
              child: Text(
                '€ ' +
                    newarrivals.discounts[index].itemDiscountPrice.toString(),
                style: TextStyle(
                  color:
                      Theme.of(context).primaryColorDark, //Color(0xFFB7B7B7),
                  fontWeight: FontWeight.w500,

                  // fontFamily: 'NunitoSans',
                  fontSize: 16.0,
                ),
              ),
              right: 15,
              top: 15,
            ),
            newarrivals.discounts[index].itemQuantity > 0
                ? Positioned(
                    child: Container(
                      //height: 70,
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
                                if (cartProvider.checkinCart(
                                        newarrivals.discounts[index]) >
                                    -1)
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      child: cartProvider
                                                  .itmes[cartProvider
                                                      .checkinCart(newarrivals
                                                          .discounts[index])]
                                                  .quantity >
                                              cartProvider
                                                  .itmes[cartProvider
                                                      .checkinCart(newarrivals
                                                          .discounts[index])]
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
                                        newarrivals.discounts[index]),
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
                                    cartProvider.addCartItems(
                                        newarrivals.discounts[index],
                                        newarrivals
                                            .discounts[index].itemPackage,
                                        widget.supplierid,
                                        widget.supplier);
                                    //newarrivals.notify();
                                  },
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    right: 0.5,
                    top: 55,
                  )
                : Positioned(
                    child: Text(
                      lang.tr('shopOwner.outofstock'),
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                    right: 20,
                    top: 60,
                  ),
            Positioned(
                left: 10,
                top: 10,
                child: cartProvider.checkinCart(newarrivals.discounts[index]) ==
                        -1
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        child: Text(
                          cartProvider
                              .itmes[cartProvider
                                  .checkinCart(newarrivals.discounts[index])]
                              .quantity
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      )),
          ],
        ),
        Divider(
          thickness: 2,
          color: Colors.black12,
          height: 5,
        ),
      ],
    );
  }

  Widget _getItemWidgetGrid(int index) {
    return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            //side: new BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Stack(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
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
                                    product: newarrivals.discounts[index],
                                    supplierid: widget.supplierid,
                                    description: newarrivals.discounts[index]
                                        .product.productDescription,
                                  ),
                                  create: (_) => ProductListProvider(),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: newarrivals.discounts[index].images ==
                                            null ||
                                        newarrivals
                                            .discounts[index].images.isEmpty
                                    ? Image.asset(
                                        "assets/png/empty_cart.png",
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: newarrivals.discounts[index]
                                            .images[0].imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Text(
                          newarrivals.discounts[index].product.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        )),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: newarrivals.discounts[index].id.toString() +
                                  '/' +
                                  newarrivals.discounts[index].itemBarcode
                                      .toString(),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 9)),
                        ],
                      ),
                    ),
                    newarrivals.discounts[index].itemDiscountPrice == null
                        ? Text(
                            newarrivals.discounts[index].itemOfflinePrice
                                    .toStringAsFixed(2) +
                                ' €',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColorDark, //Color(0xFFB7B7B7),
                              fontWeight: FontWeight.w500,
                              // fontFamily: 'NunitoSans',
                              fontSize: 15.0,
                            ),
                          )
                        : Row(
                            children: <Widget>[
                              Text(
                                newarrivals.discounts[index].itemDiscountPrice
                                        .toString() +
                                    ' €',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColorDark, //Color(0xFFB7B7B7),
                                  fontWeight: FontWeight.w500,

                                  // fontFamily: 'NunitoSans',
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                newarrivals.discounts[index].itemOfflinePrice
                                        .toString() +
                                    ' €',
                                style: TextStyle(
                                  color: Colors.black, //Color(0xFFB7B7B7),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                  // fontFamily: 'NunitoSans',
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )),
            newarrivals.discounts[index].itemQuantity >=
                    newarrivals.discounts[index].itemPackage
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
                              border: Border.all(
                                  color: Colors.transparent, width: 1),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                                child: Row(
                              children: <Widget>[
                                if (cartProvider.checkinCart(
                                        newarrivals.discounts[index]) >
                                    -1)
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      child: cartProvider
                                                  .itmes[cartProvider
                                                      .checkinCart(newarrivals
                                                          .discounts[index])]
                                                  .quantity >
                                              cartProvider
                                                  .itmes[cartProvider
                                                      .checkinCart(newarrivals
                                                          .discounts[index])]
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
                                        newarrivals.discounts[index]),
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
                                    cartProvider.addCartItems(
                                        newarrivals.discounts[index],
                                        newarrivals
                                            .discounts[index].itemPackage,
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
                    bottom: -20,
                  )
                : Positioned(
                    child: Text(
                      lang.tr('shopOwner.outofstock'),
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
                    ),
                    //right: 20,
                    bottom: 15,
                  ),
            Positioned(
                left: 10,
                top: 10,
                child: cartProvider.checkinCart(newarrivals.discounts[index]) ==
                        -1
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //         <--- border radius here
                                )),
                        child: Text(
                          cartProvider
                              .itmes[cartProvider
                                  .checkinCart(newarrivals.discounts[index])]
                              .quantity
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      )),
          ],
        ));
  }

  _onSortPressed(void itemOnTap()) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
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
                    lang.tr('shopOwner.NameA-Z'),
                  ),
                  onTap: () {
                    sort = lang.tr('shopOwner.NameA-Z');
                    itemOnTap();
                    newarrivals.discounts.sort((a, b) => Comparable.compare(
                        a.product.productName.toLowerCase(),
                        b.product.productName.toLowerCase()));
                    newarrivals.notify();
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(FontAwesome.sort_alpha_desc),
                  title: Text(
                    lang.tr('shopOwner.NameZ-A'),
                  ),
                  onTap: () {
                    sort = lang.tr('shopOwner.NameZ-A');
                    itemOnTap();
                    newarrivals.discounts.sort((b, a) => Comparable.compare(
                        a.product.productName.toLowerCase(),
                        b.product.productName.toLowerCase()));
                    newarrivals.notify();
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(FontAwesome.sort_amount_asc),
                  title: Text(
                    lang.tr('shopOwner.pricelow-hight'),
                  ),
                  onTap: () {
                    sort = lang.tr('shopOwner.pricelow-hight');
                    itemOnTap();
                    newarrivals.discounts.sort((a, b) => Comparable.compare(
                        a.itemOfflinePrice, b.itemOfflinePrice));

                    newarrivals.notify();
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(FontAwesome.sort_amount_desc),
                  title: Text(
                    lang.tr('shopOwner.pricehigh-low'),
                  ),
                  onTap: () {
                    sort = lang.tr('shopOwner.pricehigh-low');
                    itemOnTap();
                    newarrivals.discounts.sort((b, a) => Comparable.compare(
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
  }

  _buildCategoryWidget(void itemOnTap()) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: ListView(
              children: widget.categorylist.map((item) {
                int index1 = widget.categorylist.indexOf(item);
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectTempFirstLevelIndex = index1;
                      });
                    },
                    child: Container(
                        height: 50,
                        color: _selectTempFirstLevelIndex == index1
                            ? Colors.grey[200]
                            : Colors.white,
                        alignment: Alignment.center,
                        child: _selectTempFirstLevelIndex == index1
                            ? Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                    child: CachedNetworkImage(
                                      imageUrl: item.imgUrl.toString(),
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
                                          fontSize: 12),
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
                                      imageUrl: item.imgUrl.toString(),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Text(
                                      '${textWidget(item)}',
                                      style: TextStyle(fontSize: 15),
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
                      children: widget.categorylist[_selectTempFirstLevelIndex]
                          .subCategories
                          .map((item) {
                        int index = widget
                            .categorylist[_selectTempFirstLevelIndex]
                            .subCategories
                            .indexOf(item);
                        return GestureDetector(
                            onTap: () {
                              newarrivals.resetList(context,
                                  supplierid: id,
                                  category: widget
                                      .categorylist[_selectTempFirstLevelIndex]
                                      .subCategories[index]
                                      .id);
                              category = textSubWidget(widget
                                  .categorylist[_selectTempFirstLevelIndex]
                                  .subCategories[index]);
                              itemOnTap();
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              child: Row(children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                      width: 40,
                                      child: CachedNetworkImage(
                                        imageUrl: item.imgUrl.toString() ?? ' ',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Text(
                                        '${textSubWidget(item)}',
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
                              ]),
                            ));
                      }).toList(),
                    ),
            ),
          )
        ],
      ),
    );
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

  Widget basketWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        return SizedBox(
            //height: 25,
            width: 25,
            child: Badge(
              animationDuration: Duration(milliseconds: 250),
              animationType: BadgeAnimationType.scale,
              badgeContent: Text(cartProvider.itmes.length.toString(),
                  style: new TextStyle(color: Colors.white)),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => LanguageProvider(child: Cart()),
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget isGridWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.isGrid)
          return SizedBox(
            //width: 25,
            child: IconButton(
                icon: Icon(
                  FontAwesome.th_large,
                  color: Colors.black,
                ),
                onPressed: () {
                  provider.isGrid = !provider.isGrid;
                  provider.notify();
                }),
          );
        else
          return SizedBox(
            // width: 25,
            child: IconButton(
                icon: Icon(
                  FontAwesome.th_list,
                  color: Colors.black,
                ),
                onPressed: () {
                  provider.isGrid = !provider.isGrid;
                  provider.notify();
                }),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            lang.tr('shopOwner.Discounts'),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20, top: 5),
              child: isGridWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, top: 5),
              child: basketWidget(),
            )
          ],
        ),
        body: Stack(key: _stackKey, children: <Widget>[
          Column(
            children: <Widget>[
              GZXDropDownHeader(
                items: [
                  GZXDropDownHeaderItem(category),
                  GZXDropDownHeaderItem(sort),
                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: (index) {
                  print(newarrivals.categories.length);
                },
                style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                dropDownStyle: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(child: getWidget()),
            ],
          ),
          GZXDropDownMenu(
            controller: _dropdownMenuController,
            animationMilliseconds: 300,
            dropdownMenuChanging: (isShow, index) {},
            dropdownMenuChanged: (isShow, index) {},
            menus: [
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _buildCategoryWidget(() {
                    _dropdownMenuController.hide();

                    setState(() {});
                  })),
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _onSortPressed(() {
                    _dropdownMenuController.hide();

                    setState(() {});
                  })),
            ],
          ),
        ]));
  }
}
