import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:siyou_b2b/models/Theme.dart';

class ServerErrorWidget extends StatelessWidget {
  final String errorText;

  const ServerErrorWidget({Key key, this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);

    return Container(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
       // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 2,
              child: SvgPicture.asset(
                'assets/svg/server_down.svg',
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              errorText ?? lang.tr('utils.server_error'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyThemes.getAccentDark(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0),
            ),
          )
        ],
      ),
    );
  }
}