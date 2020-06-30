import 'dart:convert';
import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/models/Product.dart';
import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/models/User.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/services.dart';

class HomeProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();
  final List<Items> lastadded = List<Items>();
  final List<Items> discounts = List<Items>();
  final List<Items> purchased = List<Items>();
  final List<Items> supplierlastadded = List<Items>();
  final List<Items> supplierdiscounts = List<Items>();
  final List<Items> supplierpurchased = List<Items>();
  final List<Items> searchitem = List<Items>();
  final List<Product> products = List<Product>();
  final List<Suppliers> suppliers = List<Suppliers>();
  final List<Suppliers> searchsuppliers = List<Suppliers>();
  final List<Categories> categories = List<Categories>();
  final List<UserProfil> shops = List<UserProfil>();
  final List<UserProfil> managers = List<UserProfil>();
  final List<UserProfil> managersuppliers = List<UserProfil>();
  final List<UserProfil> managershops = List<UserProfil>();
  final List<Product> managerproducts = List<Product>();

  UserProfil user = UserProfil();
  Position lastKnownPosition;
  Position currentPosition;

  int page = 1;
  bool error = false;
  bool loading = true;
  String errorMsg = "";

  Future<void> resetList(BuildContext context,
      {int supplierid, int brand, int category}) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    discounts.clear();
    lastadded.clear();
    purchased.clear();

    await getdiscounts(context, supplierid: supplierid, category: category);
    await getnewarrivals(context, id: supplierid, categoryid: category);
    await getpurchased(context, id: supplierid, category: category);
    notify();
  }

  Future<void> resetDiscount(BuildContext context,
      {int supplierid, int brand, int category}) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    discounts.clear();
    notify();

    await getdiscounts(context, supplierid: supplierid, category: category);
  }

  Future<void> resetsupp(BuildContext context,
      {int supplierid, int brand, int category}) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    suppliers.clear();

    notify();

    await getSuppliers(context);
  }

  getUserinfo() async {
    var u = await getUserInfo();
    if (u != null) {
      user = UserProfil.fromJson(json.decode(u)['user']);
      loading = false;
    }
  }

  getSuppliers(BuildContext context) async {
    try {
      loading = true;
      await _initLastKnownLocation(context);
      await _initCurrentLocation();

      final data = await _api.getSuppliers();

      if (checkServerResponse(data, context)) {
        final List<Suppliers> s = data["suppliers"]
            .map<Suppliers>((item) => Suppliers.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          suppliers.clear();
          for (var x in s) {
            if (lastKnownPosition == null) {
              x.distance = calculateDistance(
                      currentPosition.latitude,
                      currentPosition.longitude,
                      double.parse(x.latitude),
                      double.parse(x.longitude))
                  .toStringAsFixed(0);
            } else
              x.distance = calculateDistance(
                      lastKnownPosition.latitude,
                      lastKnownPosition.longitude,
                      double.parse(x.latitude),
                      double.parse(x.longitude))
                  .toStringAsFixed(0);

            if (suppliers.contains(x) == false) suppliers.add(x);
          }
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

  searchItems(BuildContext context, keyword) async {
    try {
      loading = true;
      final data = await _api.searchProductItems(barcode: keyword);

      if (checkServerResponse(data, context)) {
        final List<Items> s =
            data["items"].map<Items>((item) => Items.fromJson(item)).toList();
        if (s != null && s.isNotEmpty) {
          searchitem.clear();
          for (var x in s) {
            if (suppliers.contains(x) == false) searchitem.add(x);
          }
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

  searchSuppliers(BuildContext context, keyword) async {
    try {
      loading = true;
      await _initLastKnownLocation(context);
      await _initCurrentLocation();

      final data = await _api.searchSuppliers(keyword);

      if (checkServerResponse(data, context)) {
        final List<Suppliers> s = data["data"]
            .map<Suppliers>((item) => Suppliers.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          searchsuppliers.clear();
          for (var x in s) {
            if (lastKnownPosition == null) {
              x.distance = calculateDistance(
                      currentPosition.latitude,
                      currentPosition.longitude,
                      double.parse(x.latitude),
                      double.parse(x.longitude))
                  .toStringAsFixed(0);
            } else
              x.distance = calculateDistance(
                      lastKnownPosition.latitude,
                      lastKnownPosition.longitude,
                      double.parse(x.latitude),
                      double.parse(x.longitude))
                  .toStringAsFixed(0);

            if (suppliers.contains(x) == false) searchsuppliers.add(x);
          }
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

  getCategories(BuildContext context, id) async {
    try {
      loading = true;
      final data = await _api.getSuppCategorys(id);

      if (data != null) {
        final List<Categories> s = data["categories"]
            .map<Categories>((item) => Categories.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          categories.clear();
          for (var x in s) {
            if (categories.contains(x) == false) categories.add(x);
          }
          // print('toule lista = ' + categories.length.toString());
        }
        loading = false;
        notify();
        return;
      }

      suppliers.clear();
    } catch (e) {
      loading = false;
      notify();
      print(e);
    }
  }

  getShopList(
    BuildContext context,
  ) async {
    try {
      loading = true;
      final data = await _api.getShopList();
      print('wa33333333');

      if (data != null) {
        final List<UserProfil> s = data["shops"]
            .map<UserProfil>((item) => UserProfil.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          shops.clear();
          for (var x in s) {
            if (shops.contains(x) == false) shops.add(x);
          }
        }
        loading = false;
        notify();
        return;
      }

      // suppliers.clear();
    } catch (e) {
      loading = false;
      notify();
      print(e);
    }
  }

  getManagerShopList(
    BuildContext context,
  ) async {
    try {
      loading = true;
      final data = await _api.getManagerShopList();
      print(data);

      if (data != null) {
        final List<UserProfil> s = data["shops"]
            .map<UserProfil>((item) => UserProfil.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          //shops.clear();
          shops.addAll(s);
        }
        loading = false;
        notify();
        return;
      }

      // suppliers.clear();
    } catch (e) {
      loading = false;
      notify();
      print(e);
    }
  }

  getSalesManagerList(
    BuildContext context,
  ) async {
    try {
      loading = true;
      final data = await _api.getSalesManagerList();

      if (data != null) {
        final List<UserProfil> s = data["salesManagers"]
            .map<UserProfil>((item) => UserProfil.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          //categories.clear();
          for (var x in s) {
            if (managers.contains(x) == false) managers.add(x);
          }
        }
        loading = false;
        notify();
        return;
      }

      suppliers.clear();
    } catch (e) {
      loading = false;
      notify();
      print(e);
    }
  }

  getManagerSuppliersrList(
    BuildContext context,
  ) async {
    try {
      loading = true;
      final data = await _api.getSManagerSuppliersList();

      if (data != null) {
        final List<UserProfil> s = data["suppliers"]
            .map<UserProfil>((item) => UserProfil.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          //categories.clear();
          for (var x in s) {
            if (managers.contains(x) == false) managers.add(x);
          }
        }
        loading = false;
        notify();
        return;
      }

      suppliers.clear();
    } catch (e) {
      loading = false;
      notify();
      print(e);
    }
  }

  Future<void> getProducts(BuildContext context, id) async {
    if (discounts.isEmpty) {
      await getdiscounts(context, supplierid: id);
      await getnewarrivals(context, id: id);
      await getpurchased(context, id: id);
      await getCategories(context, id);
    }
  }

  Future<void> getnewarrivals(BuildContext context,
      {int id, int categoryid}) async {
    try {
      loading = true;
      final data =
          await _api.getnewarrivals(supplierid: id, category: categoryid);

      if (checkServerResponse(data, context)) {
        //lastadded.clear();
        final List<Items> prodlist = data["last_added"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        if (prodlist.isNotEmpty && prodlist != null) {
          lastadded.clear();
          lastadded.addAll(prodlist);
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

  Future<void> getdiscounts(BuildContext context,
      {int supplierid, int brand, int category}) async {
    try {
      loading = true;
      final data =
          await _api.getdiscounts(supplierid: supplierid, category: category);
      print(data);

      if (checkServerResponse(data, context)) {
        //lastadded.clear();
        final List<Items> prodlist = data["Discount"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        if (prodlist.isNotEmpty && prodlist != null) {
          discounts.clear();
          discounts.addAll(prodlist);
          //print('discount length'+discounts.length.toString());
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
      print(e);
      if (e.toString() == "No store selected") {
        final lang = AppLocalizations.of(context);
        errorMsg = lang.tr("serverError.store_error");
      } else
        errorMsg = e.toString();
      error = true;
      loading = false;
      notify();
    }

    // loading = false;
    // notify();
    return;
  }

  Future<void> getpurchased(BuildContext context,
      {int id, int category}) async {
    try {
      loading = true;
      final data = await _api.getpurchased(supplierid: id, category: category);

      if (checkServerResponse(data, context)) {
        //lastadded.clear();
        final List<Items> prodlist = data["purchased"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        if (prodlist.isNotEmpty && prodlist != null) {
          //discounts.clear();
          purchased.addAll(prodlist);
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

  Future<void> getSuppProfilItems(
    BuildContext context,
  ) async {
    try {
      loading = true;
      final data = await _api.getSupplierProfilItems();

      if (checkServerResponse(data, context)) {
        final List<Items> prodlist = data["lastAdded"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        final List<Items> prodlist1 = data["discount"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        final List<Items> prodlist2 = data["bestSeller"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        if (prodlist.isNotEmpty && prodlist != null) {
          supplierlastadded.clear();
          supplierlastadded.addAll(prodlist);
        }
        if (prodlist1.isNotEmpty && prodlist1 != null) {
          supplierdiscounts.clear();
          supplierdiscounts.addAll(prodlist1);
        }
        if (prodlist2.isNotEmpty && prodlist2 != null) {
          supplierpurchased.clear();
          supplierpurchased.addAll(prodlist2);
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

  Future<void> getSupplierInfo(BuildContext context) async {
    await getSuppProfilItems(context);
    if (user == null) await getUserinfo();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _initLastKnownLocation(BuildContext context) async {
    Position position;
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();

    try {
      final Geolocator geolocator = Geolocator();

      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
      if (!isLocationEnabled)
        showAlertDialog(context, 'Enable Location Services',
            'Location Services is required in order to use this application');
    } on PlatformException {
      position = null;
    }

    lastKnownPosition = position;
    return;
  }

  _initCurrentLocation() async {
    Position position;
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
  }

  void notify() {
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
