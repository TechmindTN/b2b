import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:siyou_b2b/models/OrderList.dart';
import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/models/order.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';

class CartProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();
  final List<Items> itmes = [];
  final List<Order> orders = [];
  final List<int> supplist = [];
  final List<OrderList> invalidorders = [];
  final List<OrderList> vaildorders = [];
  final List<OrderList> paidorders = [];
  final List<OrderList> suppinvalidorders = [];
  final List<OrderList> suppvaildorders = [];
  final List<OrderList> supppaidorders = [];
  final List<OrderList> managerinvalidorders = [];
  final List<OrderList> managervaildorders = [];
  final List<OrderList> manageraidorders = [];
  //final List<PaymentList> paymentlist=[];
  num total = 0.0;
  bool error = false;
  bool loading = true;
  String errorMsg = "";

  Future<void> resetshoopOrders(BuildContext context) async {
    loading = true;
    error = false;
    errorMsg = "";
    invalidorders.clear();
    vaildorders.clear();
    paidorders.clear();
    await getOrders(context);
    notify();
  }

  bool check(Items item) {
    bool t = false;
    for (var x in itmes) {
      if (x.itemBarcode == item.itemBarcode) {
        t = true;
        break;
      }
    }
    return t;
  }

  int getIndex(Items item) {
    int x;
    for (var i = 0; i < itmes.length; i++) {
      if (itmes[i].id == item.id) {
        x = i;
        break;
      }
    }
    print('x= ' + x.toString());
    return x;
  }

  int checkinCart(Items itemcart) {
    int check = -1;
    if (itmes.isNotEmpty)
      check = itmes.indexWhere((item) => item.id == itemcart.id);
    return check;
  }

  searchItems(BuildContext context, keyword) async {
    try {
      loading = true;
      final data = await _api.searchProductItems(barcode: keyword);
      if (checkServerResponse(data, context)) {
        final List<Items> s =
            data["items"].map<Items>((item) => Items.fromJson(item)).toList();
        if (s != null && s.isNotEmpty) {
          print('supplierid  ' + s[0].product.supplierId.toString());
          addCartItems(s[0], s[0].itemPackage, s[0].product.supplierId,
              s[0].product.supplier);
        }
        loading = false;
        notify();
        return;
      } else {
        errorMsg = getServerErrorMsg(data, context);
        error = true;
        loading = false;
        notify();
        return;
      }

      // suppliers.clear();
    } catch (e) {
      print(e);
    }
  }

  void addCartItems(
      Items item, int quantity, int supplieridd, Suppliers supplier) {
    try {
      var i = item;

      i.supplierid = supplieridd;
      i.supplier = supplier;

      if (itmes.isNotEmpty && itmes != null) {
        if (check(i)) {
          itmes[getIndex(i)].quantity += quantity;
          total += i.itemDiscountPrice == null
              ? i.itemOfflinePrice * quantity
              : i.itemDiscountPrice * quantity;
        } else {
          total += i.itemDiscountPrice == null
              ? i.itemOfflinePrice * quantity
              : i.itemDiscountPrice * quantity;
          i.quantity = quantity;
          itmes.add(i);
        }
      } else {
        total += i.itemDiscountPrice == null
            ? i.itemOfflinePrice * quantity
            : i.itemDiscountPrice * quantity;

        i.quantity = quantity;
        print(total);
        itmes.add(i);
      }

      notify();

      return;
    } catch (e) {
      print(e.toString());
    }
  }

  void removeCartItem(Items item) {
    int index = getIndex(item);
    if (itmes[index].quantity == itmes[index].itemPackage) {
      total -= itmes[index].itemDiscountPrice == null
          ? itmes[index].itemOfflinePrice * itmes[index].quantity
          : itmes[index].itemDiscountPrice * itmes[index].quantity;
      itmes[index].quantity = 0;

      itmes.removeAt(index);
      notify();
    } else {
      total -= itmes[index].itemDiscountPrice == null
          ? itmes[index].itemOfflinePrice * itmes[index].quantity
          : itmes[index].itemDiscountPrice * itmes[index].quantity;
      itmes[index].quantity -= itmes[index].itemPackage;
      notify();
    }
  }

  void checkout() {
    final basketitem = itmes;
    if (basketitem != null && basketitem.isNotEmpty) {
      basketitem.forEach((v) {
        var x = checkorders(v);
        if (x > -1) {
          var pl = Productlist.fromJson(v.toMap());
          var x1 = checkorder(pl, x);
          if (x1 > -1) {
            /*orders[x].orderProductsList[x1].itemQuantity=v.itemQuantity;
            orders[x].orderWeight=orders[x].orderWeight-orders[x].orderProductsList[x1].itemweight;
            orders[x].orderWeight+=double.parse(v.criteriaBase[0].pivot.criteriaValue) * v.quantity;*/
            print("condition 1.0 ");
          } else {
            orders[x].orderTotalPrice += v.itemDiscountPrice == null
                ? v.itemOfflinePrice * v.quantity
                : v.itemDiscountPrice * v.quantity;
            orders[x].orderWeight += 10.00;
            // double.parse(v.criteriaBase[0].pivot.criteriaValue) *
            // v.quantity;
            orders[x].orderProductsList.add(pl);
            print("condition 1.1 ");
          }
        } else {
          var o = new Order();

          o.orderProductsList = [];
          o.orderProductsList.add(Productlist.fromJson(v.toMap()));
          o.supplierId = v.supplierid;
          o.supplier = v.supplier == null ? v.product.supplier : v.supplier;
          o.orderTotalPrice = v.itemDiscountPrice == null
              ? v.itemOfflinePrice * v.quantity
              : v.itemDiscountPrice * v.quantity;
          o.orderWeight = 10.00;
          // double.parse(v.criteriaBase[0].pivot.criteriaValue) * v.quantity;
          o.logisticCompanyId = 2;
          o.logisticTarif = 0;

          orders.add(o);
          print('Condition 2 ');
        }
      });
    }
    print(orders.toString());
  }

  int checkorder(Productlist pl, int x) {
    int t = -1;

    for (var i = 0; i < orders[x].orderProductsList.length; i++) {
      if (orders[x].orderProductsList[i].itemId == pl.itemId) {
        t = i;
        break;
      }
    }
    return t;
  }

  int checkorders(Items item) {
    int t = -1;
    if (orders.isNotEmpty) {
      for (var i = 0; i < orders.length; i++) {
        if (orders[i].supplierId == item.supplierid) {
          t = i;
          break;
        }
      }
    }
    return t;
  }

  Future<void> getOrders(BuildContext context) async {
    try {
      final data = await _api.getOrders();

      if (checkServerResponse(data, context)) {
        final List<OrderList> invalid = data["invalid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> vaild = data["valid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> paid = data["paid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();

        if (invalid != null) invalidorders.addAll(invalid);
        if (vaild != null) vaildorders.addAll(vaild);
        if (paid != null) paidorders.addAll(paid);

        loading = false;
        notify();
        return;
      } else {
        errorMsg = getServerErrorMsg(data, context);
        error = true;
        loading = false;
        notify();
        return;
      }
    } catch (e) {
      if (e.toString() == "No store selected") {
        final lang = AppLocalizations.of(context);
        errorMsg = lang.tr("serverError.store_error");
      } else
        errorMsg = e.toString();
      error = true;
      loading = false;
      notify();
    }

    loading = false;
    notify();
    return;
  }

  Future<void> resetList(BuildContext context) async {
    loading = true;
    error = false;
    errorMsg = "";
    suppinvalidorders.clear();
    suppvaildorders.clear();
    supppaidorders.clear();

    await getSupplierOrders(
      context,
    );

    notify();
  }

  Future<void> getSupplierOrders(BuildContext context) async {
    try {
      final data = await _api.getSupplierOrders();

      if (checkServerResponse(data, context)) {
        final List<OrderList> invalid = data["invalid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> vaild = data["valid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> paid = data["paid"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();

        if (invalid != null) {
          suppinvalidorders.clear();
          suppinvalidorders.addAll(invalid);
        }
        if (vaild != null) {
          suppvaildorders.clear();
          suppvaildorders.addAll(vaild);
        }
        if (paid != null) {
          supppaidorders.clear();
          supppaidorders.addAll(paid);
        }

        loading = false;
        notify();
        return;
      } else {
        errorMsg = getServerErrorMsg(data, context);
        error = true;
        loading = false;
        notify();
        return;
      }
    } catch (e) {
      if (e.toString() == "No store selected") {
        final lang = AppLocalizations.of(context);
        errorMsg = lang.tr("serverError.store_error");
      } else
        errorMsg = e.toString();
      error = true;
      loading = false;
      notify();
    }

    loading = false;
    notify();
    return;
  }

  Future<void> getManagerOrders(BuildContext context) async {
    try {
      final data = await _api.getManagerOrders();

      if (checkServerResponse(data, context)) {
        final List<OrderList> invalid = data["invalid_order"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> vaild = data["valid_order"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();
        final List<OrderList> paid = data["paid_order"]
            .map<OrderList>((item) => OrderList.fromJson(item))
            .toList();

        if (invalid != null) suppinvalidorders.addAll(invalid);
        if (vaild != null) suppvaildorders.addAll(vaild);
        if (paid != null) supppaidorders.addAll(paid);

        loading = false;
        notify();
        return;
      } else {
        errorMsg = getServerErrorMsg(data, context);
        error = true;
        loading = false;
        notify();
        return;
      }
    } catch (e) {
      if (e.toString() == "No store selected") {
        final lang = AppLocalizations.of(context);
        errorMsg = lang.tr("serverError.store_error");
      } else
        errorMsg = e.toString();
      error = true;
      loading = false;
      notify();
    }

    loading = false;
    notify();
    return;
  }

  /*Future<void> getPaymentList(BuildContext context) async {
    try {
      final data = await _api.getPaymentList();

      if (checkServerResponse(data, context)) {
        final List<PaymentList> payment = data["paymentList"]
            .map<PaymentList>((item) => PaymentList.fromJson(item))
            .toList();
            if(payment!=null && payment.isNotEmpty)
            {
              paymentlist.clear();
              paymentlist.addAll(payment);
            }
            
       

        

        loading = false;
        notify();
        return;
      } else {
        errorMsg = getServerErrorMsg(data, context);
        error = true;
        loading = false;
        notify();
        return;
      }
    } catch (e) {
      if (e.toString() == "No store selected") {
        final lang = AppLocalizations.of(context);
        errorMsg = lang.tr("serverError.store_error");
      } else
        errorMsg = e.toString();
      error = true;
      loading = false;
      notify();
    }

    loading = false;
    notify();
    return;
  }*/

  void notify() {
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
