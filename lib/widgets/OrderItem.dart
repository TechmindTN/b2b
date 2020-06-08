import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: ScrollOnExpand(
      scrollOnExpand: false,
      scrollOnCollapse: true,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Row(children: <Widget>[
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
                    ],),
                  ),
                  Expanded(
                    child: Text(
                      "\$${item["orderPrice"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (item["orderStatus"] != "Done")
                    Expanded(
                      child: IconButton(
                        onPressed: () => null,
                        icon: Container(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
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
                    if (item["orderStatus"] != "Done")
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
                      )
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
//                          collapsed: Text("loremIpsum", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      for (var i in item["products"])
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  title: Text(i["title"]),
                                  leading: CachedNetworkImage(
                                    imageUrl: i["image"],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text("${i["quantity"]}"),
                              ),
                              Expanded(
                                child: Text("\$${i["price"]}"),
                              ),
                            ],
                          ),
                        ),
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
