import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siyou_b2b/screens/Shopowner/settings/change_country.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'package:siyou_b2b/widgets/Costum_backgroud.dart';
import 'package:siyou_b2b/widgets/appprop.dart';

import 'change_language_page.dart';
import 'change_password_page.dart';
import 'legal_about_page.dart';
import 'notifications_settings_page.dart';

class SettingsPage extends StatelessWidget {
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
            lang.tr('shopOwner.Settings'),
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                lang.tr('shopOwner.general'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text('Language A / 语言'),
                              leading: SvgPicture.asset(
                                'assets/svg/Language.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeLanguagePage())),
                            ),
                            ListTile(
                              title: Text(lang.tr('shopOwner.Country')),
                              leading: SvgPicture.asset(
                                'assets/svg/changecountry.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangeCountryPage())),
                            ),
                            ListTile(
                              title: Text(lang.tr('shopOwner.notifications')),
                              leading: SvgPicture.asset(
                                'assets/svg/notification.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          NotificationSettingsPage())),
                            ),
                            ListTile(
                              title: Text(lang.tr('shopOwner.legal')),
                              leading: SvgPicture.asset(
                                'assets/svg/Legal&About.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => LegalAboutPage())),
                            ),
                            ListTile(
                              title: Text(lang.tr('shopOwner.aboutus')),
                              leading: SvgPicture.asset(
                                'assets/svg/about-us.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () {},
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                lang.tr('shopOwner.account'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text(lang.tr('shopOwner.Password')),
                              leading: SvgPicture.asset(
                                'assets/svg/changepassword.svg',
                                width: 30,
                                height: 30,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => ChangePasswordPage())),
                            ),
                            ListTile(
                                title: Text(lang.tr('shopOwner.signout')),
                                leading: SvgPicture.asset(
                                  'assets/svg/logout.svg',
                                  width: 30,
                                  height: 30,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onTap: () {
                                  logoutUser(context);
                                }),
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
