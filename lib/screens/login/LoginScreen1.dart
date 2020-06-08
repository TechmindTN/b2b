import 'package:flutter/material.dart';
import 'package:siyou_b2b/utlis/AppThemes.dart';
import 'package:siyou_b2b/widgets/SimpleRoundIconButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [theme.primaryColorDark, theme.primaryColor,theme.primaryColorLight,],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SimpleRoundIconButton(
                  tag: "supplier",
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.store),
                  onPressed: () => Navigator.pushNamed(context, '/login', arguments: {"tag": "supplier", "icon": false}),
                  buttonText: Text(
                    "Supplier",
                    style: TextStyle(
                        color: MyThemes.titleColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  iconAlignment: Alignment.centerRight,
                  textColor: Colors.white,
                ),
                SimpleRoundIconButton(
                  tag: "shop",
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () => Navigator.pushNamed(context, '/login', arguments: {"tag": "shop", "icon": true}),
                  buttonText: Text(
                    "Shop",
                    style: TextStyle(
                        color: MyThemes.titleColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  iconAlignment: Alignment.centerRight,
                ),
              ],
            )),
      ),
    );
  }
}

//          WavyBackground(
//            height: height,
//          ),
//          Align(
//            alignment: Alignment.bottomCenter,
//            child: RotatedBox(
//              quarterTurns: 2,
//              child: WavyBackground(
//                height: height,
//                top: false
//              ),
//            ),
//          ),
class WavyBackground extends StatelessWidget {
  final double height;
  final bool top;

  final List<Color> orangeGradients = [
    Colors.blue[300],
    Colors.blue[500],
    Colors.blue[700],
  ];

  WavyBackground({Key key, this.height, this.top = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        alignment: top? null: Alignment.bottomCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: orangeGradients,
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter),
        ),
        height: height,
      ),
    );
  }
}




class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    //creating first curver near bottom left corner
    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center
    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //creating third curver near top right corner
    var thirdControlPoint =
        Offset(size.width /*- (size.width / 9)*/, size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    //creating first curver near bottom left corner
    var firstControlPoint = new Offset(size.width * .15, size.height * .8);
    var firstEndPoint = new Offset(size.width * .22, size.height * .9);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center
    var secondControlPoint = Offset(size.width * .55, size.height * .65);
    var secondEndPoint = Offset(size.width * .4, size.height * .38);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //creating third curver near top right corner
    var thirdControlPoint =
    Offset(size.width * .5, size.height * .22);
    var thirdEndPoint = Offset(size.width, size.height * .08);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

