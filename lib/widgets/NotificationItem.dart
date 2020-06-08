
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String icon;
  final Color iconColor;
  final Color background;
  final Function markAsRead;
  final Function remove;

  const NotificationItem({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.iconColor,
    @required this.background,
    @required this.markAsRead,
    @required this.remove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context);

    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: iconColor,
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.all(8.0),
        color: background,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        icon,
                        color: iconColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.done_all,
                          color: theme.primaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          lang.tr("notificationScreen.mark"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => markAsRead,
                  ),
                  Container(
                    color: iconColor,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                    width: 1,
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: theme.primaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          lang.tr("notificationScreen.remove"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => remove,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}