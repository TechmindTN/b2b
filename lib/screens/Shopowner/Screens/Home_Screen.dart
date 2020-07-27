import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/widgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siyou_b2b/widgets/SupplierMap.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import 'Search_view.dart';
import 'Supplier/Supplier_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List categories = new List();

  List photos = new List();

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();
  AppLocalizations lang;
  HomeProvider _productProvide;
  final List<String> imgList = List()
    ..add("https://docs.google.com/uc?id=1KoP-HGb-Wys1sgR7p9jYZSTfKbvBdrYw")
    ..add("https://docs.google.com/uc?id=1iJoivqVeiy86GNKFXz-MVCASdnLjo3iv")
    ..add("https://docs.google.com/uc?id=1vv0Ck3wy7tISG_DTIFPNkikk80LA0Elv")
    ..add("https://docs.google.com/uc?id=1rXMxdOkahrGR4KNt1uBH-Mx5QfLeupbQ")
    ..add("https://docs.google.com/uc?id=1WdJQml2kShNw7LiJSTYn_NQMiIhOP-Ww");
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvide = Provider.of<HomeProvider>(context, listen: false);
    _productProvide?.getSuppliers(context);
    _productProvide?.getUserinfo();
  }

  Widget search() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0x11727c8E),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 0),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
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
                color: Color(0xffBEBEBE),
              ))),
          Expanded(
              flex: 7,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Color(0xffBEBEBE)),
                    hintText: lang.tr('SIYOU B2B SEARCH SUPPLIER'),
                    border: InputBorder.none),
                onSubmitted: (_) {
                  if (searchController.text != "") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchView(
                                  search: searchController.text,
                                )));
                  }
                },
              )),
        ],
      ),
    );
  }

  Widget getWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error) {
          provider.resetsupp(context);
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        } else if (provider.loading)
          return ListView(
            children: <Widget>[
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
              LoadingListItemWidget(),
            ],
          );
        else if (provider.suppliers != null && provider.suppliers.isNotEmpty) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            //shrinkWrap: true,
            controller: _scrollController,
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

  Widget placeholder(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[50],
        enabled: true,
        period: const Duration(seconds: 1),
        direction: ShimmerDirection.ttb,
        child: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ));
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
                  child: SupplierScreen(
                      supplier: _productProvide.suppliers[index]),
                  create: (_) => HomeProvider(),
                ),
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            //mainAxisAlignment:MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  child: Container(
                    height: 85.0,
                    width: 100.0,
                    child: _productProvide.suppliers[index].imgUrl == null ||
                            _productProvide.suppliers[index].imgUrl == ""
                        ? Image.asset(
                            "assets/png/empty_cart.png",
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          )
                        : CachedNetworkImage(
                            imageUrl: _productProvide.suppliers[index].imgUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => placeholder(context),
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
                    _productProvide.suppliers[index].firstName +
                        ' ' +
                        _productProvide.suppliers[index].lastName,
                    style: TextStyle(
                      //color: Theme.of(context).primaryColor, //Color(0xFFB7B7B7),
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  if (_productProvide.suppliers[index].description != null)
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Text(
                        _productProvide.suppliers[index].description,
                        style:
                            TextStyle(color: Color(0xFFB7B7B7), fontSize: 10),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  //if (_productProvide.suppliers[index].minorder > 0)
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
                        if (_productProvide.suppliers[index].minorder > 0)
                          TextSpan(
                              text: "Min Order € " +
                                  _productProvide.suppliers[index].minorder
                                      .toString(),
                              style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  if (_productProvide.suppliers[index].minorder > 0)
                    SizedBox(
                      height: 10,
                    ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                                  text: _productProvide
                                          .suppliers[index].distance +
                                      " Km",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 100,
                          child: Text(
                              _productProvide.suppliers[index].country +
                                  ',' +
                                  _productProvide.suppliers[index].region,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Color(0xFF959ca6))),
                        )
                      ],
                    ),
                  ),
                  Divider()
                ],
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.red),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Expanded(child: search()),
              SizedBox(width: 15),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupplierMap(
                                suppliers: _productProvide.suppliers,
                                currentpostion:
                                    _productProvide.currentPosition)));
                  },
                  child: Icon(
                    Linecons.location,
                    color: Colors.black,
                    size: 25,
                  )),
            ],
          )),
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "",
            iconColor: Colors.white,
            bubbleColor: Theme.of(context).primaryColorDark,
            icon: Icons.email,
            titleStyle: TextStyle(color: Colors.white),
            onPress: () async {
              await UrlLauncher.launch("mailto:support@siyoutech.tn");
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title: "",
            iconColor: Colors.white,
            bubbleColor: Colors.red,
            icon: Typicons.chat_alt,
            titleStyle: TextStyle(color: Colors.white),
            onPress: () {
              //_shareText();
              //_animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title: "",
            iconColor: Colors.white,
            bubbleColor: Colors.green,
            icon: FontAwesomeIcons.whatsapp,
            titleStyle: TextStyle(color: Colors.white),
            onPress: () async {
              await FlutterLaunch.launchWathsApp(
                  phone: "+393891081886",
                  message: "Can Someone Help me Please !");
              _animationController.reverse();
            },
          ),

          Bubble(
            title: "",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: FontAwesomeIcons.facebookMessenger,
            titleStyle: TextStyle(color: Colors.white),
            onPress: () async {
              await UrlLauncher.launch("http://m.me/siyou.technologyTN");
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();
        },

        // Floating Action button Icon color
        iconColor: Colors.white,
        backGroundColor: Theme.of(context).primaryColorDark,

        // Flaoting Action button Icon
        iconData: Typicons.chat,
      ),
      //backgroundColor: Theme.of(context).primaryColorDark,
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CarouselSlider(
                  items: imgList
                      .map((item) => Card(
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 1.0,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              imageUrl: item,
                              placeholder: (context, url) =>
                                  placeholder(context),
                            ),
                          )))
                      .toList(),
                  options: CarouselOptions(
                    height: 140,

                    // aspectRatio: 16 / 10,
                    viewportFraction: 0.99,
                    //initialPage: 0,
                    enableInfiniteScroll: true,
                    //reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    //autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    //onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(child: getWidget())
          ],
        ),
      ),
    );
  }
}
