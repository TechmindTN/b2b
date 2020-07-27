import 'package:flutter/material.dart';

enum CarouselTypes { home, details }

class CarouselProductsList extends StatefulWidget {
  final CarouselTypes type;
  final List<String> productsList;
  const CarouselProductsList({
    Key key,
    @required this.type,
    @required this.productsList,
  }) : super(key: key);
  @override
  _CarouselProductsListState createState() => _CarouselProductsListState();
}

class _CarouselProductsListState extends State<CarouselProductsList> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.type == CarouselTypes.details ? 200 : 120,
        
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: PageController(
                      viewportFraction:
                          widget.type == CarouselTypes.details ? .80 : .99,
                    ),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: widget.productsList.length,
                    itemBuilder: (ctx, id) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: widget.type == CarouselTypes.details
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        margin: widget.type == CarouselTypes.details &&
                                _currentIndex != id
                            ? const EdgeInsets.symmetric(
                                horizontal: 9.0,
                                vertical: 15,
                              )
                            : const EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 0,
                              ),
                        child: ClipRRect(
                          borderRadius: widget.type == CarouselTypes.details
                              ? BorderRadius.circular(15.0)
                              : BorderRadius.circular(1.0),
                          child: Image.network(
                            "${widget.productsList[id]}",
                            fit: widget.type == CarouselTypes.details
                                ? BoxFit.fill
                                : BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.productsList.length,
              (i) {
                return Container(
                  width: 9,
                  height: 9,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _currentIndex ? Colors.black : Colors.grey,
                  ),
                );
              },
            ),
          )
          ],
        ));
  }
}
