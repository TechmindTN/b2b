import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Product/SupplierCategoryScreen.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class DataSearchSupplier extends SearchDelegate<Map<String, String>> {
  int selectIndex;
  //final Function selectStoreFn;

  final ApiProvider api = ApiProvider();

//  final storeApi = StoreProvider();

  // DataSearchSupplier(this.selectStoreFn);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  /*@override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title.copyWith(color: Colors.white)));
  }*/

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else
      return FutureBuilder(
        future: api.searchSuppliers(query),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return ProgressIndicatorWidget();
          if (snapshot.hasError) {
            return ServerErrorWidget();
          } else {
            print(snapshot.data);
            if (snapshot.hasData && snapshot.data != null) {
              if (checkServerResponse(snapshot.data, context)) {
                final List<Suppliers> suppliers = snapshot.data["data"]
                    .map<Suppliers>((supp) => Suppliers.fromJson(supp))
                    .toList();
                return ListView.builder(
                    itemCount: suppliers.length,
                    itemBuilder: (context, index) {
                      var text = suppliers[index].firstName +
                          ' ' +
                          suppliers[index].lastName;
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SuppCategory(
                                    supplierid: suppliers[index].id,
                                  )));
                        },
                        leading: SizedBox(
                          height: 45,
                          width: 60,
                          child: CachedNetworkImage(
                            imageUrl: suppliers[index].imgUrl.toString() ?? ' ',
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: RichText(
                          text: TextSpan(
                              text: text.substring(0, query.length),
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
                              children: [
                                TextSpan(text: text.substring(query.length),style: TextStyle(color: Colors.black26))
                              ]),
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: Colors.black45),
                      );
                    });
                    
              } else
                return ServerErrorWidget(
                    errorText: getServerErrorMsg(snapshot.data, context));
            } else
              return Center(
                child: Text('NO DATA'),
              );
          }
        },
      );
  }
}
