import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:siyou_b2b/utlis/utils.dart';

class ApiProvider {
  // API base config

  static final String baseUrl = "https://siyou.tn/b2s/";
  static final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
      method: 'GET',
      contentType: Headers.jsonContentType);

  static final Dio dio = new Dio(options);

  /*
  * User APis
  */
  Future<Map<String, dynamic>> signInUser(
      String username, String password) async {
    Map data = {'email': username, 'password': password};
    try {
      final res = await dio.request("/login",
          options: Options(method: "POST"), data: data);

      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getHomePageProducts() async {
    final String token = await getUserToken();
    //Map data = {'supplier_id': supplierid, "page": page};

    try {
      final res = await dio.request(
        "products/home/page",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getProducts(
      {@required int page, int supplierid, int brand, int category}) async {
    final String token = await getUserToken();
    //Map data = {'supplier_id': supplierid, "page": page};

    try {
      final res = await dio.request(
        "/products/shop/list",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
          "page": page
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSupplierProducts(
      {@required int page, int brand, int category}) async {
    final String token = await getUserToken();
    final int supplierid = await getUserid();
    //Map data = {'supplier_id': supplierid, "page": page};

    try {
      final res = await dio.request(
        "/products/productList",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
          "page": page
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getManagerProducts(
      {@required int page, int supplierid, int brand, int category}) async {
    final String token = await getUserToken();
    // final int supplierid = await getUserid();
    //Map data = {'supplier_id': supplierid, "page": page};

    try {
      final res = await dio.request(
        "/products/salesmanager",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
          "page": page
        },
      );

      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSupplierProfilItems() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/profil",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getShopList() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/dashboard/shops",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getManagerShopList() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/salesmanager/shops",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getPaymentList() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/payment/list",
        queryParameters: {
          "token": token,
        },
      );
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSalesManagerList() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/supplier/salesmanager",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSManagerSuppliersList() async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/salesmanager/suppliers",
        queryParameters: {
          "token": token,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getnewarrivals(
      {/*@required int page*/ int supplierid, int brand, int category}) async {
    final String token = await getUserToken();
    //Map data = {'supplier_id': supplierid, "page": page};

    try {
      final res = await dio.request(
        "/products/newArrival",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getdiscounts(
      {/*@required int page*/ int supplierid, int brand, int category}) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/promotion",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getpurchased(
      {/*@required int page*/ int supplierid, int brand, int category}) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/products/purchased",
        queryParameters: {
          "token": token,
          "supplier_id": supplierid,
          "category_id": category,
          "brand_id": brand,
        },
        //data: data
      );
      //print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getOrders() async {
    final String token = await getUserToken();

    try {
      final res =
          await dio.request("/orders/shop", queryParameters: {"token": token});

      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSupplierOrders() async {
    final String token = await getUserToken();

    try {
      final res = await dio
          .request("/orders/supplier", queryParameters: {"token": token});

      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getManagerOrders() async {
    final String token = await getUserToken();

    try {
      final res = await dio
          .request("/orders/salesmanager", queryParameters: {"token": token});

      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getWishList() async {
    final String token = await getUserToken();

    try {
      final res = await dio
          .request("/products/wish/list", queryParameters: {"token": token});
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> addWishList(productid) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/products/favorit",
        options: Options(method: "POST"),
        queryParameters: {"token": token, "product_id": productid},
      );
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> confirmRejectOrder(orderid, status) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request(
        "/orders/$orderid",
        options: Options(method: "PUT"),
        queryParameters: {"token": token, "status": status},
      );
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getProductItems({
    @required int id,
  }) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request("/products", queryParameters: {
        "token": token,
        "product_id": id,
      });
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> searchProductItems({
    @required String barcode,
  }) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request("/products/search/item", queryParameters: {
        "token": token,
        "barcode": barcode,
      });
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> searchSuppliers(keyword) async {
    final String token = await getUserToken();
    try {
      final res = await dio.request("/users/search",
          queryParameters: {"token": token, "key_word": keyword});
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSuppliers() async {
    final String token = await getUserToken();
    try {
      final res =
          await dio.request("/products/suppliers/list", queryParameters: {
        "token": token,
      });
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getBrands() async {
    final String token = await getUserToken();
    try {
      final res = await dio.request("/Brand/All", queryParameters: {
        "token": token,
      });
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getCategorys() async {
    final String token = await getUserToken();
    try {
      final res = await dio.request("/categories/list", queryParameters: {
        "token": token,
      });
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> getSuppCategorys(suppid) async {
    final String token = await getUserToken();
    try {
      final res =
          await dio.request("/categories/supplier/$suppid", queryParameters: {
        "token": token,
      });
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }

  Future<Map<String, dynamic>> addOrder(data) async {
    final String token = await getUserToken();

    try {
      final res = await dio.request("/orders",
          options: Options(method: "POST"),
          queryParameters: {
            "token": token,
          },
          data: data);
      print(res.data);
      return res.data;
    } catch (e) {
      print(e);
      return throw "Error - $e";
    }
  }
}
