import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'CarouselProductItem.dart';

class CarouselProductsWidget extends StatefulWidget {
  @override
  _CarouselProductsWidgetState createState() => _CarouselProductsWidgetState();
}

final List<String> imgList = [
  'https://cdn.shopify.com/s/files/1/1205/5200/products/PortProducts-ConditioningBeardAbsolute_1800x.png?v=1527359773',
  'http://www.stp.com/sites/default/files/fuel_additives_1.0_3.png',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbIXpwerq3XZnVTimFMnvLuFPfXomxl889l2a1A6WQkUwP4SxcDA',
  'https://www.raspberrypi.org/homepage-9df4b/static/881d5692b6306083183def5f6484c383/bc3a8/79f578c2ef5c98c09bc85b69fac1e68e6c5a80aa_raspberry-pi-4-model-b.jpg',
  'https://cnet2.cbsistatic.com/img/-VNKAnfFLbcN45NsRtlvY1pvQ1g=/308x256/2019/06/04/5e32b391-91d5-4d8e-a796-b15a6b08f19d/premium-true-wireless-group-2.jpg',
  'https://in.canon/media/image/2018/04/10/754dfa665b31449e82158240c46f3da5_Printing-consumer.png'
];

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

final List child = map<Widget>(
  imgList,
  (index, i) {
    return CarouselProductItem(i);
  },
).toList();

class _CarouselProductsWidgetState extends State<CarouselProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: productsCarousel(),
    );
  }

  Widget productsCarousel() {
    final basicSlider = CarouselSlider(
      items: child,
      scrollPhysics: BouncingScrollPhysics(),
      enableInfiniteScroll: true,
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 3),
      enlargeCenterPage: true,
      viewportFraction: 0.7,
      aspectRatio: 2.6,
      height: 160.0,
    );

    return basicSlider;
    /*
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          basicSlider,
          Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.navigate_before),
                    color: Colors.orange,
                    onPressed: () {
                      setState(() {
                        _autoPlay = false;
                      });
                      basicSlider.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }),
                IconButton(
                    icon: Icon(Icons.navigate_next),
                    color: Colors.orange,
                    onPressed: () {
                      setState(() {
                        _autoPlay = false;
                      });
                      basicSlider.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );
                    }),
              ]),
        ]);
     */
  }
}
