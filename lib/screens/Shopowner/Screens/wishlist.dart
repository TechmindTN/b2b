import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/product/Productdetails.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/appprop.dart';


class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  AppLocalizations lang;
  ProductListProvider _productProvider;
  // final ScrollController _scrollController = new ScrollController();
  final ApiProvider _api = ApiProvider();

  @override
  void initState() {
    super.initState();
    /*  _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_productProvider.page != -1) _productProvider.getWishList(context);
      }
    });*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<ProductListProvider>(context, listen: false);
    _productProvider?.getWishList(context);
    //print(lang.locale.languageCode);
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    _productProvider.wishlist.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Icon(
                RpgAwesome.glass_heart,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                lang.tr('shopOwner.Wishlist'),
                style: TextStyle(color: darkGrey),
              ),
            ],
          )
          // elevation: 0,
          ),
      body: SafeArea(
        bottom: true,
        child: LayoutBuilder(builder: (builder, constraints) => getWidget()),
      ),
    );
  }

  Widget getWidget() {
    return Consumer<ProductListProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return OpssWidget(
            onPress: _productProvider.resetWishList(context),
          );
        else if (provider.loading)
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                  "assets/jpg/WishList.gif",
                  height: 250,
                  width: double.infinity,
                ),
              ),
            ),
          );
        else if (provider.wishlist != null && provider.wishlist.isNotEmpty) {
          return StaggeredGridView.countBuilder(
            shrinkWrap: true,
            //controller: _scrollController,
            itemCount: provider.wishlist.length,
            itemBuilder: (context, index) => _getItemWidget(index),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 4,
          );
        } else
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12),
              Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    child: SvgPicture.asset(
                      "assets/jpg/empty_wishlist.svg",
                      height: 250,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    child: Text(lang.tr('shopOwner.emptywish'),
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).primaryColorDark)),
                  ),
                ),
              ),
              Container(
                  color: Colors.white,
                  child: Center(
                      child: Container(
                          child: Text(
                    lang.tr('shopOwner.wishexplor'),
                  )))),
              Expanded(child: Container(color: Colors.white)),
            ],
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
        elevation: 0.0,
        //margin: EdgeInsets.all(value),

        child: Container(
          padding: new EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      width: 130,
                      child: Text(
                        _productProvider.wishlist[index].productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      )),
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
                              _productProvider.wishlist
                                  .remove(_productProvider.wishlist[index]);
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: _productProvider.wishlist[index].wishlist
                                  ? Theme.of(context).primaryColorDark
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
                              // placeholder: (context, url) =>
                              //CircularProgressIndicator(),
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
