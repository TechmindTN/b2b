import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/widgets/ErrorWidget.dart';
import 'package:siyou_b2b/widgets/TransactionWidget.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';

class ArchivedOrders extends StatefulWidget {
  @override
  _ArchivedOrdersState createState() => _ArchivedOrdersState();
}

class _ArchivedOrdersState extends State<ArchivedOrders> {
  AppLocalizations lang;
  CartProvider _orderProvide;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    _orderProvide = Provider.of<CartProvider>(context, listen: false);
    //_orderProvide?.getOrders(context);
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
        else if (provider.vaildorders != null &&
            provider.vaildorders.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.vaildorders.length,
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
            ClipboardData(text: _orderProvide.vaildorders[index].orderRef));
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
                        padding: const EdgeInsets.all(0.0),
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
                                        '${_orderProvide.vaildorders[index].orderRef}',
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
                                .vaildorders[index].supplier.firstName +
                            ' ' +
                            _orderProvide.vaildorders[index].supplier.lastName,
                        title: '${lang.tr('shopOwner.Supplier')} :',
                      ),
                      TransactionNoTextWidget(
                        transationInfoText: _orderProvide
                            .vaildorders[index].statut.statutName
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
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Text('${lang.tr('shopOwner.Total')}: ',
                              // textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                          Text(
                              '€ ${_orderProvide.vaildorders[index].orderPrice.toString()}',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w400)),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      ),
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
                            _orderProvide.vaildorders[index].productItem.length
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
                          in _orderProvide.vaildorders[index].productItem)
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
  }
}
