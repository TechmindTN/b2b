import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/models/Product.dart';
import 'package:siyou_b2b/models/Productitems.dart';
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
  final List<Product> products = List<Product>();
  final List<Suppliers> suppliers = List<Suppliers>();
  final List<Suppliers> searchsuppliers = List<Suppliers>();
  final List<Categories> categories = List<Categories>();

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
    lastadded.clear();
    discounts.clear();
    notify();

    await getnewarrivals(context, supplierid);
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

  getSuppliers(BuildContext context) async {
    try {
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

  searchSuppliers(BuildContext context, keyword) async {
    try {
      await _initLastKnownLocation(context);
      await _initCurrentLocation();
      loading = true;
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
          //categories.clear();
          for (var x in s) {
            if (categories.contains(x) == false) categories.add(x);
          }
          print('toule lista = ' + categories.length.toString());
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
    await getdiscounts(context, supplierid: id);
    await getnewarrivals(context, id);
    await getpurchased(context, id);
    await getCategories(context, id);
  }

  Future<void> getnewarrivals(BuildContext context, id) async {
    try {
      loading = true;
      final data = await _api.getnewarrivals(supplierid: id);

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

      if (checkServerResponse(data, context)) {
        //lastadded.clear();
        final List<Items> prodlist = data["Discount"]
            .map<Items>((item) => Items.fromJson(item))
            .toList();
        if (prodlist.isNotEmpty && prodlist != null) {
          //discounts.clear();
          discounts.addAll(prodlist);
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

    // loading = false;
    // notify();
    return;
  }

  Future<void> getpurchased(BuildContext context, id) async {
    try {
      loading = true;
      final data = await _api.getpurchased(supplierid: id);

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
