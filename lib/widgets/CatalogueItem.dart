import 'package:flutter/material.dart';

class CatalogueItem extends StatefulWidget {

  final Map catalogue;

  CatalogueItem(this.catalogue);

  @override
  _CatalogueItemState createState() => _CatalogueItemState();
}

class _CatalogueItemState extends State<CatalogueItem> {

  bool _bookmarked = false;
  bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0,
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, "/supplierProfile"),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.catalogue['supplierImage'],
                              /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X"*/
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              //'Super Supplier'
                              widget.catalogue['supplierName'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              //'September 15 at 8:09 PM',
                              widget.catalogue['date'],
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _bookmarked = !_bookmarked;
                        });
                      },
                      child: Icon(
                        _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: _bookmarked ? Colors.amber : null,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _addedToCart = !_addedToCart;
                        });
                      },
                      child: Icon(
                        _addedToCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                        color: _addedToCart ? Colors.amber : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.catalogue['banner']
                    // "https://previews.123rf.com/images/ikopylov/ikopylov1907/ikopylov190700005/128918382-welcome-back-to-school-horizontal-banner-first-day-of-school-pencils-and-supplies-on-yellow-backgrou.jpg"
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("From: "),
                      Text(
                        //"22/09/2019",
                        widget.catalogue['fromDate'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Until: "),
                      Text(
                        // "12/10/2019",
                        widget.catalogue['toDate'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
