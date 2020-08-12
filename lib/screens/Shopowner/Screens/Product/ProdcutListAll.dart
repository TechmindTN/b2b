import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/product/productlist.dart';

class ALLCategoriesScreen extends StatefulWidget {
  final ProductListProvider productProvider;
  final int categorieid;
  final int brandid;
  final int suppid;
  final String appbarName;

  const ALLCategoriesScreen(
      {Key key,
      this.productProvider,
      this.categorieid,
      this.brandid,
      this.suppid,
      this.appbarName})
      : super(key: key);

  @override
  _ALLCategoriesScreenState createState() => _ALLCategoriesScreenState();
}

class _ALLCategoriesScreenState extends State<ALLCategoriesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ProductListProvider _productProvider;
  AppLocalizations lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductListProvider>(context, listen: true);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    var iconSize = 24.0;
    //var thirdWidth = (width - iconSize * 3) / 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            widget.appbarName == null
                ? Text(
                    lang.tr('shopOwner.Discovery'),
                    style: TextStyle(color: Colors.black),
                  )
                : Text(
                    widget.appbarName,
                    style: TextStyle(color: Colors.black),
                  ),
            Spacer(),
            InkWell(
              onTap: (() => {
                    _productProvider.resetList(context,
                        supplierid: widget.suppid,
                        category: widget.categorieid,
                        brand: widget.brandid)
                  }),
              child: Icon(Icons.refresh, size: iconSize),
            ),
          ],
        ),
      ),
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: ProductList(
                  suppid: widget.suppid,
                  categ: widget.categorieid,
                  brand: widget.brandid,
                )),
          ],
        ),
      ),
    );
  }
}
