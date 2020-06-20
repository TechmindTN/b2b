import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:siyou_b2b/widgets/cardbutomwidget.dart';

class SupplierHomePage extends StatefulWidget {
  @override
  _SupplierHomeScreenPageState createState() => _SupplierHomeScreenPageState();
}

class _SupplierHomeScreenPageState extends State<SupplierHomePage> {
  AppLocalizations lang;
  @override
  Widget build(BuildContext context) {
     lang = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pushNamed(context, "/supplierProfile"),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                // widget.catalogue['supplierImage'],
                  "https://www.onlinelogomaker.com/blog/wp-content/uploads/2017/06/shopping-online.jpg"),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        title: Text(
          'Siyou Supplier',
          //widget.catalogue['supplierName'],
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        actions: <Widget>[
//          IconButton(
//            onPressed: () => Navigator.pushNamed(context, '/cart'),
//            icon: Icon(Icons.shopping_cart),
//          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/supplier/notification'),
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
                              children: <Widget>[
                                
                    CardButtonsWidget(
                      {'title': lang.tr('homeScreen.myStores')},
                      [
                        {
                          'route': '/supplier/supplierOrders',
                          'svgPath': 'assets/svg/orders_2.svg',
                          'title': lang.tr('homeScreen.orders')
                        },
                        {
                          'route': '/supplier/ProductList',
                          'svgPath': 'assets/svg/products.svg',
                          'title': lang.tr('homeScreen.products')
                        },
                        
                        /* {
                            'route': '/statistics',
                            'svgPath': 'assets/svg/stats_1.svg',
                            'title': lang.tr('homeScreen.statistics')
                          },*/
                        {
                        'route': '/ScreenLable',
                         'svgPath': 'assets/svg/barcode-scanner.svg',
                       'title': lang.tr('scanScreen.print'),
                       },
                      ],
                    ),
                    CardButtonsWidget(
                      {'title': lang.tr('homeScreen.quick')},
                      [
                        /*{
                          'dialog': 'quick-add',
                          'svgPath': 'assets/svg/add_product_1.svg',
                          'title': lang.tr('homeScreen.quick_add')
                        },*/
                        {
                          'route': '/quickZebra',
                          'svgPath': 'assets/svg/quick_code.svg',
                          'title': lang.tr('homeScreen.quick_zebra')
                        },
                        {
                          'route': '/quickDiscount',
                          'svgPath': 'assets/svg/discount.svg',
                          'title': lang.tr('homeScreen.quick_discount')
                        },
                      ],
                    ),
                   // if(userid=='shop'&&userpw=='111111')
                    CardButtonsWidget(
                      {'title': lang.tr('homeScreen.purchase')},
                      [
                        /*{
                          'route': '/underConstruction',
                          'svgPath': 'assets/svg/suppliers_orders.svg',
                          'title': lang.tr('homeScreen.purchaseOrders')
                        },*/
                       
                        {
                          'route': '/sbarcode',
                          'svgPath': 'assets/svg/product_check.svg',
                          'title': lang.tr('homeScreen.checkProduct')
                        },
                        
                        {
                          'route': '/underConstruction',
                          'svgPath': 'assets/svg/inventory.svg',
                          'title': lang.tr('homeScreen.inventoryWarning')
                        },
                        
                      ],
                    ),
                    
                    CardButtonsWidget(
                      {'title': lang.tr('homeScreen.members')},
                      [
                        {
                          'dialog': 'member',
                          'svgPath': 'assets/svg/add_member.svg',
                          'title': lang.tr('homeScreen.increase')
                        },
                        {
                          'route': '/membersListScreen',
                          'svgPath': 'assets/svg/people.svg',
                          'title': lang.tr('homeScreen.list')
                        },
                        /*{
                          'route': '/statisticsMembers',
                          'svgPath': 'assets/svg/stats.svg',
                          'title': lang.tr('homeScreen.statistics')
                        },*/
                      ],
                    ),
                  /*  CardButtonsWidget(
                      {'title': lang.tr('homeScreen.suppliersList')},
                      [
                        /*{
                          'route': '/underConstruction',
                          'svgPath': 'assets/svg/suppliers_orders.svg',
                          'title': lang.tr('homeScreen.purchaseOrders')
                        },*/
                        
                        {
                          'route': '/tempSupListScreen',
                          'svgPath': 'assets/svg/truck.svg',
                          'title': lang.tr('homeScreen.platformsuppliers')
                        },
                         {
                          'route': '/SupListScreen',
                          'svgPath': 'assets/svg/truck.svg',
                          'title': lang.tr('homeScreen.mysuppliers')
                        },
                        
                      ],
                    ),*/
                  ],
                ),
        ),
      ),
    );
  }
  Widget _generateRow(Map map1, Map map2) {
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;
    final double textSize = width > 600 ? 24 : width >= 400 ? 20 : 18;

    return SizedBox(
      height: 80.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          map1['title'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        flex: 1),
                    Expanded(
                        child: Center(
                          child: Text(
                            map1['sale'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.accentColor,
                              fontSize: textSize,
                            ),
                          ),
                        ),
                        flex: 2),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          map2['title'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        flex: 1),
                    Expanded(
                        child: Center(
                          child: Text(
                            map2['sale'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.accentColor,
                              fontSize: textSize,
                            ),
                          ),
                        ),
                        flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
