import 'package:flutter/material.dart';

// ignore: unused_element
class TransactionNoTextWidget extends StatelessWidget {
  const TransactionNoTextWidget({
    Key key,
    @required this.transationInfoText,
    this.title,
  }) : super(key: key);

  final String transationInfoText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            transationInfoText ?? '-',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}