import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class ShopList extends StatefulWidget {
  @override
  _OrdersStatusState createState() => _OrdersStatusState();
}

class _OrdersStatusState extends State<ShopList> {
  AppLocalizations lang;
  HomeProvider userProvider;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    userProvider = Provider.of<HomeProvider>(context, listen: false);
    userProvider?.getShopList(
      context,
    );
  }

  Widget getWidget() {
    return Consumer<HomeProvider>(
      builder: (context, provider, widget) {
        if (provider.error)
          return ServerErrorWidget(
            errorText: provider.errorMsg,
          );
        else if (provider.loading)
          return ProgressIndicatorWidget();
        else if (provider.shops != null && provider.shops.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.shops.length,
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

  Widget _getItemWidget(
    int index,
  ) {
    return Card(
       elevation: 0.0,
      child: Container(
        child: ListTile(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.store,
                  color: Colors.red,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(userProvider.shops[index].userNickname
                              .toUpperCase() +
                          ' ' +
                          userProvider.shops[index].userAccount.toUpperCase()),
                    ],
                  ),
                )
              ],
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              child: Container(
                height: 200.0,
                width: 80.0,
                child: userProvider.shops[index].avatar == null
                    ? Image.asset(
                        "assets/png/empty_cart.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      )
                    : CachedNetworkImage(
                        imageUrl: userProvider.shops[index].avatar,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(userProvider.user.phonenum1),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(userProvider.user.adress + ', '),
                            Text(userProvider.user.region +
                                ' ' +
                                userProvider.user.postcode +
                                ', '),
                            Text(userProvider.user.country),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {}),
      ),
    );
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
