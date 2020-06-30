import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';

import 'package:siyou_b2b/widgets/Costum_backgroud.dart';
import 'package:siyou_b2b/widgets/appprop.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SupportPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context);
    return CustomPaint(
      painter: MainBackground(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          title: Text(
            lang.tr('shopOwner.support'),
            style: TextStyle(color: darkGrey),
          ),
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
              builder: (builder, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text('Phone'),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/png/phone.png')),
                              onTap: () async => await UrlLauncher.launch(
                                  "tel://00393891081886"),
                            ),
                            ListTile(
                              title: Text('E-mail'),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/png/phone.png')),
                              onTap: () async => await UrlLauncher.launch(
                                  "mailto:support@siyoutech.tn"),
                            ),
                            ListTile(
                              title: Text('Whatsapp'),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child:
                                      Image.asset('assets/png/whatsapp.png')),
                              onTap: () async =>
                                  await FlutterLaunch.launchWathsApp(
                                      phone: "+393891081886",
                                      message: "Can Someone Help me Please !"),
                            ),
                            ListTile(
                                title: Text(lang.tr('WeChat')),
                                leading: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                        'assets/png/wechat-icon.png')),
                                onTap: () async {
                                  // _shareText();
                                }),
                            ListTile(
                              title: Text(lang.tr('Facebook')),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child:
                                      Image.asset('assets/png/Facebook.png')),
                              onTap: () async => await UrlLauncher.launch(
                                  "http://m.me/siyou.technologyTN"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  
}
