import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import 'Product/ProdcutListAll.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  AppLocalizations lang;
  ProductListProvider _productProvider;

  @override
  void initState() {
    // getSearchWallpaper(widget.search);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvider = Provider.of<ProductListProvider>(context, listen: false);
    _productProvider?.getCategories(context);
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
          title: Text(
            lang.tr('shopOwner.Category'),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        backgroundColor: Colors.white,
        body: getWidget());
  }

  Widget getWidget() {
    return Consumer<ProductListProvider>(
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

  Widget _getItemWidget(
    int index,
  ) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SubCategory(
                  categories: _productProvider.categories[index],
                )));
      },
      leading: SizedBox(
        height: 45,
        width: 60,
        child: CachedNetworkImage(
          imageUrl: _productProvider.categories[index].imgUrl.toString() ?? ' ',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(textWidget(_productProvider.categories[index]),
          style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.black45),
    );
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
}

class SubCategory extends StatefulWidget {
  final Categories categories;

  const SubCategory({Key key, this.categories}) : super(key: key);

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  AppLocalizations lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
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
            textWidget(widget.categories),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        backgroundColor: Colors.white,
        body: getWidget());
  }

  Widget getWidget() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      //shrinkWrap: true,
      //controller: _scrollController,
      itemCount: widget.categories.subCategories.length,
      itemBuilder: (context, index) => _getItemWidget(index),
    );
  }

  Widget _getItemWidget(
    int index,
  ) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ALLCategoriesScreen(
                  categorieid: widget.categories.subCategories[index].id,
                )));
        print(widget.categories.subCategories[index].id);
      },
      leading: SizedBox(
        height: 45,
        width: 60,
        child: CachedNetworkImage(
          imageUrl:
              widget.categories.subCategories[index].imgUrl.toString() ?? ' ',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(textSubWidget(widget.categories.subCategories[index]),
          style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.black45),
    );
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

class BrandScreen extends StatefulWidget {
  final Categories categories;

  const BrandScreen({Key key, this.categories}) : super(key: key);

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  AppLocalizations lang;
  ProductListProvider brandProvider;

  @override
  void initState() {
    super.initState();
    brandProvider = Provider.of<ProductListProvider>(context, listen: false);
    brandProvider?.getBrands(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
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
          title: Text(
            lang.tr('shopOwner.Brand'),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        backgroundColor: Colors.white,
        body: getWidget());
  }

  Widget getWidget() {
    return Consumer<ProductListProvider>(
      builder: (context, provider, widget) {
        if (provider.error) {
          // provider.resetsupp(context);
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        } else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.brands != null && provider.brands.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: provider.brands.length,
            itemBuilder: (context, index) => _getItemWidget(index),
          );
        } else
          return Container(
            child: Text(""),
          );
      },
    );
  }

  Widget _getItemWidget(
    int index,
  ) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ALLCategoriesScreen(
                  brandid: brandProvider.brands[index].id,
                )));
      },
      leading: SizedBox(
        height: 45,
        width: 60,
        child: CachedNetworkImage(
          imageUrl: brandProvider.brands[index].brandLogo ?? ' ',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(brandProvider.brands[index].brandName,
          style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.black45),
    );
  }
}
