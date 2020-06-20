import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'appprop.dart';

class SupplierMap extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<SupplierMap> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  AppLocalizations lang;
  double zoomVal=5.0;
    
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
      body:
       Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

 Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchMinus,color:Theme.of(context).primaryColor),
            onPressed: () {
              zoomVal--;
             _minus( zoomVal);
            }),
    );
 }
 Widget _zoomplusfunction() {
   
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
            icon: Icon(FontAwesomeIcons.searchPlus,color:Theme.of(context).primaryColor),
            onPressed: () {
              zoomVal++;
              _plus(zoomVal);
            }),
    );
 }

 Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng( 36.847083, 10.198268), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng( 36.847083, 10.198268), zoom: zoomVal)));
  }

  
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
                   36.847083, 10.198268,"Siyou Tunisia"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.0-9/70105111_113937656655653_244158406762430464_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=W9VnDG86v6IAX_xZ-V1&_nc_ht=scontent.ftun7-1.fna&oh=cf106de97a6fad71e1385823ba4d1e91&oe=5EC7585A",
                  45.4972693, 9.2008898,"Siyou Milano"),
            ),
            SizedBox(width: 10.0),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://scontent.ftun7-1.fna.fbcdn.net/v/t1.0-9/70105111_113937656655653_244158406762430464_o.jpg?_nc_cat=105&_nc_sid=09cbfe&_nc_ohc=W9VnDG86v6IAX_xZ-V1&_nc_ht=scontent.ftun7-1.fna&oh=cf106de97a6fad71e1385823ba4d1e91&oe=5EC7585A",
                  48.833669,  2.238631,"Siyou Paris"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
        onTap: () {
          _gotoLocation(lat,long);
        },
        child:Container(
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
                          ),),
                          Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myDetailsContainer1(restaurantName),
                          ),
                        ),

                      ],)
                ),
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
              child: Text(restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height:5.0),
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
          SizedBox(height:5.0),
        Container(
                  child: Text(
                " \u00B7 \u0024\u0024 \u00B7 1.6 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              )),
              SizedBox(height:5.0),
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
        initialCameraPosition:  CameraPosition(target: LatLng(36.847083, 10.198268), zoom: 0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          tunis1Marker,milano2Marker, paris3Marker,sousse3Marker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}



//New York Marker

Marker tunis1Marker = Marker(
  markerId: MarkerId('SiyouTunisia'),
  position: LatLng(36.847083, 10.198268),
  infoWindow: InfoWindow(title: 'Siyou Tunisia'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);
Marker milano2Marker = Marker(
  markerId: MarkerId('Siyoumilano'),
  position: LatLng(45.497269,9.2008898),
  infoWindow: InfoWindow(title: 'Siyou Milano'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker paris3Marker = Marker(
  markerId: MarkerId('Siyou Paris'),
  position: LatLng(48.833669, 2.238631),
  infoWindow: InfoWindow(title: 'Siyou Paris'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
  
);
Marker sousse3Marker = Marker(
  markerId: MarkerId('Siyou Sousse'),
  position: LatLng(35.830075, 10.640050),
  infoWindow: InfoWindow(title: 'Siyou Sousse'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),);