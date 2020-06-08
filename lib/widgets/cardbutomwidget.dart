import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CardButtonsWidget extends StatelessWidget {
  final Map listItem;
  final List<Map> list;

  CardButtonsWidget(this.listItem, this.list);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .width;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            listItem['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: height > 600 ? height / 8 : height / 5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _getCardButtonWidget(context, list[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCardButtonWidget(BuildContext context, Map map) {
    final theme = Theme.of(context);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final double textSize = width > 600 ? 16 : width >= 400 ? 14 : 12;
    final double padding = width > 600 ? 10 : width >= 400 ? 8 : 5;

    return InkWell(
      onTap: getAction(map, context),
      child: SizedBox(
        width: width > 600 ? width / 8 : width / 5,
        child: Card(
          elevation: 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: SvgPicture.asset(
                      map['svgPath'],
                      fit: BoxFit.contain,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: AutoSizeText(
                    map['title'], style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: textSize,
                  ),
                    minFontSize: textSize - 2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /*getDialog(String dialog, BuildContext context) {
    switch (dialog) {
      case 'member':
        AddMemberWidget.showAddMemberDialog(context);
        break;
      case 'product':
        AddProductWidget.showAddProductDialog(context);
        break;
      case 'quick-add':
        AddQuickProductWidget.showAddProductDialog(context);
        break;
    }
  }*/

  getAction(Map map, BuildContext context) {
    if (map['route'] != null) {
      return () => Navigator.pushNamed(context, map['route']);
    }
   /* if (map['dialog'] != null) {
      return () => getDialog(map['dialog'], context);
    }*/
  }
}
