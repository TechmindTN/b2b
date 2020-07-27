import 'package:flutter/material.dart';

class RecentlyAddedProducts extends StatefulWidget {
  final Map product;

  RecentlyAddedProducts(this.product);

  @override
  _RecentlyAddedProductsState createState() => _RecentlyAddedProductsState();
}

class _RecentlyAddedProductsState extends State<RecentlyAddedProducts> {
  //bool _bookmarked = false;
  //bool _favorite = false;
  //bool _addedToCart = false;

  @override
  Widget build(BuildContext context) {
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
                      child: Text("Epson Printer"),
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
                              'https://in.canon/media/image/2018/04/10/754dfa665b31449e82158240c46f3da5_Printing-consumer.png',
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Unit Price'),
                                Text('Wholsale Price'),
                                Text('Quantity'),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '20.0 €',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '15.0 €',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '1000.0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
          /*Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: new Icon(
                      _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: _bookmarked ? Colors.amber : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _bookmarked = !_bookmarked;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: new Icon(
                      _favorite ? Icons.favorite : Icons.favorite_border,
                      color: _favorite ? Colors.amber : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _favorite = !_favorite;
                      });
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: new Icon(
                      _addedToCart ? Icons.shopping_cart : Icons.add_shopping_cart ,
                      color: _addedToCart ? Colors.amber : null,
                    ),
                    onPressed: () {
                      setState(() {
                        _addedToCart = !_addedToCart;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
