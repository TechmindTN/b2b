import 'package:flutter/material.dart';
import 'package:siyou_b2b/utlis/AppIcons.dart';


class Header extends StatelessWidget {
  final String title;
  final Function function;

  Header({this.title, this.function});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$title',
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: function,
          child: Icon(
            AppIcons.right,
            color: Color(0xFFB7B7B7),
          ),
        )
      ],
    );
  }
}
