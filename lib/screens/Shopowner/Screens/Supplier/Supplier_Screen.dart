import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/purchased.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/product/productlist.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:badges/badges.dart';
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
  TabController tabController;
  AppLocalizations lang;
  HomeProvider _productProvider;
  CartProvider cartProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    id = widget.supplier.id;
    _productProvider = Provider.of<HomeProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    intil();
  }

  void intil() async {
    await _productProvider?.getProducts(context, id);

    await _productProvider?.getCategories(context, id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    //_productProvider = Provider.of<HomeProvider>(context, listen: false);
    //if (_productProvider.discounts.isEmpty||_productProvider.purchased.isEmpty)
    // _productProvider?.getProducts(context, id);

    //_productProvider?.getProducts(context, id);
  }

  /*@override
  void dispose() {
    // _productProvider.lastadded.clear();
    super.dispose();
  }*/

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
        backgroundColor: Colors.white,
        titleSpacing: 0.00,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          children: <Widget>[
            Text(
              widget.supplier.firstName.toUpperCase(),
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
                //size: 35,
              ),
              onPressed: () {
                _productProvider.resetList(context, supplierid: id);
              },
            ),
            basketWidget(),
            SizedBox(
              width: 15,
            )
            // Spacer(),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: CarouselProductsList(
                productsList: imglist,
                type: CarouselTypes.home,
              )),
              Expanded(
                flex: 5,
                child: _buildDetailsAndMaterialWidgets(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDetailsAndMaterialWidgets() {
    //TabController tabController = new TabController(length: 4, vsync: this);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(
                child: Text(
                  lang.tr('shopOwner.Discounts'),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('shopOwner.New Arrivals'),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('shopOwner.Purchased'),
                ),
              ),
              Tab(
                child: Text(
                  lang.tr('shopOwner.Discovery'),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            height: MediaQuery.of(context).size.height - 240,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Discount(
                  supplierid: id,
                  supplier: widget.supplier,
                ),
                NewArrivals(
                  supplierid: id,
                  supplier: widget.supplier,
                ),
                Purchased(
                  supplierid: id,
                  supplier: widget.supplier,
                ),
                // ProductsListScreen()
                ChangeNotifierProvider(
                    create: (_) => ProductListProvider(),
                    child: LanguageProvider(
                      child: ProductList(suppid: id),
                    )),
              ],
            ),
          ),
        ],
      ),
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
