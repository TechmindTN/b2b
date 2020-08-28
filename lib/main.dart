import 'dart:ui' as ui;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/providers/LoginProvider.dart';
import 'package:siyou_b2b/providers/ProductProvider.dart';
import 'package:siyou_b2b/screens/login/LoginPage.dart';
import 'package:siyou_b2b/screens/login/LoginScreen.dart';
import 'package:siyou_b2b/screens/login/Onbording.dart';
import 'package:siyou_b2b/screens/supplierSpace/SupplierNotificationScreen.dart';

import 'package:siyou_b2b/screens/supplierSpace/home/SupplierHomeScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/orders/OrdersScreen.dart';
import 'package:siyou_b2b/screens/supplierSpace/profile/MyProfile.dart';

import 'mapp.dart';
import 'models/Theme.dart';
import 'providers/HomeProvider.dart';
import 'screens/SalesManager/home/SupplierHomeScreen.dart';
import 'screens/Shopowner/Screens/orders/OrdersScreen.dart';
import 'screens/Shopowner/src/pages/online.dart';
import 'screens/supplierSpace/catalogues/ProductScreen.dart';

void main() => runApp(EasyLocalization(child: MyApp()));

class MyApp extends StatelessWidget {
  static const list = [
    Locale('en', 'US'),
    Locale('it', 'IT'),
    //Locale('es', 'ES'),
    //Locale('fr', 'FR'),
    Locale('zh', 'CN'),
    //Locale('de', 'DE')
  ];

  static final ownerRoutes = {
    /*"/owner/home": (_) => LanguageProvider(
      child: OwnerHomeScreen(),
    ),*/
    "/owner/orders": (_) => LanguageProvider(
          child: OrdersScreen(),
        ),
    "/owner/home": (_) => LanguageProvider(
          child: Online(),
        ),
    "//": (_) => LanguageProvider(
          child: MainScreen(),
        ),
  };
//ManagerHomeScreen
  static final supplierRoutes = {
    "/supplier/home": (_) => LanguageProvider(
          child: SupplierHomeScreen(),
        ),
         "/manager/home": (_) => LanguageProvider(
          child: ManagerHomeScreen(),
        ),
    
        "/supplier/ProductList": (_) => LanguageProvider(
          child: ProductsListSScreen(),
        ),
    /*"/supplier/myCatalogues": (_) => LanguageProvider(
          child: MyCatalogues(),
        ),*/
    "/supplier/notification": (_) => LanguageProvider(
          child: SupplierNotificationScreen(),
        ),
    "/supplier/supplierOrders": (_) => LanguageProvider(
          child: SuppOrdersScreen(),
        ),
    "/supplier/myProfile": (_) => LanguageProvider(
          child: MyProfile(),
        ),
  };

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    Locale locale = MyApp.list.indexOf(ui.window.locale) != -1
        ? ui.window.locale
        : Locale('en', 'US');
        SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return EasyLocalizationProvider(
        data: data,
        child: DynamicTheme(
            defaultBrightness: Brightness.light,
            data: (brightness) => MyThemes.themes[1],
            themedWidgetBuilder: (context, theme) {
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) =>
                          LoginProvider(), //builder: (BuildContext context) {},
                    ),
                    ChangeNotifierProvider(
                      create: (_) => CartProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => ProductListProvider(),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => HomeProvider(),
                    )
                  ],
                  child: MaterialApp(
                    title: 'Siyou B2B',
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      //app-specific localization
                      EasylocaLizationDelegate(
                          locale: locale, path: 'assets/langs'),
                    ],
                    supportedLocales: MyApp.list,
                    locale:
                        data.savedLocale == null ? locale : data.savedLocale,
                    debugShowCheckedModeBanner: false,
                    theme: MyThemes.themes[0],
                    initialRoute: "//",
                    routes: {
                      "/": (_) => LanguageProvider(
                            child: LogInScreen(),
                          ),
                      "/login": (_) => LanguageProvider(
                            child: LoginPage(),
                          ),
                     /* '/onboarding': (_) =>
                          LanguageProvider(child: OnboardingScreen()),*/
                      ...ownerRoutes,
                      ...supplierRoutes
                    },
                  ));
            }));
  }
}

class LanguageProvider extends StatelessWidget {
  final Widget child;

  const LanguageProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: child,
    );
  }
}
