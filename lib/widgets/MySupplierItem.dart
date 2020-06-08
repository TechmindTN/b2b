import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MySupplierItem extends StatefulWidget {
  @override
  _MySupplierItemState createState() => _MySupplierItemState();
}

class _MySupplierItemState extends State<MySupplierItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      //widget.supplier['image'],
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X",
                      /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAkLchV5ooSMweRpJpBycL8I-_PjGVtXhm62tVCJdw-FGb_y5X"*/
                    ),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Super Supplier',
                        //widget.catalogue['supplierName'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 18.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '3 washington street, Milan 2451',
                        //widget.catalogue['date'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.remove_circle, color: Colors.red,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
