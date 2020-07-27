import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class SuppOrdersStatus extends StatefulWidget {
  @override
  _OrdersStatusState createState() => _OrdersStatusState();
}

class _OrdersStatusState extends State<SuppOrdersStatus> {
  AppLocalizations lang;
  CartProvider _orderProvide;
  ScrollController _scrollController = new ScrollController();
  final ApiProvider _api = ApiProvider();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _orderProvide = Provider.of<CartProvider>(context, listen: false);
    _orderProvide?.getSupplierOrders(context);
  }

  Widget getWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.suppinvalidorders != null &&
            provider.suppinvalidorders.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.suppinvalidorders.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: _getItemWidget(index),
                onTap: () => _showDialog(
                    index), /*_onItemPressed(
                    context, index, provider.suppinvalidorders[index].id),*/
              );
            },
          );
        } else
          return Container(
            child: Center(
              child: Text("No Orders Found ! "),
            ),
          );
      },
    );
  }

  Future<bool> orderCR(int id, String status) async {
    loadingDialog(context, lang);
    try {
      final data = await _api.confirmRejectOrder(id, status);

      if (checkorder(data)) {
        Navigator.pop(context);
        return true;
      } else {
        Navigator.pop(context);
        showAlertDialog(context, "", 'error');
        return false;
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showAlertDialog(context, e.toString(), e.toString());
      return false;
    }
  }

  void _showDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(lang.tr('supplier.confirme')),
            content: Text(lang.tr('supplier.alert')),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    var confirm = await orderCR(
                        _orderProvide.suppinvalidorders[index].id, "confirm");
                    print(confirm);
                    if (confirm == true) {
                      _orderProvide.suppinvalidorders.clear();
                      _orderProvide.suppinvalidorders.clear();
                      _orderProvide.getSupplierOrders(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(lang.tr('supplier.Accept'))),
              FlatButton(
                  onPressed: () async {
                    var confirm = await orderCR(
                        _orderProvide.suppinvalidorders[index].id, "rejected");
                    print(confirm);
                    if (confirm == true) {
                      _orderProvide.suppinvalidorders.clear();
                      _orderProvide.suppinvalidorders.clear();
                      _orderProvide.getSupplierOrders(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(lang.tr('supplier.reject'))),
            ],
          );
        });
  }

  /*void _onItemPressed(BuildContext context, int i, int orderid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Wrap(children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size(86, 86), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.green, // button color
                            child: InkWell(
                              splashColor: Colors.white, // splash color
                              onTap: () {
                                if (orderCR(orderid, 'confirm')) {
                                  Navigator.pop(context);
                                  _orderProvide.invalidorders.removeAt(i);
                                  _orderProvide.notify();
                                  Navigator.pop(context);
                                }
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.check_circle), // icon
                                  Text("Confirme"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox.fromSize(
                        size: Size(86, 86), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.red, // button color
                            child: InkWell(
                              splashColor: Colors.white, // splash color
                              onTap: () {
                                if (orderCR(orderid, 'rejected')) {
                                  Navigator.pop(context);
                                  _orderProvide.invalidorders.removeAt(i);
                                  _orderProvide.notify();
                                  Navigator.pop(context);
                                }
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.close), // icon
                                  Text("Reject"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /*Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black87, shape: BoxShape.circle),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),*/
              ]),
            ]),
          );
        });
  }*/

  Widget _getItemWidget(
    int index,
  ) {
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
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: <Widget>[
                            /*Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            alignment: Alignment.centerLeft,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
                            ),
                            imageUrl: "${item["image"]}",
                          ),
                        ),*/
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _orderProvide.suppinvalidorders[index]
                                      .shopOwner.firstName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${_orderProvide.suppinvalidorders[index].orderRef}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\€${_orderProvide.suppinvalidorders[index].orderPrice}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      /* if (item["orderStatus"] != "Done")
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
                    ),*/
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                          "Shop - ${_orderProvide.suppinvalidorders[index].shopOwner.firstName} ${_orderProvide.suppinvalidorders[index].shopOwner.lastName}"),
                      flex: 3,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff3ed3d3),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Text(
                            'Waiting for Your Validation',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                      ),
                    )

                    /* Padding(
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
//                          collapsed: Text("loremIpsum", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      for (var i
                          in _orderProvide.suppinvalidorders[index].productItem)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                    
                                    leading: Text(i.product.productName+' '+i.itemBarcode)
                                    /*CachedNetworkImage(
                                    imageUrl: i.product.productName,
                                  ),*/
                                    ),
                              ),
                              Expanded(
                                child: Text("${i.pivot.quantity}"),
                              ),
                              Expanded(
                                child: Text("\€${i.itemOnlinePrice}"),
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

  @override
  Widget build(BuildContext context) {
    return getWidget();
    /*ListView(
      children: <Widget>[
        OrderItem(
          item: item,
        ),
        OrderItem(
          item: item,
        ),
      ],
    );*/
  }
}
