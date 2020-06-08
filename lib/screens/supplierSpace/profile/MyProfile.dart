import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/CatalogueItemWidget.dart';
import 'package:siyou_b2b/widgets/ListViewBuilder.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supper Supplier's Profile"),
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
                                //widget.supplier['image'],
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
                                /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X"*/
                              ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Text(
                            "Super Supplier",
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
                                    Icons.store,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("Supper Supplier"),
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
                                    color: Colors.blue,
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
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("3 Leonardo Davinci Boulevard,"),
                                        Text("Rome 2405,"),
                                        Text("Italy")
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
                                    color: Colors.blue,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("(+ 39) 125 147 541"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
