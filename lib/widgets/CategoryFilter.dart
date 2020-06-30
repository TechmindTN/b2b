//import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'appprop.dart';
import 'progressindwidget.dart';
import 'servererrorwidget.dart';

class CategoryView extends StatefulWidget {
  final int id;
  final HomeProvider categoryprovider;

  CategoryView({@required this.id, this.categoryprovider});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List photos = new List();
  TextEditingController searchController = new TextEditingController();
  AppLocalizations lang;
  HomeProvider productProvider;
  int suppid;
  int brandid;
  int categoryid;
  _CategoryViewState();

  /*getSearchWallpaper(String searchQuery) async {

   await productProvider.searchSuppliers(context,searchController.text.toString());
  }*/

  @override
  void initState() {
    //getSearchWallpaper(widget.search);
    searchController.text = widget.id.toString();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    productProvider = Provider.of<HomeProvider>(context, listen: false);
    productProvider?.getCategories(context, widget.id);
  }

  /* Widget search() {
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
              child: TextField(
            controller: searchController,
            decoration:
                InputDecoration(hintText: "search ", border: InputBorder.none),
          )),
          InkWell(
              onTap: () {
                if (searchController.text != "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryView(
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
  }*/

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
    final edgeInsets = const EdgeInsets.all(8.0);
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
          return ListView(children: <Widget>[
            Container(
              padding: edgeInsets,
              child: Text(lang.tr('shopOwner.Category'),
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25)),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: productProvider.categories.length,
                itemBuilder: (_, index) {
                  return (ExpansionTile(
                    title: Text(productProvider.categories[index].categoryName,
                        style: Theme.of(context).textTheme.subhead),
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productProvider
                              .categories[index].subCategories.length,
                          itemBuilder: (_, i) {
                            return (ListTile(
                              onTap: () {
                                /*setState(() {
                                  categoryid ==
                                          productProvider.categories[index]
                                              .subCategories[i].id
                                      ? categoryid = null
                                      : categoryid = categoryid =
                                          productProvider.categories[index]
                                              .subCategories[i].id;
                                });*/
                                print(productProvider.categories[index]
                                              .subCategories[i].id);
                                Navigator.pop(context);
                                productProvider.resetList(
                                  context,
                                  category: productProvider.categories[index]
                                              .subCategories[i].id,
                                );
                              },
                              title: Text(
                                productProvider.categories[index]
                                    .subCategories[i].categoryName,
                                style: TextStyle(fontSize: 15),
                              ),
                              trailing: categoryid ==
                                      productProvider
                                          .categories[index].subCategories[i].id
                                  ? Icon(
                                      Icons.check_circle,
                                      color: yellow,
                                      size: 23,
                                    )
                                  : SizedBox(),
                            ));
                          })
                    ],
                  ));
                })
          ]);
        } else
          return Container(
            child: Text("No data found"),
          );
      },
    );
  }
}
