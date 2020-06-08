import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Productdetails.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/Costum_backgroud.dart';
import 'package:siyou_b2b/widgets/appprop.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  AppLocalizations lang;
  ProductListProvider _productProvider;
  final ScrollController _scrollController = new ScrollController();
  final ApiProvider _api = ApiProvider();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1) _productProvider.getWishList(context);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<ProductListProvider>(context, listen: false);
    _productProvider?.getWishList(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productProvider.wishlist.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
             lang.tr('shopOwner.Wishlist'),
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(builder: (builder, constraints) => getWidget()),
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
        else if (provider.wishlist != null && provider.wishlist.isNotEmpty) {
          return GridView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.wishlist.length,
            itemBuilder: (context, index) => _getItemWidget(index),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height * 0.6),
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => LanguageProvider(
              child: ChangeNotifierProvider(
                child: DetailsScreen(product: _productProvider.wishlist[index]),
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
                    _productProvider.wishlist[index].productName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox.fromSize(
                    size: Size(23, 23),
                    child: ClipOval(
                      child: Material(
                        color: Colors.black12,
                        child: InkWell(
                            splashColor: Colors.white70,
                            onTap: () {
                              removeWishlist(
                                  _productProvider.wishlist[index].id);
                                  _productProvider.wishlist.remove(_productProvider.wishlist[index]);
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: _productProvider.wishlist[index].wishlist
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
                      child: _productProvider.wishlist[index].productImage ==
                                  null ||
                              _productProvider.wishlist[index].productImage ==
                                  ""
                          ? Image.asset(
                              "assets/png/empty_cart.png",
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                            )
                          : CachedNetworkImage(
                              imageUrl:
                                  _productProvider.wishlist[index].productImage,
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
                      /*  Text(
                        _productProvider.wishlist[index].supplier.firstName==null?'Supplier':_productProvider.wishlist[index].supplier.firstName +
                            _productProvider.wishlist[index].supplier.lastName==null?'Supplier':_productProvider.wishlist[index].supplier.lastName,
                        style: TextStyle(
                          color: Color(0xFFB7B7B7),
                          fontSize: 10.0,
                        ),
                      ),*/
                      SizedBox(
                        height: 1.0,
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
                  ),
                  Text(
                    'Pack/box:' + '24/6',
                    style: TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  removeWishlist(int proid) async {
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
