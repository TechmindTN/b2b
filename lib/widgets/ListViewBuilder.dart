
import 'package:flutter/material.dart';

import 'CatalogueItem.dart';
import 'CatalogueItemWidget.dart';
import 'RecentlyAddedProducts.dart';

class ListViewBuilder extends StatelessWidget {
  final Map listItem;
  final List<Map> list;

  ListViewBuilder(this.listItem, this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  listItem['title'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                isOptionWidget(context, listItem['optionButton']),
              ],
            ),
          ),
          SizedBox(
            height: listItem['height'],
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return getWidget(list[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget getWidget(Map map) {
    switch (listItem['widgetName']) {
      case "RecentlyAddedProducts":
        return RecentlyAddedProducts(map);
      case "CatalogueItem":
        return CatalogueItem(map);
      case "CatalogueItemWidget":
        return CatalogueItemWidget(map);
    }
    return null;
  }

  Widget optionButton(BuildContext context, Map map) {
    return FlatButton(
      onPressed: () => Navigator.pushNamed(context, map['route']),
      child: Text(
        map['title'],
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.blueGrey[400],
            decoration: TextDecoration.underline),
      ),
    );
  }

  Widget isOptionWidget(BuildContext context, Map map) {
    Widget widget;
    if (map != null) {
      widget = optionButton(context, map);
    }
    return widget;
  }
}
