import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/Itemdetails.dart';

import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import '../../../main.dart';


class SearchItem extends StatefulWidget {
  final String search;

  SearchItem({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchItem> {
  List photos = new List();
  TextEditingController searchController = new TextEditingController();
  AppLocalizations lang;
  HomeProvider _productProvide;
  CartProvider cartProvider;

  getSearchWallpaper(String searchQuery) async {
    await _productProvide.searchItems(context, searchQuery);
  }

  onTextFieldKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        print('yassineee');
      } else if (event.data is RawKeyEventDataWeb) {
        final data = event.data as RawKeyEventDataWeb;
        if (data.keyLabel == 'Enter') print('yassineee');
      } else if (event.data is RawKeyEventDataAndroid) {
        final data = event.data as RawKeyEventDataAndroid;
        if (data.keyCode == 13) print('yassineee');
      }
    }
  }

  @override
  void initState() {
    // getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvide = Provider.of<HomeProvider>(context, listen: false);
    _productProvide?.searchItems(context, searchController.text.toString());
    cartProvider = Provider.of<CartProvider>(context);
  }

  /*Widget brandName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Siyou",
          style: TextStyle(color: Colors.red, fontFamily: 'Overpass'),
        ),
        Text(
          "B2S",
          style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
        )
      ],
    );
  }*/

  Widget search() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
              child: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (event) {
                    if (event is RawKeyUpEvent &&
                        event.data is RawKeyEventDataAndroid) {
                      var data = event.data as RawKeyEventDataAndroid;
                      if (data.keyCode == 13) {
                        debugPrint('onSubmitted');
                      }
                    }
                  },
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "search ", border: InputBorder.none),
                    textInputAction: TextInputAction.done,

                    // onSubmitted: (value)=>print('yassssssssine'),
                  ))),
          InkWell(
              onTap: () {
                if (searchController.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchItem(
                                search: searchController.text,
                              )));
                }
              },
              child: Container(
                  child: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              )))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Container(
          height: 60,
          width: 75,
          child: Image.asset(
            "assets/png/logo_siyou-02.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RawKeyboardListener(
                            onKey: onTextFieldKey,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "Search By Barcode/Name",
                                  border: InputBorder.none),
                            ),
                            focusNode: FocusNode())),
                    InkWell(
                        onTap: () {
                          getSearchWallpaper(searchController.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(height: 500, child: getWidget())
              //wallPaper(photos, context),
              /*Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    children: photos.map((PhotosModel photoModel) {
                      return GridTile(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ImageView(
                                    imgPath: photoModel.src.portrait,
                                  )
                              ));
                            },
                            child: Hero(
                              tag: photoModel.src.portrait,
                              child: Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: kIsWeb ? Image.network(
                                      photoModel.src.portrait,
                                      height: 50,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ) : CachedNetworkImage(
                                        imageUrl: photoModel.src.portrait,
                                        placeholder: (context, url) => Container(color: Color(0xfff5f8fd),),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ));
                    }).toList()),
              ),*/
            ],
          ),
        ),
      ),
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
          return ProgressIndicatorWidget();
        else if (provider.searchitem != null &&
            provider.searchitem.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            //controller: _scrollController,
            itemCount: provider.searchitem.length,
            itemBuilder: (context, index) => _getItemWidget(index),
          );
        } else
          return Container(
            child: Text("No data found"),
          );
      },
    );
  }

  Widget _getItemWidget(
    int index,
  ) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
              //mainAxisAlignment:MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => LanguageProvider(
                            child: ChangeNotifierProvider(
                              child: ItemDetailsScreen(
                                product: _productProvide.searchitem[index],
                                supplierid: _productProvide
                                    .searchitem[index].supplier.id,
                              ),
                              create: (_) => ProductListProvider(),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                            child: _productProvide.searchitem[index].images ==
                                        null ||
                                    _productProvide
                                        .searchitem[index].images.isEmpty
                                ? Image.asset(
                                    "assets/png/empty_cart.png",
                                    fit: BoxFit.contain,
                                    alignment: Alignment.center,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: _productProvide
                                        .searchitem[index].images[0].imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: 165,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => LanguageProvider(
                                        child: ChangeNotifierProvider(
                                          child: ItemDetailsScreen(
                                            product: _productProvide
                                                .searchitem[index],
                                            supplierid: _productProvide
                                                .searchitem[index].supplier.id,
                                          ),
                                          create: (_) => ProductListProvider(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  _productProvide
                                      .searchitem[index].product.productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                                    fontWeight: FontWeight.bold,
                                    // fontFamily: 'NunitoSans',
                                    fontSize: 16.0,
                                  ),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _productProvide.searchitem[index].id
                                          .toString() +
                                      '/' +
                                      _productProvide
                                          .searchitem[index].itemBarcode
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
                                      _productProvide.searchitem[index].itemBox
                                          .toString() +
                                      ' Package: ' +
                                      _productProvide
                                          .searchitem[index].itemPackage
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
                          text: _productProvide.suppliers[index].country +
                              ',' +
                              _productProvide.suppliers[index].region,
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
                    _productProvide.searchitem[index].itemOfflinePrice
                        .toString(),
                style: TextStyle(
                  color: Colors.black, //Color(0xFFB7B7B7),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough,
                  // fontFamily: 'NunitoSans',
                  fontSize: 16.0,
                ),
              ),
              right: 15,
              top: 20,
            ),
            Positioned(
              child: Text(
                '€ ' +
                    _productProvide.searchitem[index].itemDiscountPrice
                        .toString(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                  fontWeight: FontWeight.w500,

                  // fontFamily: 'NunitoSans',
                  fontSize: 16.0,
                ),
              ),
              right: 15,
              top: 0,
            ),
            Positioned(
              child: Container(
                height: 70,
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
                          if (_productProvide.searchitem[index].quantity > 0)
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
                                  size: 18,
                                ),
                              ),
                              onTap: () {
                                _productProvide.searchitem[index].quantity -
                                            _productProvide.searchitem[index]
                                                .itemPackage >=
                                        0
                                    ? _productProvide
                                            .searchitem[index].quantity -=
                                        _productProvide
                                            .searchitem[index].itemPackage
                                    : _productProvide
                                        .searchitem[index].quantity = 0;
                                _productProvide.notify();
                              },
                            ),
                          SizedBox(width: 15),
                          Text(
                            _productProvide.searchitem[index].quantity
                                .toString(),
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
                                size: 18,
                              ),
                            ),
                            onTap: () {
                              //_productProvide.searchitem[index].quantity +=
                              //  _productProvide.searchitem[index].itemPackage;

                              cartProvider.addCartItems(
                                  _productProvide.searchitem[index],
                                  _productProvide.searchitem[index].itemPackage,
                                  _productProvide.searchitem[index].supplier.id,
                                  _productProvide.searchitem[index].supplier);
                              _productProvide.notify();
                            },
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              right: 0.5,
              top: 50,
            )
          ],
        ),
        Divider(
          thickness: 2,
          color: Colors.black12,
          height: 5,
        ),
        if (index == _productProvide.searchitem.length - 1)
          SizedBox(
            height: 60,
          )
      ],
    );
  }
}
