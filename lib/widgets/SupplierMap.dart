import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/screens/Shopowner/Screens/Supplier/Supplier_Screen.dart';

import '../main.dart';
import 'appprop.dart';

class SupplierMap extends StatefulWidget {
  final List<Suppliers> suppliers;
  final Position currentpostion;

  const SupplierMap({Key key, this.suppliers, this.currentpostion})
      : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<SupplierMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  AppLocalizations lang;
  double zoomVal = 5.0;
  List<Marker> markerlist = [];

  @override
  void initState() {
    super.initState();
    intil();
  }

  void intil() {
    widget.suppliers.forEach((value) {
      Marker marker = Marker(
          markerId: MarkerId(value.id.toString()),
          position: LatLng(
              double.parse(value.latitude), double.parse(value.longitude)),
          infoWindow: InfoWindow(
              title: value.firstName.toUpperCase() +
                  ' ' +
                  value.lastName.toUpperCase()),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Wrap(children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  //width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

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
                                            child: value.imgUrl == null ||
                                                    value.imgUrl == ""
                                                ? Image.asset(
                                                    "assets/png/empty_cart.png",
                                                    fit: BoxFit.contain,
                                                    alignment: Alignment.center,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl: value.imgUrl,
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                text: value.firstName +
                                                    ' ' +
                                                    value.lastName,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                if (value.minorder > 0)
                                                  TextSpan(
                                                      text: "Min Order € " +
                                                          value.minorder
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                200,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                          text: value.distance +
                                                              " Km",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                RichText(
                                                  text: TextSpan(
                                                      text: value.country +
                                                          ',' +
                                                          value.region,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        /* Positioned(
                          top: 4.0,
                          right: 4.0,
                          child: GestureDetector(
                            child: Container(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  shape: BoxShape.circle),
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),*/
                        Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: GestureDetector(
                            child: Container(
                              child: Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 45,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black87,
                                  shape: BoxShape.circle),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => LanguageProvider(
                                  child: ChangeNotifierProvider(
                                    child: SupplierScreen(supplier: value),
                                    create: (_) => HomeProvider(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
                  );
                });
          });
      markerlist.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          lang.tr('shopOwner.Supplier'),
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          // _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus,
              color: Theme.of(context).primaryColor),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus,
              color: Theme.of(context).primaryColor),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(36.847083, 10.198268), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(36.847083, 10.198268), zoom: zoomVal)));
  }

  // ignore: unused_element
  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.0-9/70105111_113937656655653_244158406762430464_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=W9VnDG86v6IAX_xZ-V1&_nc_ht=scontent.ftun7-1.fna&oh=cf106de97a6fad71e1385823ba4d1e91&oe=5EC7585A",
                  36.847083,
                  10.198268,
                  "Siyou Tunisia"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.0-9/70105111_113937656655653_244158406762430464_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=W9VnDG86v6IAX_xZ-V1&_nc_ht=scontent.ftun7-1.fna&oh=cf106de97a6fad71e1385823ba4d1e91&oe=5EC7585A",
                  45.4972693,
                  9.2008898,
                  "Siyou Milano"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.0-9/70105111_113937656655653_244158406762430464_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=W9VnDG86v6IAX_xZ-V1&_nc_ht=scontent.ftun7-1.fna&oh=cf106de97a6fad71e1385823ba4d1e91&oe=5EC7585A",
                  48.833669,
                  2.238631,
                  "Siyou Paris"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          " \u00B7 \u0024\u0024 \u00B7 1.6 mi",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
          "Closed \u00B7 Opens 17:00 Thu",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.currentpostion.latitude,
                widget.currentpostion.longitude),
            zoom: 0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markerlist),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
