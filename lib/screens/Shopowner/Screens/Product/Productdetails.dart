import 'package:badges/badges.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/Product.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/widgets/dottedslider.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import 'Itemdetails.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  List<String> imglist = [
    'https://previews.123rf.com/images/blankstock/blankstock1708/blankstock170801372/84251784-online-shopping-cart-line-icon-monitor-sign-supermarket-basket-symbol-report-information-and-refresh.jpg'
  ];

  AppLocalizations lang;
  ProductListProvider _productProvider;
  //CartProvider _cartProvider;
  var _cartProvider;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;

  @override
  void initState() {
    id = widget.product.id;

    _productProvider = Provider.of<ProductListProvider>(context, listen: false);

    intil();
    super.initState();
  }

  void intil() async {
    await _productProvider.getItems(context, id: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _cartProvider = Provider.of<CartProvider>(context);
    //_productProvider.getItems(context, id: id);
  }

  @override
  void dispose() {
    _productProvider.itmes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product.productImage != '' ||
        widget.product.productImage != null) {
      imglist.clear();
      imglist.add(widget.product.productImage);
    }
    return Scaffold(
      /* bottomNavigationBar: Container(
        color: Colors.white54,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 11,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    child: Divider(
                      color: Colors.black26,
                      height: 4,
                    ),
                    height: 24,
                  ),
                  if (widget.product.itemDiscountPrice != null)
                    Text(
                      "\€ ${widget.product.itemOfflinePrice}",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough),
                    ),
                  if (widget.product.itemDiscountPrice != null)
                    SizedBox(
                      width: 6,
                    ),
                  if (widget.product.itemDiscountPrice != null)
                    Text(
                      "\€ ${widget.product.itemDiscountPrice}",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  if (widget.product.itemDiscountPrice == null)
                    Text(
                      "\€ ${widget.product.itemOfflinePrice}",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    )
                ],
              ),
              SizedBox(
                width: 6,
              ),
              RaisedButton(
                onPressed: () {
                  if (widget.product.itemQuantity > 0) {
                    cartProvider.addCartItems(
                        widget.product,
                        widget.product.itemPackage,
                        widget.supplierid,
                        widget.supplier);
                    _alert(context);
                  }
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: widget.product.itemQuantity > 0
                    ? Container(
                        width: MediaQuery.of(context).size.width / 2.9,
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              CustomColors.TextHeader,
                              CustomColors.TrashRed,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white54,
                              blurRadius: 15.0,
                              spreadRadius: 7.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            new Text(
                              "Add to Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : new Text(
                        "OUT OF STOCK",
                        style: TextStyle(color: Colors.red),
                      ),
              ),
            ],
          ),
        ),
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                /*  GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.black,
                  ),
                ),*/
                basketWidget(),
                SizedBox(width: 25),
              ],
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              expandedHeight: MediaQuery.of(context).size.height / 2.5,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    this.widget.product.productName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                background: Padding(
                  padding: EdgeInsets.only(top: 48.0),
                  child: dottedSlider(),
                ),
              ),
            ),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getWidget(),
                _buildInfo(context), //Product Info
                // _buildExtra(context),

                if (widget.product.productDescription != null)
                  _buildDescription(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _productSlideImage(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(imageUrl), fit: BoxFit.scaleDown),
      ),
    );
  }

  dottedSlider() {
    return DottedSlider(
      maxHeight: 200,
      children: <Widget>[
        for (var i = 0; i < imglist.length; i++) _productSlideImage(imglist[i]),
      ],
    );
  }

  _buildInfo(context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: Colors.black12),
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 130, child: Text(lang.tr('shopOwner.Supplier'))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Text(widget.product.supplier.firstName +
                      ' ' +
                      widget.product.supplier.lastName),
                )),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(width: 130, child: Text(lang.tr('shopOwner.Brand'))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Text(widget.product.brand.brandName),
                )),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 130, child: Text(lang.tr('shopOwner.Category'))),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Text(widget.product.category.categoryName),
                )),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  _buildDescription(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              lang.tr('shopOwner.description'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            Text(
              widget.product.productDescription,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            /* SizedBox(
              height: 5,
            ),*/
            Center(
              child: GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context);
                },
                child: Text(
                  lang.tr('shopOwner.viewmore'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16),
                ),
              ),
            ),
            Divider(
              height: 2,
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        lang.tr('shopOwner.description'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(widget.product.productDescription),
                    ],
                  ),
                )),
          );
        });
  }

  Widget getWidget() {
    return Consumer<ProductListProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.itmes != null && provider.itmes.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.itmes.length,
            itemBuilder: (context, index) => _getItemWidget(index),
            // physics:  NeverScrollableScrollPhysics(),
          );
        } else
          return Container(
            child: Center(
              child: Text("No data found"),
            ),
          );
      },
    );
  }

  Widget basketWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        return SizedBox(
            width: 25,
            child: Badge(
              position: BadgePosition(top: -5, right: -15),
              animationDuration: Duration(milliseconds: 250),
              animationType: BadgeAnimationType.scale,
              badgeContent: Text(_cartProvider.itmes.length.toString(),
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

  Widget _getItemWidget(
    int index,
  ) {
    int _currentAmount = _productProvider.itmes[index].itemPackage;

    return Stack(
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
                            product: _productProvider.itmes[index],
                            supplierid: widget.product.supplierId,
                            description: widget.product.productDescription,
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
                        child: _productProvider.itmes[index].images == null ||
                                _productProvider.itmes[index].images.isEmpty
                            ? Image.asset(
                                "assets/png/empty_cart.png",
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              )
                            : CachedNetworkImage(
                                imageUrl: _productProvider
                                    .itmes[index].images[0].imageUrl,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                )),
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  _productProvider.itmes[index].id.toString() +
                                      '/' +
                                      _productProvider.itmes[index].itemBarcode
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
                              text: lang.tr('shopOwner.box') +
                                  _productProvider.itmes[index].itemBox
                                      .toString() +
                                  lang.tr('shopOwner.pack') +
                                  _productProvider.itmes[index].itemPackage
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
                _productProvider.itmes[index].itemOfflinePrice
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
        _productProvider.itmes[index].itemQuantity > 0
            ? Positioned(
                child: Container(
                  // height: 40,
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
                            /*GestureDetector(
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
                              _productProvider.itmes[index].quantity -
                                          _productProvider
                                              .itmes[index].itemPackage >
                                      0
                                  ? _productProvider.itmes[index].quantity -=
                                      _productProvider.itmes[index].itemPackage
                                  : _productProvider.itmes[index].quantity = 0;
                              _productProvider.notify();
                            },
                          ),*/
                            if (_cartProvider.checkinCart(
                                    _productProvider.itmes[index]) >
                                -1)
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  child: _cartProvider
                                              .itmes[_cartProvider.checkinCart(
                                                  _productProvider
                                                      .itmes[index])]
                                              .quantity >
                                          _cartProvider
                                              .itmes[_cartProvider.checkinCart(
                                                  _productProvider
                                                      .itmes[index])]
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
                                onTap: () => _cartProvider.removeCartItem(
                                    _productProvider.itmes[index]),
                              ),
                            SizedBox(width: 15),
                            _cartProvider.checkinCart(
                                        _productProvider.itmes[index]) ==
                                    -1
                                ? Text(
                                    _productProvider.itmes[index].quantity
                                        .toString(),
                                    style: Theme.of(context).textTheme.title,
                                  )
                                : Text(
                                    _cartProvider
                                        .itmes[_cartProvider.checkinCart(
                                            _productProvider.itmes[index])]
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
                                _cartProvider.addCartItems(
                                    _productProvider.itmes[index],
                                    _currentAmount,
                                    widget.product.supplier.id,
                                    _productProvider
                                        .itmes[index].product.supplier);

                                //_scaffoldKey.currentState.showSnackBar(
                                // SnackBar(content: Text('Added To Cart.')));
                                // _productProvider.notify();
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
                top: 50,
              )
      ],
    );
  }

  // ignore: unused_element
  void _onItemPressed(BuildContext context, String barcode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Wrap(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      BarCodeImage(
                        params: EAN13BarCodeParams(
                          barcode,
                          lineWidth: 2.0,
                          barHeight: 80.0,
                          withText: true,
                        ),
                        onError: (error) {
                          // Error handler
                          print('error = $error');
                        },
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
}
