import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/TransactionWidget.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';

class OrdersStatus extends StatefulWidget {
  @override
  _OrdersStatusState createState() => _OrdersStatusState();
}

class _OrdersStatusState extends State<OrdersStatus> {
  AppLocalizations lang;
  CartProvider _orderProvide;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _orderProvide = Provider.of<CartProvider>(context, listen: false);
    _orderProvide?.getOrders(context);
  }

  Widget getWidget() {
    return Consumer<CartProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return OpssWidget(
            onPress: _orderProvide.resetshoopOrders(context),
          );
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.invalidorders != null &&
            provider.invalidorders.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.invalidorders.length,
            itemBuilder: (context, index) => _getItemWidget(index),
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
        Clipboard.setData(
            ClipboardData(text: _orderProvide.invalidorders[index].orderRef));
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Tooltip(
            message: lang.tr('transaction_detail__copy'),
            child: Text(
              lang.tr('OrderNo Coppied'),
              style: Theme.of(context).textTheme.title.copyWith(
                  //color: PsColors.mainColor,
                  ),
            ),
            showDuration: const Duration(seconds: 5),
          ),
        ));
      },
    );
    return ExpandableNotifier(
        child: ScrollOnExpand(
      scrollOnExpand: false,
      scrollOnCollapse: true,
      child: Padding(
        padding: const EdgeInsets.all(00),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              Container(
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
                                    //flex: 5,
                                    child: Text(
                                        '${lang.tr('shopOwner.orderno')} :  ${_orderProvide.invalidorders[index].orderRef}',
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subhead
                                            .copyWith(fontSize: 12)),
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
                                .invalidorders[index].supplier.firstName +
                            ' ' +
                            _orderProvide
                                .invalidorders[index].supplier.lastName,
                        title: '${lang.tr('shopOwner.Supplier')} :',
                      ),
                      TransactionNoTextWidget(
                        transationInfoText:
                            '€ ${_orderProvide.invalidorders[index].orderPrice.toString()}',
                        title: '${lang.tr('shopOwner.Total')} :',
                      ),
                      TransactionNoTextWidget(
                        transationInfoText: _orderProvide
                            .invalidorders[index].statut.statutName
                            .toUpperCase(),
                        title: '${lang.tr('shopOwner.status')} :',
                      ),

                      /*_TransactionNoTextWidget(
              transationInfoText: transaction.cuponDiscountAmount == '0'
                  ? '-'
                  : '${transaction.currencySymbol} ${Utils.getPriceFormat(transaction.cuponDiscountAmount)}',
              title:
                  '${Utils.getString(context, 'transaction_detail__coupon_discount')} :',
            ),*/
                      const SizedBox(
                        height: 12,
                      ),
                      // _dividerWidget,
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text('View Details'),
                            //color: Colors.blueAccent,
                            //textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),*/
                      _dividerWidget
                    ],
                  )),
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
                        lang.tr('shopOwner.productlist') +
                            " (" +
                            _orderProvide
                                .invalidorders[index].productItem.length
                                .toString() +
                            ')',
                        style: Theme.of(context).textTheme.body2,
                      )),
//                          collapsed: Text("loremIpsum", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      for (var i
                          in _orderProvide.invalidorders[index].productItem)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                    // title: Text(i.itemBarcode),
                                    leading: Text(i.product.productName +
                                        " " +
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
    return RefreshIndicator(
        child: getWidget(),
        onRefresh: () => _orderProvide.resetshoopOrders(context));

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
