import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/MyCatalogueItem.dart';

class MyCatalogues extends StatefulWidget {
  @override
  _MyCataloguesState createState() => _MyCataloguesState();
}

class _MyCataloguesState extends State<MyCatalogues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Catalogues"),
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            MyCatalogueItem({
              "supplierImage":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
              "supplierName": "Super Supplier",
              "date": "September 15 at 8:09 PM",
              "banner":
                  "https://previews.123rf.com/images/ikopylov/ikopylov1907/ikopylov190700005/128918382-welcome-back-to-school-horizontal-banner-first-day-of-school-pencils-and-supplies-on-yellow-backgrou.jpg",
              "fromDate": "22/09/2019",
              "toDate": "12/10/2019",
              "route": "/supplier/myProfile",
            }),
            MyCatalogueItem({
              "supplierImage":
                  "https://www.veeva.com/wp-content/uploads/2018/04/Veeva-logo-Social-1200.png",
              "supplierName": "Veeva",
              "date": "September 15 at 8:09 PM",
              "banner": "https://mustardway.com/public/images/shopbanner.jpg",
              "fromDate": "22/09/2019",
              "toDate": "12/10/2019",
              "route": "/supplier/myProfile",
            }),
            MyCatalogueItem({
              "supplierImage":
                  "https://raw.githubusercontent.com/reduxjs/redux/master/logo/logo.png",
              "supplierName": "Redux",
              "date": "September 15 at 8:09 PM",
              "banner":
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShDEUNsiK9q7JuP99yIQYquWcBiu5tANpMjs5l3kTlMNyPya5a",
              "fromDate": "22/09/2019",
              "toDate": "12/10/2019",
              "route": "/supplier/myProfile",
            }),
          ],
        ),
      ),
    );
  }
}
