import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/HomeProvider.dart';
import 'package:siyou_b2b/widgets/progressindwidget.dart';
import 'package:siyou_b2b/widgets/servererrorwidget.dart';

class MangersList extends StatefulWidget {
  @override
  _OrdersStatusState createState() => _OrdersStatusState();
}

class _OrdersStatusState extends State<MangersList> {
  AppLocalizations lang;
  HomeProvider userProvider;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lang = AppLocalizations.of(context);
    userProvider = Provider.of<HomeProvider>(context, listen: false);
    userProvider?.getSalesManagerList(context);
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
        else if (provider.managers != null && provider.managers.isNotEmpty) {
          return ListView.builder(
            //scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: provider.managers.length,
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
                      new Text(userProvider.managers[index].userNickname
                              .toUpperCase() +
                          ' ' +
                          userProvider.managers[index].userAccount
                              .toUpperCase()),
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
                child: userProvider.managers[index].avatar == null
                    ? Image.asset(
                        "assets/png/empty_cart.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      )
                    : CachedNetworkImage(
                        imageUrl: userProvider.managers[index].avatar,
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
  }
}
