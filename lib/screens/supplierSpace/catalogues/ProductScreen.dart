import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/Filter_Widget.dart';

import 'ProductListS.dart';

class ProductsListSScreen extends StatefulWidget {
  final ProductListProvider productProvider;

  const ProductsListSScreen({Key key, this.productProvider}) : super(key: key);

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListSScreen> {
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
    var width = 300;
    //var _theme = Theme.of(context);
    var iconSize = 24.0;
    //var thirdWidth = (width - iconSize * 3) / 3;
    return SafeArea(
      // length: 2,
      child: Scaffold(
        key: scaffoldKey,
        drawer: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            child: FilterDialogsideWidget(productProvider: _productProvider)),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    lang.tr('My Products'),
                    style: Theme.of(context).textTheme.display1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                  ),

                  /* SizedBox(
                    width: 65,
                  ),*/
                  InkWell(
                    onTap: (() => {
                          //_renderFilterDialog()
                          _productProvider.resetSList(
                            context,
                          )
                        }),
                    child: Icon(Icons.refresh, size: iconSize),
                    /* Row(children: <Widget>[
                        
                        /*Container(
                          padding: EdgeInsets.only(left: iconSize / 3),
                          width: thirdWidth,
                          child: Text('Filters', style: _theme.textTheme.body1),
                        )*/
                      ])*/
                  ),
                ],
              ),
              /*Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10,left: 20,right: 20),
                  width: 400,
                  child: header(context)),*/
              Expanded(flex: 1, child: ProductListS()),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    var width = 300;
    var _theme = Theme.of(context);
    var iconSize = 24.0;
    var thirdWidth = (width - iconSize * 3) / 3;
    return Container(
        color: _theme.primaryColorLight.withAlpha(5),
        child: Row(
          children: <Widget>[
            InkWell(
                onTap: (() => {_renderFilterDialog()}),
                child: Row(children: <Widget>[
                  Icon(Icons.filter_list, size: iconSize),
                  Container(
                    padding: EdgeInsets.only(left: iconSize / 3),
                    width: thirdWidth,
                    child: Text('Filters', style: _theme.textTheme.body1),
                  )
                ])),
            InkWell(
                onTap: (() => {/*onSortClicked(sortBy)*/}),
                child: Row(children: <Widget>[
                  Icon(Icons.import_export, size: iconSize),
                  Container(
                    padding: EdgeInsets.only(left: iconSize / 3),
                    width: thirdWidth * 2,
                    child: Text(/*getSortTitle(sortBy)*/ "",
                        style: _theme.textTheme.body1),
                  )
                ])),
            InkWell(
                onTap: (() => {/*onChangeViewClicked()*/}),
                child: Icon(Icons.view_list, size: iconSize)),
          ],
        ));
  }

  void _renderFilterDialog() {
    final Widget child = FilterDialogWidget(productProvider: _productProvider);

    showPlatformDialog(
      context,
      child,
    );
  }
}
