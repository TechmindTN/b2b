import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/product/Productdetails.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';

class ProductList extends StatefulWidget {
  final int suppid;
  final int categ;
  final int brand;

  const ProductList({Key key, this.suppid, this.categ, this.brand})
      : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  AppLocalizations lang;
  ProductListProvider _productProvider;
  final ApiProvider _api = ApiProvider();
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    _productProvider = Provider.of<ProductListProvider>(context, listen: false);
    intil();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1)
          _productProvider.getProducts(context,
              supplierid: widget.suppid,
              category: widget.categ,
              brand: widget.brand);
      }
    });
  }

  intil() async {
    await _productProvider.getLists(context);
    //await _productProvider.resetList(context);
    await _productProvider.resetList(context,
        supplierid: widget.suppid, category: widget.categ, brand: widget.brand);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    // _productProvider = Provider.of<ProductListProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productProvider.products.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _productProvider.resetList(context,
            supplierid: widget.suppid,
            category: widget.categ,
            brand: widget.brand),
        child: getWidget(),
      ),
    );
  }

  Widget getWidget() {
    return Consumer<ProductListProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return OpssWidget(
              // onPress: _productProvider.resetList(context),
              );
        else if (provider.loading)
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
        else if (provider.products != null && provider.products.isNotEmpty) {
          return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.products.length,
            itemBuilder: (context, index) => _getItemWidget(index),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 4,
          );
        } else
          return RefreshIndicator(
              onRefresh: () => _productProvider.resetList(context),
              child: Container(
                  child: Center(
                child: Text("No data found"),
              )));
      },
    );
  }

  Widget _getItemWidget(int index) {
    if (index == _productProvider.products.length - 1 &&
        _productProvider.page != -1) return ProgressIndicatorWidget();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => LanguageProvider(
              child: ChangeNotifierProvider(
                child: DetailsScreen(product: _productProvider.products[index]),
                create: (_) => ProductListProvider(),
              ),
            ),
          ),
        );
      },
      child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
              //side: new BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Container(
                padding: new EdgeInsets.only(left: 5, right: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height/4,
                          //width: MediaQuery.of(context).size.width / 2.3,
                          child:
                              _productProvider.products[index].productImage ==
                                          null ||
                                      _productProvider
                                              .products[index].productImage ==
                                          ""
                                  ? Image.asset(
                                      "assets/png/empty_cart.png",
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: _productProvider
                                          .products[index].productImage,
                                      fit: BoxFit.contain,
                                    ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Text(
                          _productProvider.products[index].productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300),
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _productProvider
                                      .products[index].supplier.firstName +
                                  ' ' +
                                  _productProvider
                                      .products[index].supplier.lastName,
                              style: TextStyle(
                                color: Color(0xFFB7B7B7),
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            Text(
                              _productProvider
                                          .products[index].category.categoryName
                                          .toString()
                                          .length >
                                      18
                                  ? _productProvider
                                      .products[index].category.categoryName
                                      .substring(0, 18)
                                  : _productProvider
                                      .products[index].category.categoryName
                                      .toString(),
                              style: TextStyle(
                                color: Color(0xFFB7B7B7),
                                fontSize: 10.0,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _productProvider
                                    .products[index].brand.brandName,
                                style: TextStyle(
                                  color: Color(0xFFB7B7B7),
                                  fontSize: 10.0,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ]),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 2,
                  top: 2,
                  child: SizedBox.fromSize(
                    size: Size(20, 20),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black12,
                        child: InkWell(
                            splashColor: Colors.white70,
                            onTap: () {
                              addremoveWishlist(
                                  _productProvider.products[index].id);
                              setState(() {
                                _productProvider.products[index].wishlist =
                                    !_productProvider.products[index].wishlist;
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: _productProvider.products[index].wishlist
                                  ? Colors.red
                                  : Colors.white,
                            )),
                      ),
                    ),
                  ))
            ],
          )),
    );
  }

  addremoveWishlist(int proid) async {
    loadingDialog(context, lang);
    try {
      final data = await _api.addWishList(proid);

      if (checkwishlist(
        data,
      )) {
        try {
          Navigator.pop(context);
          return true;
        } catch (e) {
          Navigator.pop(context);
          showAlertDialog(context, " Error", e);
          print(e);
          return false;
        }
      } else {
        Navigator.pop(context);
        showAlertDialog(context, "", 'error');
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showAlertDialog(context, "Error", e.toString());
    }
  }
}
