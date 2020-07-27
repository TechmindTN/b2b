import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/mapp.dart';
import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/widgets/Colors.dart';
import 'package:siyou_b2b/widgets/dottedslider.dart';


class ItemDetailsScreen extends StatefulWidget {
  final Items product;
  final int supplierid;
  final Suppliers supplier;
  final String description;

  const ItemDetailsScreen(
      {Key key, this.product, this.supplierid, this.supplier, this.description})
      : super(key: key);
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen>
    with TickerProviderStateMixin {
  List<String> imglist = [
    /*'https://rukminim1.flixcart.com/image/714/857/jmwch3k0/shoe/j/y/n/dg-292-white-blue-patti-10-digitrendzz-white-original-imaf9p36fkykfjqt.jpeg?q=50',
    'https://assets.adidas.com/images/w_600,f_auto,q_auto:sensitive,fl_lossy/7ed0855435194229a525aad6009a0497_9366/Superstar_Shoes_White_EG4958_01_standard.jpg',
    'https://assets.adidas.com/images/w_600,f_auto,q_auto:sensitive,fl_lossy/15f901c90a9549d29104aae700d27efb_9366/Superstar_Shoes_Black_EG4959_01_standard.jpg'*/
  ];
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppLocalizations lang;
  ProductListProvider _productProvider;
  CartProvider cartProvider;
  int id;
  bool isClicked = false;
  @override
  void initState() {
    super.initState();
  }

  void intil() async {
    await _productProvider.getItems(context, id: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  void dispose() {
    //_productProvider.itmes.clear();
    super.dispose();
  }

  Widget basketWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        return SizedBox(
            height: 25,
            width: 25,
            child: Badge(
              position: BadgePosition(top: -5, right: -15),
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

  @override
  Widget build(BuildContext context) {
    if (widget.product.images.length > 0) {
      imglist.clear();
      widget.product.images.forEach((v) {
        imglist.add(v.imageUrl);
      });
    }
    return Scaffold(
      bottomNavigationBar: Container(
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
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  if (widget.product.itemDiscountPrice == null)
                    Text(
                      "\€ ${widget.product.itemOfflinePrice}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
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
                              CustomColors.RedDark,
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
                              lang.tr('shopOwner.addtocart'),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : new Text(
                        lang.tr('shopOwner.outofstock'),
                        style: TextStyle(color: Colors.red),
                      ),
              ),
            ],
          ),
        ),
      ),
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
              expandedHeight: MediaQuery.of(context).size.height / 2.4,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  this.widget.product.itemBarcode,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
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
                _buildInfo(context), //Product Info
                // _buildExtra(context),
                if (widget.description != null)
                  _buildDescription(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: lang.tr('shopOwner.Shopping Cart'),
      desc: lang.tr('shopOwner.addedcart'),
      buttons: [
        DialogButton(
          child: Text(
            lang.tr('shopOwner.back'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          color: CustomColors.RedDark,
          child: Text(
            lang.tr('shopOwner.gocart'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => LanguageProvider(child: Cart()),
            ),
          ),
          gradient: LinearGradient(colors: [
            Colors.red,
            Colors.red[400]
            //Color.fromRGBO(116, 116, 191, 1.0),
            // Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
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
        for (var i = 0; i < widget.product.images.length; i++)
          _productSlideImage(widget.product.images[i].imageUrl),
      ],
    );
  }

  _buildInfo(context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        //top: BorderSide(width: 1.0, color: Colors.black12),
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            for (var i = 0; i < widget.product.criteriaBase.length; i++)
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 130,
                          child: Text(widget.product.criteriaBase[i].name
                              .toUpperCase())),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      widget.product.criteriaBase[i].name == 'color'
                          ? Center(
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        20.0,
                                      ),
                                      color: Color(HexColor.fromHex(widget
                                          .product
                                          .criteriaBase[i]
                                          .pivot
                                          .criteriaValue)))),
                            )
                          : Center(
                              child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20.0,
                                ),
                              ),
                              child: Text(
                                widget.product.criteriaBase[i].pivot
                                    .criteriaValue,
                              ),
                            )),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(width: 130, child: Text('IN STOCK')),
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
                  child: Text(widget.product.itemQuantity.toString()),
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
                Container(width: 130, child: Text('Package')),
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
                  child: Text(widget.product.itemPackage.toString()),
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
                Container(width: 130, child: Text('BOX')),
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
                  child: Text(widget.product.itemBox.toString()),
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
      height: MediaQuery.of(context).size.height / 3.7,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              lang.tr('shopOwner.description'),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                  fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
            Text(widget.description,
                maxLines: 5, overflow: TextOverflow.ellipsis),
            SizedBox(
              height: 8,
            ),
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
                      Text(widget.description),
                    ],
                  ),
                )),
          );
        });
  }
}

class HexColor extends Color {
  static int fromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.parse(hexColor, radix: 16);
    } catch (e) {
      hexColor = 'FFFFFFFF';
      return int.parse(hexColor, radix: 16);
    }
  }

  HexColor(final String hexColor) : super(fromHex(hexColor));
}
