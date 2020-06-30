import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/Product.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import 'Itemdetails.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;
  @override
  void initState() {
    super.initState();
    id = widget.product.id;
    intil();
  }

  void intil() async {
    await _productProvider.getItems(context, id: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<ProductListProvider>(context, listen: false);

    _productProvider.getItems(context, id: id);
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${widget.product.productName}",
                        style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),

                CarouselProductsList(
                  productsList: imglist,
                  type: CarouselTypes.details,
                ),
                //Spacer(),
                SizedBox(
                  height: 12,
                ),
                /*Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products[widget.id].tags.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Chip(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          label: Text(
                            "${products[widget.id].tags[i]}",
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),*/
                // Spacer(),
                //Spacer(),
                /* Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    
                  ],
                ),
              ),*/

                SizedBox(
                  height: 12,
                ),

                /*Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3.0, vertical: 9.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: MyCounter(),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              "Buy Now",
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.white,
                                      ),
                            ),
                            onPressed: () {},
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 15),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      /* Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),*/
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 250,
                  child: _buildProductitmes(),
                ),
                Container(
                  child: _buildDetailsAndMaterialWidgets(widget.product),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  _buildProductitmes() {
    return getWidget();
  }

  _buildDetailsAndMaterialWidgets(Product product) {
    TabController tabController = new TabController(length: 2, vsync: this);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  lang.tr('shopOwner.Details'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('shopOwner.Specification'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            height: 200.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Product Description : ' + product.productDescription,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Supplier : ' +
                          widget.product.supplier.firstName +
                          ' ' +
                          widget.product.supplier.lastName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Brand : ' + widget.product.brand.brandName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Category : ' + widget.product.category.categoryName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Package : ' + widget.product.productPackage.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Box : ' + widget.product.productBox.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _getItemWidget(int index,) 
{
  int _currentAmount = _productProvider.itmes[index].itemPackage;
    var _cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => LanguageProvider(
                child: ChangeNotifierProvider(
                  child: ItemDetailsScreen(
                    product: _productProvider.itmes[index],supplierid: widget.product.supplierId,
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
                        child: _productProvider.itmes[index].images == null ||
                                _productProvider.itmes[index].images.isEmpty
                            ? Image.asset(
                                "assets/png/empty_cart.png",
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              )
                            : CachedNetworkImage(
                                imageUrl: _productProvider.itmes[index].images[0].imageUrl,
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
                        /*Text(
                          _productProvider.itmes[index].product.productName.toString(),
                          style: TextStyle(
                            //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'NunitoSans',
                            fontSize: 17.0,
                          ),
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _productProvider.itmes[index].id
                                          .toString() +
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
                                  text: ' Box: ' +
                                      _productProvider.itmes[index].itemBox
                                          .toString() +
                                      ' Package: ' +
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
                              _productProvider.itmes[index].quantity -
                                          _productProvider.itmes[index].itemPackage >
                                      0
                                  ? _productProvider.itmes[index].quantity -=
                                      _productProvider.itmes[index].itemPackage
                                  : _productProvider.itmes[index].quantity = 0;
                              _productProvider.notify();
                            },
                          ),
                          SizedBox(width: 15),
                          Text(
                            _productProvider.itmes[index].quantity.toString(),
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
                              _cartProvider.addCartItems(
                          _productProvider.itmes[index], _currentAmount,widget.product.supplierId);
                      //_scaffoldKey.currentState.showSnackBar(
                         // SnackBar(content: Text('Added To Cart.')));
                              _productProvider.notify();
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
  Widget _getItemWidget1(int index) {
    int _currentAmount = _productProvider.itmes[index].itemPackage;
    var _cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => LanguageProvider(
              child: ChangeNotifierProvider(
                child:
                    ItemDetailsScreen(product: _productProvider.itmes[index],supplierid: widget.product.supplierId,),
                create: (_) => ProductListProvider(),
              ),
            ),
          ),
        );
      },
      child: Card(
        elevation: 5.0,
        //margin: EdgeInsets.all(value),
        child: Container(
          padding: new EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _productProvider.itmes[index].itemBarcode,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  SizedBox.fromSize(
                    size: Size(20, 20),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black,
                        child: InkWell(
                            splashColor: Colors.green,
                            onTap: () {
                              _onItemPressed(context,
                                  _productProvider.itmes[index].itemBarcode);
                            },
                            child: Icon(
                              Icons.code,
                              size: 15,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Center(
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  // elevation: 10.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(200.0),
                    ),
                    child: Container(
                      height: 125.0,
                      width: 170.0,
                      child: _productProvider.itmes[index].images == null ||
                              _productProvider.itmes[index].images.length == 0
                          ? Image.asset(
                              "assets/png/empty_cart.png",
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : CachedNetworkImage(
                              imageUrl: _productProvider
                                  .itmes[index].images[0].imageUrl,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "€. ${_productProvider.itmes[index].itemOfflinePrice}",
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Pack/box:' +
                        _productProvider.itmes[index].itemPackage.toString() +
                        '/' +
                        _productProvider.itmes[index].itemBox.toString(),
                    style: TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
              /* Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Brand',
                        style: TextStyle(
                          color: Color(0xFFB7B7B7),
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Category',
                        style: TextStyle(
                          color: Color(0xFFB7B7B7),
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                    ],
                  ),*/
                  SizedBox(
                        height: 10.0,
                      ),
              Row(
                children: <Widget>[
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      "$_currentAmount",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  //height: 50,
                  child: RaisedButton(
                    child: Text(
                      (lang.tr('shopOwner.quickadd')),
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    onPressed: () {
                      _cartProvider.addCartItems(
                          _productProvider.itmes[index], _currentAmount,widget.product.supplierId);
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Added To Cart.')));
                    },
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ])

              /* Row(
                    children: <Widget>[
                      SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3.0, vertical: 9.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: MyCounter(),
                        ),
                      ),
                     // SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              "Buy Now",
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.white,
                                      ),
                            ),
                            onPressed: () {},
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    /*  Container(
                        margin: const EdgeInsets.only(right: 15),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),*/
                      /* Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),*/
                    ],
                  ),*/
            ],
          ),
        ),
      ),
    );
  }

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
