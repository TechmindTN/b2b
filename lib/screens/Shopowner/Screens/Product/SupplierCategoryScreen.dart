import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/ProdcutListAll.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class SuppCategory extends StatefulWidget {
  final int supplierid;

  const SuppCategory({Key key, this.supplierid}) : super(key: key);
  @override
  _SuppCategoryState createState() => _SuppCategoryState();
}

class _SuppCategoryState extends State<SuppCategory> {
  AppLocalizations lang;
  HomeProvider _productProvider;
  int categoryid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<HomeProvider>(context, listen: false);
    _productProvider?.getCategories(context, widget.supplierid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            lang.tr('shopOwner.Category'),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        backgroundColor: Colors.white,
        body: getWidget());
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
            child: Text("No data found"),
          );
      },
    );
  }

  Widget _getItemWidget(int index) {
    final edgeInsets = const EdgeInsets.all(8.0);
    return Container(
        height: MediaQuery.of(context).size.height * 0.90,
        child: ListView(children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ALLCategoriesScreen(
                        suppid: widget.supplierid,
                      )));
            },
            /*leading: SizedBox(
              height: 45,
              width: 60,
              child: CachedNetworkImage(
                imageUrl:
                    _productProvider.categories[index].imgUrl.toString() ?? ' ',
                fit: BoxFit.contain,
              ),
            ),*/
            title: Text(lang.tr('shopOwner.Showall'),
                style:
                    Theme.of(context).textTheme.subhead.copyWith(fontSize: 14)),
            trailing: Icon(Icons.chevron_right, color: Colors.black45),
          ),
          Container(
            padding: edgeInsets,

            /*Text(lang.tr('shopOwner.Showall'),
                style: Theme.of(context).textTheme.display1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 20)),*/
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _productProvider.categories.length,
              itemBuilder: (_, index) {
                return (ExpansionTile(
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
                  title: Text(textWidget(_productProvider.categories[index]),
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
                                    : categoryid = categoryid = _productProvider
                                        .categories[index].subCategories[i].id;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ALLCategoriesScreen(
                                        suppid: widget.supplierid,
                                        categorieid: categoryid,
                                      )));
                            },
                            leading: SizedBox(
                              height: 40,
                              width: 55,
                              child: CachedNetworkImage(
                                imageUrl: _productProvider.categories[index]
                                        .subCategories[i].imgUrl
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
                            trailing: categoryid ==
                                    _productProvider
                                        .categories[index].subCategories[i].id
                                ? Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).primaryColorDark,
                                    size: 23,
                                  )
                                : Icon(Icons.chevron_right,
                                    color: Colors.black45),
                          );
                        })
                  ],
                ));
              })
        ]));
  }

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
