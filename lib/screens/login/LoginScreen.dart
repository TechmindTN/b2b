import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:siyou_b2b/providers/LoginProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  bool _obscureTextLogin = true;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginProvider loginModel;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    await Future.delayed(const Duration(seconds: 0), () async {
      loginModel = Provider.of<LoginProvider>(context, listen: false);
      bool login = await loginModel.userSignedIn();
      var role = await getUserRole();
     // var token = await getUserToken();
      if (login) {
        if (role == 3)
          Navigator.pushNamedAndRemoveUntil(
              context, "/owner/home", (Route<dynamic> route) => false);
        else if (role==2){
          Navigator.pushNamedAndRemoveUntil(
              context, "/supplier/home", (Route<dynamic> route) => false);
         // print(token.toString());
          //webwiew(token);
          ///supplier/home
        }
        else {
          Navigator.pushNamedAndRemoveUntil(
              context, "/manager/home", (Route<dynamic> route) => false);
         // print(token.toString());
          //webwiew(token);
          ///supplier/home
        }
      }
    });
  }

 

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [theme.primaryColorDark, theme.primaryColor],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Center(child: _buildSignIn(context, theme)),
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context, ThemeData theme) {
    final lang = AppLocalizations.of(context);
    final cardWidget = MediaQuery.of(context).size.width * .8;

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
              child: Image.asset(
                "assets/png/siyou_white.png",
                height: 80.0,
                fit: BoxFit.contain,
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: cardWidget,
                    height: 230.0,
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 15.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              validator: validateEmail,
                              focusNode: myFocusNodeEmailLogin,
                              controller: loginEmailController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
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
                              focusNode: myFocusNodePasswordLogin,
                              controller: loginPasswordController,
                              obscureText: _obscureTextLogin,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                  color: theme.accentColor,
                                ),
                                hintText: lang.tr('loginScreen.password'),
                                hintStyle: TextStyle(fontSize: 17.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    _obscureTextLogin
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 210.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    /**
                        boxShadow: <BoxShadow>[
                        BoxShadow(
                        color: MyThemes.getAccentLight(context),
                        offset: Offset(1.0, 3.0),
                        blurRadius: 20.0,
                        ),
                        BoxShadow(
                        color: MyThemes.getAccentDark(context),
                        offset: Offset(1.0, 4.0),
                        blurRadius: 20.0,
                        ),
                        ],
                     **/
                    color: theme.accentColor,
                  ),
                  child: Consumer<LoginProvider>(
                    builder: (context, model, child) {
                      return _renderLoginButton(model);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton(
                onPressed: () {
                  if (loginModel.status != Status.Authenticating) {}
                },
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

  Widget _renderLoginButton(LoginProvider model) {
    switch (model.status) {
      case Status.Authenticated:
        return Container();

      case Status.Authenticating:
        return loginLoading;

      case Status.Uninitialized:
      case Status.Unauthenticated:
      default:
        return loginButton(_loginUser);
    }
  }

  bool isEmail(String em) {
    String p =
        r'[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  String validateEmail(String text) {
    if (text.isEmpty /*|| !isEmail(text)*/) {
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
    if (!_formKey.currentState.validate()) {
      showPlatformMsg(
          context, AppLocalizations.of(context).tr('loginScreen.invalid'));
      return;
    }

    final map = await loginModel.signInUser(
        loginEmailController.value.text.trim(),
        loginPasswordController.value.text);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', loginEmailController.value.text.trim());
    prefs.setString('userpw', loginPasswordController.value.text);
    print(map.toString());
    if (map["status"]) {
      switch (map["role"]) {
        // Owner
        case 1:
          // Manager
          Navigator.pushNamedAndRemoveUntil(
             context, "/manager/home", (Route<dynamic> route) => false);
          // webwiew(map["token"]);
          break;
        case 2:
          Navigator.pushNamedAndRemoveUntil(
             context, "/supplier/home", (Route<dynamic> route) => false);
           // webwiew(map["token"]);
          break;
        case 3:
          //
          Navigator.pushNamedAndRemoveUntil(
              context, "/owner/home", (Route<dynamic> route) => false);
          break;
        case 4:
          //
          Navigator.pushNamedAndRemoveUntil(
              context, "/underConstruction", (Route<dynamic> route) => false);
          break;
      }
    } else {
      showPlatformMsg(context, map["error"]);
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
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 5),
      ));
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
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

  loginButton(onPress) => MaterialButton(
        key: ValueKey(1),
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).primaryColorDark,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            AppLocalizations.of(context).tr('loginScreen.sign_in'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
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
