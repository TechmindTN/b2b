

import 'package:flutter/material.dart';

class StockWidget extends StatefulWidget {
  final Function onAddStock;
  final Function onRemoveStock;
  final Function onRemove;
  int stock;

  StockWidget(
      {Key key,
        @required this.stock,
        @required this.onAddStock,
        @required this.onRemoveStock,
        @required this.onRemove})
      : super(key: key);

  @override
  _StockWidgetState createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 24,
          width: 24,
          child: RawMaterialButton(
            onPressed: () {
              if (widget.stock - 1 > 0) {
                widget.stock -= 1;
                widget.onRemoveStock(widget.stock);
                setState(() {});
              } else
                widget.onRemove();
            },
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            shape: CircleBorder(),
            elevation: 0.0,
            fillColor: Theme.of(context).primaryColorDark,
          ),
        ),
        Text(
          "${widget.stock}",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: RawMaterialButton(
            onPressed: () {
              widget.stock += 1;
              widget.onAddStock(widget.stock);
              setState(() {});
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            shape: CircleBorder(),
            elevation: 0.0,
            fillColor: Theme.of(context).primaryColorDark,
          ),
        ),
      ],
    );
  }
}