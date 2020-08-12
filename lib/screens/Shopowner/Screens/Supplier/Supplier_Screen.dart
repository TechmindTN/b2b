import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/ProdcutListAll.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/purchased.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/cart.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:badges/badges.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
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
  int categoryid = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int id;
  @override
  void initState() {
    super.initState();
    id = widget.supplier.id;
    _productProvider = Provider.of<HomeProvider>(context, listen: false);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    intil();
  }

  void intil() async {
    //await _productProvider?.getProducts(context, id);

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
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
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: basketWidget(),
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
              CarouselProductsList(
                productsList: imglist,
                type: CarouselTypes.home,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                margin: EdgeInsets.only(bottom: 5),
                color: Colors.white,
                child: _headerpart(),
              ),
              Expanded(
                flex: 5,
                child: getWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerpart() {
    return Row(
      children: <Widget>[
        FlatButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => NewArrivals(
                supplierid: id,
                supplier: widget.supplier,
                categorylist: _productProvider.categories,
              ),
            )),
          },
          //color: Colors.orange,
          padding: EdgeInsets.only(
            top: 10.0,
            left: 2.0,
            right: 2.0,
          ),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/Newarrivals.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Text(
                  lang.tr('shopOwner.New Arrivals'),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ALLCategoriesScreen(
                    suppid: widget.supplier.id,
                    appbarName: lang.tr('shopOwner.recommended'))))
          },
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/Recommend.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text(
                  lang.tr('shopOwner.recommended'),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Discount(
                supplierid: id,
                supplier: widget.supplier,
                categorylist: _productProvider.categories,
              ),
            )),
          },
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/Promotion.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5.2,
                child: Text(
                  lang.tr('shopOwner.Discounts'),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Purchased(
                supplierid: id,
                supplier: widget.supplier,
                categorylist: _productProvider.categories,
              ),
            ))
          },
          //color: Colors.orange,
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/history.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5.2,
                child: Text(
                  lang.tr('shopOwner.Purchased'),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error) {
          // provider.resetsupp(context);
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        } else if (provider.loading)
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                width: double.infinity,
                //height: 250,
                child: Image.asset(
                  "assets/jpg/MonkeyLoading.gif",
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: double.infinity,
                ),
              ),
            ),
          );
        else if (provider.categories != null &&
            provider.categories.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            //controller: _scrollController,
            itemCount: provider.categories.length,
            itemBuilder: (context, index) => _getItemWidget(index),
          );
        } else
          return Container(
            child: Text(
              "No data found",
              textAlign: TextAlign.center,
            ),
          );
      },
    );
  }

  Widget _getItemWidget(int index) {
    final edgeInsets = const EdgeInsets.only(bottom: 5);
    return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: ListView(children: <Widget>[
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ALLCategoriesScreen(
                          suppid: widget.supplier.id,
                          appbarName: widget.supplier.firstName +
                              ' ' +
                              widget.supplier.lastName,
                        )));
              },
              title: Text(lang.tr('shopOwner.Showall'),
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 14)),
              trailing: Icon(Icons.chevron_right, color: Colors.black45),
            ),
          ),
          Container(
            padding: edgeInsets,
          ),
          Container(
              color: Colors.white,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _productProvider.categories.length,
                  itemBuilder: (_, index) {
                    return ExpansionTile(
                      leading: SizedBox(
                        height: 45,
                        width: 60,
                        child: CachedNetworkImage(
                          imageUrl: _productProvider.categories[index].imgUrl
                                  .toString() ??
                              ' ',
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Text(
                          textWidget(_productProvider.categories[index]),
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontSize: 12)),
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _productProvider
                                .categories[index].subCategories.length,
                            itemBuilder: (_, i) {
                              return ListTile(
                                  onTap: () {
                                    setState(() {
                                      categoryid ==
                                              _productProvider.categories[index]
                                                  .subCategories[i].id
                                          ? categoryid = null
                                          : categoryid = categoryid =
                                              _productProvider.categories[index]
                                                  .subCategories[i].id;
                                    });
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ALLCategoriesScreen(
                                                  suppid: widget.supplier.id,
                                                  categorieid: categoryid,
                                                  appbarName: textSubWidget(
                                                      _productProvider
                                                          .categories[index]
                                                          .subCategories[i]),
                                                )));
                                  },
                                  leading: SizedBox(
                                    height: 40,
                                    width: 55,
                                    child: CachedNetworkImage(
                                      imageUrl: _productProvider
                                              .categories[index]
                                              .subCategories[i]
                                              .imgUrl
                                              .toString() ??
                                          ' ',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  title: Text(
                                    textSubWidget(_productProvider
                                        .categories[index].subCategories[i]),
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  trailing: Icon(Icons.chevron_right,
                                      color: Colors.black45));
                            })
                      ],
                    );
                  }))
        ]));
  }

  // ignore: unused_element
  /* _buildDetailsAndMaterialWidgets() {
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
  }*/

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
}
