
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';


class ItemDetailsScreen extends StatefulWidget {
  final Items product;
  final int supplierid;

  const ItemDetailsScreen({Key key, this.product,this.supplierid}) : super(key: key);
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppLocalizations lang;
  ProductListProvider _productProvider;
  int id;
  int _currentAmount = 0;
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
  }

  @override
  void dispose() {
    //_productProvider.itmes.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    if (widget.product.images.length > 0) {
      imglist.clear();
      widget.product.images.forEach((v) {
        imglist.add(v.imageUrl);
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                      "${widget.product.itemBarcode}",
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
              
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
                child: Text(
                  "€. ${widget.product.itemOfflinePrice}",
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25),
                ),
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
                height: 5,
              ),

              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 5),
                    Container(
                      //width: 135,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3.0, vertical: 9.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                          child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentAmount - widget.product.itemPackage > 0
                                    ? _currentAmount -=
                                        widget.product.itemPackage
                                    : _currentAmount = 0;
                              });
                            },
                          ),
                          SizedBox(width: 15),
                          Text(
                            "$_currentAmount",
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _currentAmount += widget.product.itemPackage;
                              });
                            },
                          ),
                        ],
                      )),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        height: double.infinity,
                        child: RaisedButton(
                          child: Text(
                            lang.tr('shopOwner.addtocart'),
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState.showSnackBar(
                                SnackBar(content: Text('Added To Cart.')));
                            _cartProvider.addCartItems(
                                widget.product, _currentAmount,widget.supplierid);
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                    /* Container(
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
                    /*Container(
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
              ),
              SizedBox(
                height: 12,
              ),

              Container(
                child: _buildDetailsAndMaterialWidgets(widget.product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDetailsAndMaterialWidgets(Items product) {
    TabController tabController = new TabController(length: 2, vsync: this);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
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
                  /*Text(
                      'product.productDescription',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),*/
                  Text(
                    'Quantity : ' + widget.product.itemQuantity.toString(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  /* Text(
                      'Brand : ', // + widget.product.brand.brandName,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Category : ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),*/
                  Text(
                    'Package : ' + widget.product.itemPackage.toString(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Box : ' + widget.product.itemBox.toString(),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: new ListView.builder(
                  //shrinkWrap: true,
                  itemCount: widget.product.criteriaBase.length,
                  itemBuilder: (context, index) => Row(
                    children: <Widget>[
                      Container(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 10),
                          child: Text(
                            widget.product.criteriaBase[index].name + '  : ',
                            style: Theme.of(context).textTheme.button.copyWith(
                                  color: Colors.black,
                                ),
                          )),
                      if (widget.product.criteriaBase[index].name == 'color')
                        Container(
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Color(HexColor.fromHex(widget.product
                                    .criteriaBase[index].pivot.criteriaValue))))
                      else
                        Container(
                            padding:
                                const EdgeInsets.only(right: 15.0, bottom: 10),
                            child: Text(
                              widget.product.criteriaBase[index].pivot
                                  .criteriaValue,
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.black,
                                      ),
                            )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class HexColor extends Color {
  static int fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(fromHex(hexColor));
}
