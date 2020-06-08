import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

class ShapeOfView2 extends StatelessWidget {
  final Widget child;
  final Shape shape;
  final double elevation;
  final Clip clipBehavior;
  final double height;
  final double width;

  ShapeOfView2({this.child,
    this.elevation = 4,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.width,
    this.height});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: ShapeOfViewBorder(shape: this.shape),
      clipBehavior: this.clipBehavior,
      elevation: this.elevation,
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: this.height,
        width: this.width,
        child: this.child,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureTextLogin = true;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> map = ModalRoute
        .of(context)
        .settings
        .arguments;
    final tag = map["tag"];
    final icon = map["icon"];
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Hero(
          child: Container(
            color: theme.primaryColor,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: _buildSignIn(context, theme, icon),
            ),
          ),
          tag: tag,
        ),
      ),
    );
  }


  Widget _buildSignIn(BuildContext context, ThemeData theme, bool icon) {
    final lang = AppLocalizations.of(context);
    final cardWidget = MediaQuery
        .of(context)
        .size
        .width * .8;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 23.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 160,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Icon(
                icon ? Icons.shopping_basket : Icons.store,
                color: Colors.white,
                size: 88,
              ),
            ),
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: ShapeOfView2(
                    elevation: 0,
                    shape: /*ArcShape(
                        direction: ArcDirection.Outside,
                        height: 60,
                        position: ArcPosition.Bottom
                    ),*/DiagonalShape(
                        position: DiagonalPosition.Bottom,
                        direction: DiagonalDirection.Right,
                        angle: DiagonalAngle.deg(angle: 10)
                    ),
                    child: Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: cardWidget,
                        height: 260.0,
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 15.0, left: 25.0, right: 25.0),
                                    child: TextFormField(
                                      validator: validateEmail,
                                      controller: loginEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.email,
                                          color: theme.accentColor,
                                          size: 22.0,
                                        ),
                                        hintText: lang.tr('loginScreen.email'),
                                        hintStyle: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: cardWidget - 50.0,
                                    height: 1.0,
                                    color: Colors.grey[400],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, left: 25.0, right: 25.0),
                                    child: TextFormField(
                                      validator: validatePassword,
                                      controller: loginPasswordController,
                                      obscureText: _obscureTextLogin,
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.lock,
                                          size: 22.0,
                                          color: theme.accentColor,
                                        ),
                                        hintText: lang.tr('loginScreen.password'),
                                        hintStyle: TextStyle(fontSize: 17.0),
                                        suffixIcon: GestureDetector(
                                          onTap: _toggleLogin,
                                          child: Icon(
                                            _obscureTextLogin
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 15.0,
                                            color: theme.accentColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16, bottom: 16),
                                child: loginButton(_loginUser),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  lang.tr('loginScreen.forgot_password'),
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  bool isEmail(String em) {
    String p =
        r'[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  String validateEmail(String text) {
    if (text.isEmpty || !isEmail(text)) {
      return AppLocalizations.of(context).tr('loginScreen.invalid_email');
    }
    return null;
  }

  String validatePassword(String text) {
    if (text.isEmpty)
      return AppLocalizations.of(context).tr('loginScreen.invalid_password');
    else if (text.length < 4)
      return AppLocalizations.of(context).tr('loginScreen.invalid_pass_length');
    return null;
  }

  void _loginUser() async {
    //TODO: Remove after test & add random email password
    /*if (!_formKey.currentState.validate()) {
      showPlatformMsg(
          context, AppLocalizations.of(context).tr('loginScreen.invalid'));
      return;
    }*/
    final Map<String, dynamic> map = ModalRoute
        .of(context)
        .settings
        .arguments;
    final tag = map["tag"];
    if(tag == "shop") {
      Navigator.pushNamedAndRemoveUntil(context,
          "/owner/home", (Route<dynamic> route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context,
          "/supplier/home", (Route<dynamic> route) => false);
    }

  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void showPlatformMsg(BuildContext context, String content,
      {String title = "Alert"}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (Platform.isAndroid) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme
                .of(context)
                .primaryColor,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 3),
      ));
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) =>
            CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text("Okay"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop("Discard");
                    })
              ],
            ),
      );
    }
  }

  loginButton(onPress) =>
      MaterialButton(
        key: ValueKey(1),
        highlightColor: Colors.transparent,
        splashColor: Theme
            .of(context)
            .primaryColorDark,
        color: Theme
            .of(context)
            .accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Icon(Icons.arrow_forward, color: Colors.white,),
        onPressed: onPress,
      );

  final loginLoading = Padding(
    padding: EdgeInsets.all(10.0),
    child: CircularProgressIndicator(
      key: ValueKey(2),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}