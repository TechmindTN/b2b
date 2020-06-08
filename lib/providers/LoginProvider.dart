import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:siyou_b2b/models/User.dart';
import 'package:siyou_b2b/network/ApiProvider.dart';
import 'package:siyou_b2b/utlis/utils.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginProvider extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  ApiProvider api = ApiProvider();
  //Store _store;

  Status get status => _status;

  //Store get store => _store;

  Future<bool> userSignedIn() async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
     // final String chain = await getSelectedStoreFromPref();
     // final int role = await getUserRole();
     // final String chainId = chain != "0" && role == 2 ? chain : "";
      var x=await getUserToken();
      await getUserPrefsUX();
      if (x!=null&& x!='') {
      
        _status = Status.Authenticated;
        notifyListeners();
        return true;
      }
      throw "eroor";
    } catch (e) {
      await clearPref();
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

   Future<Map<String, dynamic>> signInUser(
      String username, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final data = await api.signInUser(username, password);
           // print(data);

     if (data["user"] != null) {
        final user = User.fromJson(data["user"]);
        //await addCurrentShopToPref(user.storeId);
        //print(user.toString());
        saveUserRole(user.role);
        saveUserid(int.parse(user.userId));
        saveUserToken(data["access_token"]);
       // print(data["access_token"]);
        return {
          "status": true,
          "token": data["access_token"],
          "role": user.role
        };
      } else {
        if (data["msg"] == "1")
          throw "Email or Password are empty !";
        else if (data["msg"] == "2")
          throw "Email & Password does not match any user";
        else
          throw "Internal server error, Please come back later";
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      if (e is DioError) {
        final DioError error = e;
        return {"status": false, "error": error.message};
      } else {
       return {"status": false, "error": e.toString()};
      }
    }
  }

  Future signOutUser() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
