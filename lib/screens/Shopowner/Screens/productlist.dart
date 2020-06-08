import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';

import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Productdetails.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class ProductList extends StatefulWidget {
  final int suppid;

  const ProductList({Key key, this.suppid}) : super(key: key);
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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1)
          _productProvider.getProducts(context, supplierid: widget.suppid);
      }
    });
  }

  intil() async {
    await _productProvider.getLists(context);
    //await _productProvider.resetList(context);
    print('intial');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<ProductListProvider>(context, listen: false);
    _productProvider?.getProducts(context, supplierid: widget.suppid);
    intil();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _productProvider.products.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _productProvider.resetList(context),
      child: getWidget(),
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
        else if (provider.products != null && provider.products.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.products.length,
            itemBuilder: (context, index) => _getItemWidget(index),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height * 0.70),
            ),
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
                    _productProvider.products[index].productName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox.fromSize(
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
                      child: _productProvider.products[index].productImage ==
                                  null ||
                              _productProvider.products[index].productImage ==
                                  ""
                          ? Image.asset(
                              "assets/png/empty_cart.png",
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  _productProvider.products[index].productImage,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              fit: BoxFit.contain,
                            ),
                    ),
                  ),
                ),
              ),
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
                        _productProvider.products[index].supplier.firstName +
                            ' ' +
                            _productProvider.products[index].supplier.lastName,
                        style: TextStyle(
                          color: Color(0xFFB7B7B7),
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        _productProvider.products[index].category.categoryName
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
                          _productProvider.products[index].brand.brandName,
                          style: TextStyle(
                            color: Color(0xFFB7B7B7),
                            fontSize: 10.0,
                          ),
                        ),
                        SizedBox(
                          height: 1.0,
                        ),
                        Text(
                          'P/B:' +
                              _productProvider.products[index].productPackage
                                  .toString() +
                              '/' +
                              _productProvider.products[index].productBox
                                  .toString(),
                          style: TextStyle(
                            color: Color(0xFFB7B7B7),
                            fontSize: 10.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
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
