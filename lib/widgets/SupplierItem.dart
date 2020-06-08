import 'package:flutter/material.dart';

class SupplierItem extends StatefulWidget {

  final Map supplier;

  SupplierItem(this.supplier);

  @override
  _SupplierItemState createState() => _SupplierItemState();
}

class _SupplierItemState extends State<SupplierItem> {
  //

  final List<String> imgList = [
    "http://g-ecx.images-amazon.com/images/G/31/img16/PC/june/exchange-banner._V268624739_.jpg",
    "http://g-ecx.images-amazon.com/images/G/31/img16/PC/june/exchange-banner._V268624739_.jpg",
    "https://previews.123rf.com/images/ikopylov/ikopylov1907/ikopylov190700005/128918382-welcome-back-to-school-horizontal-banner-first-day-of-school-pencils-and-supplies-on-yellow-backgrou.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image: NetworkImage(widget.catalogue['banner']
                    image: NetworkImage(
                        widget.supplier['banner'] ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          //widget.supplier['image'],
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
                          /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X"*/
                        ),
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'Super Supplier',
                              //widget.catalogue['supplierName'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '3 washington street, Milan 2451',
                              //widget.catalogue['date'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '+39 125 258 124',
                              //widget.catalogue['date'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
