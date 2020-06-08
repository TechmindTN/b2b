import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(),
        ));
  }
}