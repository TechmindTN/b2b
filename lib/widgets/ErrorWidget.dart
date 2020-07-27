import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OpssWidget extends StatelessWidget {
  final Future<void> onPress;

  OpssWidget({
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    //final textStyle = TextStyle(color: Colors.black, fontSize: 14);
    //final theme = Theme.of(context);

    return Container(
      //margin: EdgeInsets.only(top: 4),
      //constraints: BoxConstraints.expand(height: 225),
      child: InkWell(
          onTap: () => onPress,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    // color: const Color(0xffffffff), //fafafa
                    child: Image.asset(
                      "assets/png/error-icon.png",
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    )),
                Container(
                    alignment: Alignment.center,
                    //   color: const Color(0xffffffff), //fafafa
                    child: Text(
                      lang.tr('shopOwner.opss'),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Container(
                  alignment: Alignment.center,
                  //   color: const Color(0xffffffff), //fafafa
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.refresh,
                            //size: 10,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                            text: lang.tr('shopOwner.tryagain'),
                            style: TextStyle(color: Colors.grey)),
                        WidgetSpan(
                          child: SizedBox(
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
