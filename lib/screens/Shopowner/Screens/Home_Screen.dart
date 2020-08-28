import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Categorys.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/SupplierList.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/orders/OrdersScreen.dart';
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
    if (_productProvide.suppliers.isEmpty || _productProvide.error) {
      _productProvide.error = false;
      _productProvide?.getSuppliers(context);
    }
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

  // ignore: non_constant_identifier_names
  Widget _headerpart() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        FlatButton(
          onPressed: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Category())),
          },
          //color: Colors.orange,
          padding: EdgeInsets.only(
            top: 10.0,
            left: 5.0,
            right: 5.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/category.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Text(
                  lang.tr('shopOwner.allcat'),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SupplierListScreen()))
          },
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/shop-2.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4.5,
                child: Text(
                  lang.tr('shopOwner.allsupp'),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => BrandScreen())),
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/brand.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5.2,
                child: Text(
                  lang.tr('shopOwner.allbrand'),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          onPressed: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => OrdersScreen()))
          },
          //color: Colors.orange,
          padding: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/cartorder.svg',
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width / 5,
                height: 25,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5.2,
                child: Text(
                  lang.tr('shopOwner.allorders'),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ],
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
                child:
                    SupplierScreen(supplier: _productProvide.suppliers[index]),
                create: (_) => HomeProvider(),
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.only(
                        left: 5,
                        right: 5,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          child: _productProvide.suppliers[index].imgUrl ==
                                      null ||
                                  _productProvide.suppliers[index].imgUrl == ""
                              ? Image.asset(
                                  "assets/png/empty_cart.png",
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      _productProvide.suppliers[index].imgUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      placeholder(context),
                                ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _productProvide.suppliers[index].firstName +
                              ' ' +
                              _productProvide.suppliers[index].lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          lang.tr('shopOwner.phone') +
                              _productProvide.suppliers[index].phoneNum1
                                  .toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    _productProvide.suppliers[index].description == null ||
                            _productProvide.suppliers[index].description
                                    .toString()
                                    .length <
                                10
                        ? 'We are **company, which have enough experience on market of selling *products and research ** product.'
                        : _productProvide.suppliers[index].description,
                    style: TextStyle(color: Color(0xFFB7B7B7), fontSize: 10),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.timer,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                                text:
                                    _productProvide.suppliers[index].distance +
                                        " Km",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: _productProvide.suppliers[index].region +
                                    ', ' +
                                    _productProvide.suppliers[index].country,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: -10,
              right: 2,
              child: Image.asset(
                "assets/png/New.png",
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
                width: 50,
                height: 90,
              ))
        ],
      ),
    );
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

        animation: _animation,

        onPress: () {
          _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward();
        },
        iconColor: Colors.white,
        backGroundColor: Theme.of(context).primaryColorDark,
        iconData: Typicons.chat,
      ),
      body: Container(
        color: Colors.grey[100],
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
            Container(
              margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 9.5,
              child: Center(
                child: _headerpart(),
              ),
            ),
            Expanded(child: getWidget())
          ],
        ),
      ),
    );
  }
}
