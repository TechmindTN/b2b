import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class ManagerMyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<ManagerMyProfile> with SingleTickerProviderStateMixin {
  AppLocalizations lang;
  HomeProvider userProvider;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
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
    userProvider = Provider.of<HomeProvider>(context, listen: false);
    userProvider?.getUserinfo();
    //userProvider?.getSuppProfilItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error) {
          //provider.resetsupp(context);
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        } else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.user != null) {
          return profile(context);
        } else
          return Container(
              // child: Text("No data found"),
              );
      },
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.9,
      width: MediaQuery.of(context).size.width / 1.15,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(userProvider.user.lat),
                double.parse(userProvider.user.long)),
            zoom: 5),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId(userProvider.user.userAccount),
            position: LatLng(double.parse(userProvider.user.lat),
                double.parse(userProvider.user.long)),
            infoWindow: InfoWindow(
                title: userProvider.user.userNickname +
                    ' ' +
                    userProvider.user.userAccount),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          )
        },
      ),
    );
  }

  Widget profile(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text("Supper Supplier's Profile"),
      ),*/
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "",
            iconColor: Colors.white,
            bubbleColor: Colors.red,
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
        iconColor: Colors.red,

        // Flaoting Action button Icon
        icon: Typicons.chat,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 360.0,
                child: Stack(
                  children: <Widget>[
                    Card(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 180.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                //image: NetworkImage(widget.catalogue['banner']
                                image: NetworkImage(
                                    "http://g-ecx.images-amazon.com/images/G/31/img16/PC/june/exchange-banner._V268624739_.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            height: 184.0,
                            color: Colors.white30,
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 90.0,
                            width: 90.0,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  userProvider.user.avatar
                                  //widget.supplier['image'],
                                  //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
                                  /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X"*/
                                  ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Text(
                            //"Siyou Supplier",
                            userProvider.user.userNickname +
                                ' ' +
                                userProvider.user.userAccount,

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 250.0, right: 10.0, left: 10.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "About",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.people,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(userProvider.user.userNickname +
                                            ' ' +
                                            userProvider.user.userAccount),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("From: "),
                                        Text("6AM"),
                                        Text(" to: "),
                                        Text("5PM"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(userProvider.user.phonenum1),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(userProvider.user.adress.toString() + ', '),
                                        Text(userProvider.user.region +
                                            ' ' +
                                            userProvider.user.postcode +
                                            ', '),
                                        Text(userProvider.user.country),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                           // _buildGoogleMap(context),
                          ],
                        ),
                      ),
                    ),
                   // getitem(),
                    SizedBox(height: 5),
                   // getitem2()
                    /*  Card(
                      child: ListViewBuilder({
                        'title': 'Recent Orders',
                        'widgetName': 'RecentlyAddedProducts',
                        'height': 180.0,
                        'optionButton': {
                          'title': 'View More',
                          'route': '/supplier/myCatalogues',
                        },
                      }, [
                        {},
                        {},
                        {},
                        {},
                      ]),
                    ),
                    Card(
                      child: ListViewBuilder({
                        'title': 'Recently Added Products',
                        'widgetName': 'RecentlyAddedProducts',
                        'height': 180.0,
                        'optionButton': {
                          'title': 'View More',
                          'route': '/supplier/myCatalogues',
                        },
                      }, [
                        {},
                        {},
                        {},
                        {},
                      ]),
                    ),
                     ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        CatalogueItemWidget({
                          "supplierImage":
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
                          "supplierName": "Super Supplier",
                          "date": "September 15 at 8:09 PM",
                          "banner":
                          "https://previews.123rf.com/images/ikopylov/ikopylov1907/ikopylov190700005/128918382-welcome-back-to-school-horizontal-banner-first-day-of-school-pencils-and-supplies-on-yellow-backgrou.jpg",
                          "fromDate": "22/09/2019",
                          "toDate": "12/10/2019",
                        }),
                        CatalogueItemWidget({
                          "supplierImage":
                          "https://www.veeva.com/wp-content/uploads/2018/04/Veeva-logo-Social-1200.png",
                          "supplierName": "Veeva",
                          "date": "September 15 at 8:09 PM",
                          "banner":
                          "https://mustardway.com/public/images/shopbanner.jpg",
                          "fromDate": "22/09/2019",
                          "toDate": "12/10/2019",
                        }),
                        CatalogueItemWidget({
                          "supplierImage":
                          "https://raw.githubusercontent.com/reduxjs/redux/master/logo/logo.png",
                          "supplierName": "Redux",
                          "date": "September 15 at 8:09 PM",
                          "banner":
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShDEUNsiK9q7JuP99yIQYquWcBiu5tANpMjs5l3kTlMNyPya5a",
                          "fromDate": "22/09/2019",
                          "toDate": "12/10/2019",
                        }),
                      ],
                    ),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getitem() {
    return Card(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Recent added products',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                FlatButton(
                  onPressed: () =>
                      null, //Navigator.pushNamed(context, map['route']),
                  child: Text(
                    'View More',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.blueGrey[400],
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: userProvider.supplierlastadded.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: 300.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /*Icon(
                      Icons.store,
                      color: Colors.blue,
                    ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(userProvider
                                                .supplierlastadded[index]
                                                .product
                                                .productName
                                                .length >
                                            40
                                        ? userProvider.supplierlastadded[index]
                                            .product.productName
                                            .substring(0, 39)
                                        : userProvider.supplierlastadded[index]
                                            .product.productName),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          //image: NetworkImage(widget.catalogue['banner']
                                          image: NetworkImage(
                                            userProvider
                                                .supplierlastadded[index]
                                                .images[0]
                                                .imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Online Price'),
                                              Text('Offline Price'),
                                              Text('Barcode'),
                                              Text('Quantity'),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                userProvider
                                                    .supplierlastadded[index]
                                                    .itemOnlinePrice
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierlastadded[index]
                                                    .itemOfflinePrice
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierlastadded[index]
                                                    .itemBarcode,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierlastadded[index]
                                                    .itemQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }

  Widget getitem2() {
    return Card(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Recent Purchased Products',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                FlatButton(
                  onPressed: () =>
                      null, //Navigator.pushNamed(context, map['route']),
                  child: Text(
                    'View More',
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.blueGrey[400],
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: userProvider.supplierpurchased.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: 310.0,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  /*Icon(
                      Icons.store,
                      color: Colors.blue,
                    ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(userProvider
                                                .supplierpurchased[index]
                                                .product
                                                .productName
                                                .length >
                                            40
                                        ? userProvider.supplierpurchased[index]
                                            .product.productName
                                            .substring(0, 39)
                                        : userProvider.supplierpurchased[index]
                                            .product.productName),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.grey[100],
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          //image: NetworkImage(widget.catalogue['banner']
                                          image: NetworkImage(
                                            userProvider
                                                .supplierpurchased[index]
                                                .images[0]
                                                .imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Online Price'),
                                              Text('Offline Price'),
                                              Text('Barcode'),
                                              Text('Quantity'),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                userProvider
                                                    .supplierpurchased[index]
                                                    .itemOnlinePrice
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierpurchased[index]
                                                    .itemOfflinePrice
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierpurchased[index]
                                                    .itemBarcode,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                userProvider
                                                    .supplierpurchased[index]
                                                    .itemQuantity
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
