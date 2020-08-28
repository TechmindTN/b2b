import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/SupplierCategoryScreen.dart';
import 'package:siyou_b2b/widgets/DataSearchSupplier.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';


class SupplierListScreen extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<SupplierListScreen> {
  AppLocalizations lang;
  HomeProvider supplierProvider;
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    // getSearchWallpaper(widget.search);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    supplierProvider = Provider.of<HomeProvider>(context, listen: false);

    if (supplierProvider.suppliers.isEmpty || supplierProvider.error) {
      supplierProvider.error = false;
      supplierProvider?.getSuppliers(context);
    }
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
          lang.tr('shopOwner.Supplier'),
          style: Theme.of(context).textTheme.title,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearchSupplier());
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: getWidget(),
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
        else if (provider.suppliers != null && provider.suppliers.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: provider.suppliers.length,
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
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SuppCategory(
                  supplierid: supplierProvider.suppliers[index].id,
                )));
      },
      leading: SizedBox(
        height: 45,
        width: 60,
        child: CachedNetworkImage(
          imageUrl: supplierProvider.suppliers[index].imgUrl.toString() ?? ' ',
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
          supplierProvider.suppliers[index].firstName +
              ' ' +
              supplierProvider.suppliers[index].lastName,
          style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.black45),
    );
  }

  /*String textWidget(Categories categories) {
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
  }*/
}
