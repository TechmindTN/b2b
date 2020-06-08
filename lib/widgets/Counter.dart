import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  final bool isbig;
  
  const MyCounter({
    Key key,
    this.isbig,
  }) : super(key: key);

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: widget.isbig ? 20 : 10,
            ),
          ),
          onTap: () {
            setState(() {
              _currentAmount -= 1;
            });
          },
        ),
        SizedBox(width: 15),
        Text(
          "$_currentAmount",
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(width: 15),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: widget.isbig ? 20 : 10,
            ),
          ),
          onTap: () {
            setState(() {
              _currentAmount += 1;
            });
          },
        ),
      ],
    );
  }
}
