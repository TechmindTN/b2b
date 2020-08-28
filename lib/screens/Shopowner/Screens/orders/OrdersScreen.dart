import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siyou_b2b/providers/CartProvider.dart';
import 'package:siyou_b2b/widgets/appprop.dart';
import 'ArchivedOrders.dart';
import 'OrdersStatus.dart';
import 'PaidOrders.dart';

import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrdersScreen> {
  DateTime selectedDate;
  CartProvider _orderProvide;

  @override
  void initState() {
    super.initState();
    _orderProvide = Provider.of<CartProvider>(context, listen: false);
    _orderProvide?.getOrders(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations lang = AppLocalizations.of(context);
    final date = DateTime.now();
    // selectedDate = date;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0), // here the desired height
            child: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: <Widget>[
                  Text(lang.tr('shopOwner.orders'),
                      style: TextStyle(color: darkGrey)),
                  if (selectedDate != null)
                    Text('  ' + selectedDate.toString().substring(0, 10),
                        style: TextStyle(color: darkGrey)),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime newDateTime = await showRoundedDatePicker(
                            context: context,
                            theme: ThemeData.dark(),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 5),
                            lastDate: DateTime.now(),
                            locale: lang.locale);
                        if (newDateTime != null) {
                          setState(() {
                            selectedDate = newDateTime;
                          });
                          _orderProvide.resetshoopOrders(context,
                              date: newDateTime);
                        }
                      })
                ],
              ),
              bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lang.tr('shopOwner.invalid'),
                      style: TextStyle(fontSize: 14.0, color: darkGrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lang.tr('shopOwner.valid'),
                      style: TextStyle(fontSize: 14.0, color: darkGrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lang.tr('shopOwner.paid'),
                      style: TextStyle(fontSize: 14.0, color: darkGrey),
                    ),
                  )
                ],
              ),
            )),
        body: TabBarView(
          children: <Widget>[OrdersStatus(), ArchivedOrders(), PaidOrders()],
        ),
      ),
    );
  }

  /* Widget datepickerIOS() {
    return DatePickerWidget(
      looping: false, // default is not looping
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      onChange: (DateTime newDate, _) => selectedDate = newDate,
      pickerTheme: DateTimePickerTheme(
          itemTextStyle: TextStyle(color: Colors.black, fontSize: 19)),
    );
  }

  void _datepickerModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, setState) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          datepickerIOS(),
                          SizedBox(
                            height: 12,
                          ),
                          FlatButton(
                            color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                              _orderProvide.resetshoopOrders(context,
                                  date: selectedDate);
                            },
                            child: Text(
                              'Filter',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        });
  }*/
}
