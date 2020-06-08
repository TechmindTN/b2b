import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:siyou_b2b/widgets/StockWidget.dart';

class CartItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const CartItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      scrollOnExpand: false,
      scrollOnCollapse: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            alignment: Alignment.centerLeft,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                            imageUrl: "${item["image"]}",
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item["title"],
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Order ${item["orderId"]}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "\$${item["orderPrice"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  /*if (item["orderStatus"] != "Done")
                    Expanded(
                      child: IconButton(
                        onPressed: () => null,
                        icon: Container(
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Purchase date - ${item["orderDate"]}"),
                      flex: 3,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Text(
                            "Remove",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    /*if (item["orderStatus"] != "Done")
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff3ed3d3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Text(
                              item["orderStatus"],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xff3ed3d3),
                        ),
                        padding: EdgeInsets.all(4.0),
                      )*/
                  ],
                ),
              ),
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  tapHeaderToExpand: true,
                  tapBodyToCollapse: true,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Products List",
                        style: Theme.of(context).textTheme.body2,
                      )),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      for (var i in item["products"])
                        CartProductItem(item: i,)
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        crossFadePoint: 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

// add provider and remove from list

class CartProductItem extends StatelessWidget {

  final Map<String, dynamic> item;

  const CartProductItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CachedNetworkImage(
              imageUrl: item["image"],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text("${item['title']}"),
          ),
          Expanded(
            flex: 2,
            child: StockWidget(
              stock: 2,
              onAddStock: (s) => null,
              onRemoveStock: (s) => null,
              onRemove: () => null,
            ),
          ),
          Expanded(
            child: Text("\$${item["price"]}"),
          ),
        ],
      ),
    );
  }
}
