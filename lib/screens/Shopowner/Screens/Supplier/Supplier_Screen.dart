import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/purchased.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/productlist.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';

import 'Discount.dart';
import 'NewArrivals.dart';

class SupplierScreen extends StatefulWidget {
  final Suppliers supplier;

  const SupplierScreen({Key key, this.supplier}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<SupplierScreen>
    with TickerProviderStateMixin {
  List<String> imglist = [
    'https://docs.google.com/uc?id=1KoP-HGb-Wys1sgR7p9jYZSTfKbvBdrYw'
  ];

  AppLocalizations lang;
  HomeProvider _productProvider;
  //CartProvider _cartProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;
  @override
  void initState() {
    super.initState();
    id = widget.supplier.id;
    _productProvider = Provider.of<HomeProvider>(context, listen: false);
    intil();
  }

  void intil() async {
    await _productProvider.getProducts(context, id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<HomeProvider>(context, listen: false);

    //_productProvider?.getProducts(context, id);
  }

  @override
  void dispose() {
    // _productProvider.lastadded.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* if (widget.supplier.image != '' ||
        widget.supplier.image != null) {
      imglist.clear();
      imglist.add(widget.supplier.image);
    }*/
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
         // backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Row(children: <Widget>[
            Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red[300],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.red,
                            //size: 35,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    LanguageProvider(child: Cart()),
                              ),
                            );
                          },
                        ),
                      ),
          ],),
          elevation: 0,
        ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CarouselProductsList(
                    productsList: imglist,
                    type: CarouselTypes.home,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                     /* Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 35,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),*/
                      
                    ],
                  ),
                ],
              ),
              Container(
                child: _buildDetailsAndMaterialWidgets(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*Widget getWidget() {
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
            scrollDirection: Axis.horizontal,
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
  }*/

  _buildDetailsAndMaterialWidgets() {
    TabController tabController = new TabController(length: 4, vsync: this);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Text(
                  lang.tr('Discounts'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('New Arrivals'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('Purchased'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('Discover'),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            height: MediaQuery. of(context). size.height-MediaQuery. of(context). size.height*1/2.5788,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Discount(
                  supplierid: id,
                ),
                NewArrivals(
                  supplierid: id,
                ),
                Purchased(
                  supplierid: id,
                ),
                ProductList(suppid: id,)
              ],
            ),
          ),
        ],
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
