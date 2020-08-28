import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:siyou_b2b/models/Categorys.dart';
import 'package:siyou_b2b/models/Product.dart';
import 'package:siyou_b2b/models/Productitems.dart';
import 'package:siyou_b2b/models/brands.dart';
import 'package:siyou_b2b/models/suppliers.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';

class ProductListProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();
  final List<Product> products = List<Product>();

  final List<Productitems> supplierproducts = List<Productitems>();
  final List<Product> wishlist = List<Product>();
  final List<Items> itmes = List<Items>();
  final List<Suppliers> suppliers = List<Suppliers>();
  final List<Categories> categories = List<Categories>();
  final List<Brands> brands = List<Brands>();

  Future<Map<String, dynamic>> _future;

//  Future<Map<String, dynamic>> _future;

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
    products.clear();

    notify();

    await getProducts(context,
        supplierid: supplierid, category: category, brand: brand);
  }

  Future<void> resetSList(BuildContext context,
      {int supplierid, int brand, int category}) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    products.clear();
    notify();

    await getSupplierProducts(context, category: category);
  }

  Future<void> resetMList(BuildContext context,
      {int supplierid, int brand, int category}) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    products.clear();
    notify();

    await getManagerProducts(context, category: category, brand: brand);
  }

  Future<void> getProducts(BuildContext context,
      {int supplierid, int brand, int category}) async {
    if (page != -1) {
      loading = true;
      try {
        final data = await _api.getProducts(
          page: page,
          supplierid: supplierid,
          category: category,
          brand: brand,
        );

        if (checkServerResponse(data, context)) {
          final List<Product> prodlist = data["data"]
              .map<Product>((item) => Product.fromJson(item))
              .toList();
          final _total = data["last_page"];
          print("total Pages: $_total");
          page = page + 1 <= _total ? page + 1 : -1;
          if (prodlist != null) products.addAll(prodlist);
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
    }
    loading = false;
    notify();
    return;
  }

  Future<void> getSupplierProducts(BuildContext context,
      {int brand, int category}) async {
    if (page != -1) {
      try {
        final data = await _api.getSupplierProducts(
            page: page, category: category, brand: brand);
        print(data);
        if (checkServerResponse(data, context)) {
          final List<Product> prodlist = data["data"]
              .map<Product>((item) => Product.fromJson(item))
              .toList();
          final _total = data["last_page"];
          print("total Pages: $_total");
          page = page + 1 <= _total ? page + 1 : -1;
          if (prodlist != null) products.addAll(prodlist);
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
    }
    loading = false;
    notify();
    return;
  }

  Future<void> getManagerProducts(BuildContext context,
      {int supplierid, int brand, int category}) async {
    if (page != -1) {
      try {
        final data = await _api.getManagerProducts(
            page: page,
            supplierid: supplierid,
            category: category,
            brand: brand);

        if (checkServerResponse(data, context)) {
          final List<Product> prodlist = data["data"]
              .map<Product>((item) => Product.fromJson(item))
              .toList();
          final _total = data["last_page"];
          print("total Pages: $_total");
          page = page + 1 <= _total ? page + 1 : -1;
          if (prodlist != null) products.addAll(prodlist);
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
    }
    loading = false;
    notify();
    return;
  }

  Future<void> resetWishList(BuildContext context) async {
    page = 1;
    loading = true;
    error = false;
    errorMsg = "";
    wishlist.clear();

    await getWishList(context);
    notify();
  }

  Future<void> getWishList(BuildContext context) async {
    loading = true;
    try {
      final data = await _api.getWishList();

      if (data != null) {
        final List<Product> prodlist = data["wishList"]
            .map<Product>((item) => Product.fromJson(item))
            .toList();
        if (prodlist != null) {
          wishlist.clear();
          wishlist.addAll(prodlist);
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

  Future<void> getItems(BuildContext context, {int id}) async {
    if (page != -1) {
      try {
        _future = _api.getProductItems(
          id: id,
        );
        final data = await _future;
        if (data != null) {
          final List<Items> proItems =
              data["items"].map<Items>((item) => Items.fromJson(item)).toList();

          if (proItems != null && proItems.isNotEmpty) {
            itmes.clear();
            itmes.addAll(proItems);
          }
          loading = false;
          notifyListeners();
          return;
        } else {
          errorMsg = getServerErrorMsg(data, context);
          error = true;
          loading = false;
          notifyListeners();
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
        notifyListeners();
      }
    }
    loading = false;
    notifyListeners();
    return;
  }

  getSuppliers(BuildContext context) async {
    try {
      final data = await _api.getSuppliers();

      if (data != null) {
        final List<Suppliers> s = data["suppliers"]
            .map<Suppliers>((item) => Suppliers.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          suppliers.clear();
          for (var x in s) {
            if (suppliers.contains(x) == false) suppliers.add(x);
          }
          print('toule lista = ' + suppliers.length.toString());
        }
        return;
      }

      suppliers.clear();
    } catch (e) {
      print(e);
    }
  }

  getCategories(BuildContext context) async {
    try {
      loading = true;
      final data = await _api.getCategorys();

      if (data != null) {
        final List<Categories> s = data["categories"]
            .map<Categories>((item) => Categories.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          categories.clear();
          for (var x in s) {
            if (categories.contains(x) == false) categories.add(x);
          }
          print('toule lista = ' + categories.length.toString());
        }
        loading = false;
        notifyListeners();
        return;
      }
    } catch (e) {
      print(e);
      loading = false;
      error = true;
      errorMsg = e.toString();
    }
  }

  getBrands(BuildContext context) async {
    try {
      loading = true;
      final data = await _api.getBrands();

      if (data != null) {
        final List<Brands> s = data["brands"]
            .map<Brands>((item) => Brands.fromJson(item))
            .toList();
        if (s != null && s.isNotEmpty) {
          brands.clear();
          for (var x in s) {
            if (brands.contains(x) == false) brands.add(x);
          }
          print('toule lista = ' + brands.length.toString());
        }
        loading = false;
        notify();
        return;
      }
    } catch (e) {
      print(e);
      error = true;
      errorMsg = e.toString();
      loading = false;
    }
  }

  Future<void> getLists(BuildContext context) async {
    //await getSuppliers(context);
    await getCategories(context);
    //await getBrands(context);

    notify();
  }

  void notify() {
    try {
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
