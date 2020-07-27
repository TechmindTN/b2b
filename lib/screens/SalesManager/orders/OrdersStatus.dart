import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/widgets/TransactionWidget.dart';
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
  //final ApiProvider _api = ApiProvider();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _orderProvide = Provider.of<CartProvider>(context, listen: false);
    _orderProvide?.getManagerOrders(context);
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
        else if (provider.managerinvalidorders != null &&
            provider.managerinvalidorders.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.managerinvalidorders.length,
            itemBuilder: (context, index) {
              return _getItemWidget(index);
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

  Widget _getItemWidget(int index) {
    const Widget _dividerWidget = Divider(height: 2);
    final Widget _contentCopyIconWidget = IconButton(
      iconSize: 20,
      icon: Icon(
        Icons.content_copy,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () {
        Clipboard.setData(ClipboardData(
            text: _orderProvide.managerinvalidorders[index].orderRef));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Tooltip(
            message: lang.tr('transaction_detail__copy'),
            child: Text(
              lang.tr('Batch No Coppied'),
              style: Theme.of(context).textTheme.title.copyWith(
                  //color: PsColors.mainColor,
                  ),
            ),
            showDuration: const Duration(seconds: 5),
          ),
        ));
      },
    );
    return Container(
        // color: Colors.black87,
        padding: const EdgeInsets.only(
          left: 6,
          right: 6,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.offline_pin,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                              '${lang.tr('shopOwner.OrderNo')} : ${_orderProvide.managerinvalidorders[index].orderRef}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.subhead),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  _contentCopyIconWidget,
                ],
              ),
            ),
            _dividerWidget,
            TransactionNoTextWidget(
              transationInfoText: _orderProvide
                      .managerinvalidorders[index].supplier.firstName +
                  ' ' +
                  _orderProvide.managerinvalidorders[index].supplier.lastName,
              title: '${lang.tr('shopOwner.Supplier')} :',
            ),
            TransactionNoTextWidget(
              transationInfoText:
                  _orderProvide.managerinvalidorders[index].orderPrice,
              title: '${lang.tr('Total')} :',
            ),
            TransactionNoTextWidget(
              transationInfoText:
                  _orderProvide.managerinvalidorders[index].statut.statutName,
              title: '${lang.tr('Status')} :',
            ),

            /* _TransactionNoTextWidget(
              transationInfoText: transaction.cuponDiscountAmount == '0'
                  ? '-'
                  : '${transaction.currencySymbol} ${Utils.getPriceFormat(transaction.cuponDiscountAmount)}',
              title:
                  '${Utils.getString(context, 'transaction_detail__coupon_discount')} :',
            ),*/
            const SizedBox(
              height: 12,
            ),
            _dividerWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('View Details'),
                  //color: Colors.blueAccent,
                  //textColor: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ));
  }

  Widget _getItemWidget1(
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
                                  _orderProvide.managerinvalidorders[index]
                                      .shopOwner.firstName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${_orderProvide.managerinvalidorders[index].orderRef}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\€${_orderProvide.managerinvalidorders[index].orderPrice}",
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
                          "Shop - ${_orderProvide.managerinvalidorders[index].shopOwner.firstName} ${_orderProvide.managerinvalidorders[index].shopOwner.lastName}"),
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
                      for (var i in _orderProvide
                          .managerinvalidorders[index].productItem)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                    leading: Text(i.product.productName +
                                        ' ' +
                                        i.itemBarcode)
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
