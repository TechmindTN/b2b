import 'package:flutter/material.dart';
import 'header.dart';

List sofas = [
  {
    'name': 'Kllppan Sofa',
    'description': '4-sear sofa,vissal grey',
    'oldPrice': '999',
    'newPrice': '899',
    'image': 'assets/images/sofa/sofaOne.jfif'
  },
  {
    'name': 'Armchair Sofa',
    'description': '4-sear sofa,vissal grey',
    'oldPrice': '879',
    'newPrice': '565',
    'image': 'assets/images/sofa/sofaTwo.jfif'
  },
  {
    'name': 'Modular  Sofa',
    'description': '4-sear sofa,vissal grey',
    'oldPrice': '564',
    'newPrice': '156',
    'image': 'assets/images/sofa/sofaThree.jfif'
  },
  {
    'name': 'Clik-claks Sofa',
    'description': '4-sear sofa,vissal grey',
    'oldPrice': '1000',
    'newPrice': '900',
    'image': 'assets/images/sofa/sofaFour.jfif'
  },
];

class BottomSectionCopy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Header(
              title: 'Featured Product Packs',
              function: () {
                debugPrint('Featured Product Packs -> ');
              },
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Container(
            height: 240.0,
            //color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sofas.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: buildSofas(context, index),
                  ),
            ),
          ),
       
        ],
      );
    
  }
}

var buildSofas = (BuildContext context, int index) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          elevation: 10.0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: Container(
              height: 150.0,
              width: 250.0,
              child: Image.asset(
                sofas[index]['image'],
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sofas[index]['name'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              sofas[index]['description'],
              style: TextStyle(
                  color: Color(0xFFB7B7B7),
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  '\$${sofas[index]['oldPrice']}',
                  style: TextStyle(
                    color: Color(0xFFB7B7B7),
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '\$${sofas[index]['newPrice']}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.0,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
