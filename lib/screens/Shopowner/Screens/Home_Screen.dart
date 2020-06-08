import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluwx/fluwx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/main.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/widgets/CarouselProductimages.dart';
//import 'package:siyou_b2b/widgets/CarouselProductsWidget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:siyou_b2b/widgets/Search_view.dart';
import 'package:siyou_b2b/widgets/SupplierMap.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';
import 'Supplier/Supplier_Screen.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen>with SingleTickerProviderStateMixin {
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

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _productProvide = Provider.of<HomeProvider>(context, listen: false);
    _productProvide?.getSuppliers(context);
  }

  Widget search() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Color(0x11727c8E),
        borderRadius: BorderRadius.circular(35),
      ),
      margin: EdgeInsets.symmetric(horizontal: 0),
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: <Widget>[
          /* Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            width: 20,
            height: 20,
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/svg/barcode_scanner.svg',
                fit: BoxFit.contain,
                color: Colors.red,
                width: 20,
                height: 20,
              ),
            ),
          )),*/
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
                    labelStyle:TextStyle(color: Color(0xffBEBEBE)),
                    hintText: lang.tr('Supplier'),
                    border: InputBorder.none),
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
          return ProgressIndicatorWidget();
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
                    child: _productProvide.suppliers[index].image == null ||
                            _productProvide.suppliers[index].image == ""
                        ? Image.asset(
                            "assets/png/empty_cart.png",
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          )
                        : CachedNetworkImage(
                            imageUrl: _productProvide.suppliers[index].image,
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
                  _productProvide.suppliers[index].firstName +
                      ' ' +
                      _productProvide.suppliers[index].lastName,
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
                      if (_productProvide.suppliers[index].minorder > 0)
                        TextSpan(
                            text: "Min Order € " +
                                _productProvide.suppliers[index].minorder
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
                              _productProvide.suppliers[index].distance + " Km",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500)),
                      WidgetSpan(
                        child: SizedBox(
                          width: 20,
                        ),
                      ),
                      TextSpan(
                          text: _productProvide.suppliers[index].country +
                              ',' +
                              _productProvide.suppliers[index].region,
                          style: TextStyle(color: Color(0xFF959ca6))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              /*  Container(
                height: 60,
                width: 75,
                child: Image.asset(
                  "assets/png/logo_siyou-02.png",
                  fit: BoxFit.contain,
                ),
              ),*/
              Expanded(child: search()),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupplierMap()));
                },
                child: ImageIcon(
                  AssetImage("assets/png/location.png"),
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          )),
          floatingActionButton:FloatingActionBubble(
        // Menu items
        items: <Bubble>[

          // Floating action menu item
          Bubble(
            title:"",
            iconColor :Colors.white,
            bubbleColor : Colors.red,
            icon:Icons.email,
            titleStyle:TextStyle(color: Colors.white),
            onPress: ()async {
             await UrlLauncher.launch("mailto:support@siyoutech.tn");
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"",
            iconColor :Colors.white,
            bubbleColor : Colors.red,
            icon:Typicons.chat_alt,
            titleStyle:TextStyle( color: Colors.white),
            onPress: () {
              _shareText();
              //_animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title:"",
            iconColor :Colors.white,
            bubbleColor : Colors.green,
            icon:FontAwesomeIcons.whatsapp,
            titleStyle:TextStyle( color: Colors.white),
            onPress: ()async {
              await FlutterLaunch.launchWathsApp(phone: "+393891081886", message: "Can Someone Help me Please !");
              _animationController.reverse();
            },
          ),
          /*Bubble(
            title:"Wechat",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:FontAwesomeIcons.wech,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),*/
          Bubble(
            title:"",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:FontAwesomeIcons.facebookMessenger,
            titleStyle:TextStyle( color: Colors.white),
            onPress: () async{
              await UrlLauncher.launch("http://m.me/siyou.technologyTN");
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress:(){ _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward();
        },
        
        // Floating Action button Icon color
        iconColor: Colors.red,

        // Flaoting Action button Icon 
        icon: Typicons.chat,
      ),
      backgroundColor: Colors.white54,
      body: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselProductsList(
              productsList: imgList,
              type: CarouselTypes.details,
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
   void _shareText() async {
     String _text = "Can Someone Help me ";
    await registerWxApi(
        appId: "wxd930ea5d5a228f5f",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://your.univerallink.com/link/");
    var result = await isWeChatInstalled;
    print("is installed $result");
    shareToWeChat(WeChatShareTextModel(_text, scene: WeChatScene.SESSION))
        .then((data) {
      print("-->$data");
    });
  }
}
