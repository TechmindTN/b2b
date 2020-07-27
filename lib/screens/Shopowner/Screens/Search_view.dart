
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/Supplier_Screen.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

import '../../../main.dart';


class SearchView extends StatefulWidget {
  final String search;

  SearchView({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List photos = new List();
  TextEditingController searchController = new TextEditingController();
  AppLocalizations lang;
  HomeProvider _productProvide;

  getSearchWallpaper(String searchQuery) async {

   await _productProvide.searchSuppliers(context,searchController.text.toString());
  }

  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvide = Provider.of<HomeProvider>(context, listen: false);
    _productProvide?.searchSuppliers(context,searchController.text.toString());
  }

  Widget brandName() {
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
  }

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
                          builder: (context) => SearchView(
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
          title: 
              Container(
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
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search Supplier By Name ",
                          border: InputBorder.none),
                    )),
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
              Container(
                height: 500,
                child: getWidget())
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
        if (provider.error){
         // provider.resetsupp(context);
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
          
        }
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.searchsuppliers != null && provider.searchsuppliers.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            //controller: _scrollController,
            itemCount: provider.searchsuppliers.length ,
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
    return InkWell(
        onTap: () {
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => LanguageProvider(
              child: ChangeNotifierProvider(
                child:
                   SupplierScreen(supplier: _productProvide.searchsuppliers[index]),
                create: (_) => HomeProvider(),
              ),
            ),
          ),
        );
        },
        child: Row(
          //mainAxisAlignment:MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Container(
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
                    width: 100.0,
                    child: _productProvide.searchsuppliers[index].imgUrl == null ||
                            _productProvide.searchsuppliers[index].imgUrl == ""
                        ? Image.asset(
                            "assets/png/empty_cart.png",
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          )
                        : CachedNetworkImage(
                            imageUrl: _productProvide.searchsuppliers[index].imgUrl,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text(
                  _productProvide.searchsuppliers[index].firstName +
                      ' ' +
                      _productProvide.searchsuppliers[index].lastName,
                  style: TextStyle(
                    //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'NunitoSans',
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      /* WidgetSpan(
                        child: Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                          text: "  ", style: TextStyle(color: Colors.grey)),
                      WidgetSpan(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),*/
                      if (_productProvide.searchsuppliers[index].minorder > 0)
                        TextSpan(
                            text: "Min Order € " +
                                _productProvide.searchsuppliers[index].minorder
                                    .toString(),
                            style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.timer,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                          text:
                              _productProvide.searchsuppliers[index].distance + " Km",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                      WidgetSpan(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      TextSpan(
                          text: _productProvide.searchsuppliers[index].country +
                              ',' +
                              _productProvide.searchsuppliers[index].region,
                          style: TextStyle(color: Color(0xFF959ca6))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
