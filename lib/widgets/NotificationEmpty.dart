import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        SizedBox(
          height: 300,
          child: SvgPicture.asset(
            'assets/svg/notification_empty.svg',
          ),
        ),
        Text("Your up to date with your notifications",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor, fontSize: 28),)
      ],
    );
  }
}
