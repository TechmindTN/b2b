import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';

import 'CarouselProductsWidget.dart';


class MyCatalogueItem extends StatefulWidget {
  final Map catalogue;

  MyCatalogueItem(this.catalogue);

  @override
  _MyCatalogueItemState createState() => _MyCatalogueItemState();
}

class _MyCatalogueItemState extends State<MyCatalogueItem> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  bool _public = true;
  bool _addedToCart = false;

  @override
  void initState() {
    super.initState();
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return Card(
      child: Container(
        height: 400.0,
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
                    onTap: () => Navigator.pushNamed(context, widget.catalogue["route"]),
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
                              Row(
                                children: <Widget>[
                                  Text(
                                    //'September 15 at 8:09 PM',
                                    widget.catalogue['date'],
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      _public ? Icons.public : Icons.person,
                                      color: Colors.grey[900],
                                      size: 20.0,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Colors.grey[900],
                    key: btnKey,
                    onPressed: myMenu,
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
              flex: 5,
              child: CarouselProductsWidget(),
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
      ),
    );
  }

  void myMenu() {
    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.grey[100],
        lineColor: Colors.white,
        maxColumn: 1,
        highlightColor: Colors.blueGrey[100],
        items: [
          MenuItem(
            title: 'Edit',
            image: Icon(
              Icons.collections,
              color: Colors.black87,
            ),
            textStyle: TextStyle(color: Colors.black87),
          ),
          MenuItem(
            title: 'Privacy',
            image: Icon(
              Icons.public,
              color: Colors.black87,
            ),
            textStyle: TextStyle(color: Colors.black87),
          ),
          MenuItem(
            title: 'Hide',
            image: Icon(
              Icons.close,
              color: Colors.black87,
            ),
            textStyle: TextStyle(color: Colors.black87),
          ),
          MenuItem(
            title: 'Delete',
            image: Icon(
              Icons.delete,
              color: Colors.black87,
            ),
            textStyle: TextStyle(color: Colors.black87),
          ),
          MenuItem(
              title: 'Copy Link',
              image: Icon(
                Icons.content_copy,
                color: Colors.black87,
              ),
              textStyle: TextStyle(color: Colors.black87))
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey);
  }
}
