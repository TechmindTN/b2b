class User {
  String userId;
  String userAccount;
  String userNickname;
  String userState;
  int role;
  String chainId;
  String storeId;
  String token;

  User(
      {this.userId,
      this.userAccount,
      this.userNickname,
      this.userState,
      this.role,
      this.chainId,
      this.storeId,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['id'].toString();
    userAccount = json['last_name'];
    userNickname = json['first_name'];
    userState = json['activated_account'].toString();
    role = json['role_id'];
    chainId = json['chain_id']??"";
    storeId = json['store_id'].toString();
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_account'] = this.userAccount;
    data['user_nickname'] = this.userNickname;
    data['user_state'] = this.userState;
    data['role'] = this.role;
    data['chain_id'] = this.chainId;
    data['store_id'] = this.storeId;
    data['token'] = this.token;
    return data;
  }

  bool isSupplier() => role == 2;

  bool isManager() => role == 1;

  bool isOwner() => role == 3;

  bool isWarehouseManager() => role == 4;

}
class UserProfil {
  String userId;
  String userAccount;
  String userNickname;
  String discription;
  String avatar;
  String phonenum1;
  String phonenum2;
  String taxnumber;
  String adress;
  String region;
  String country;
  String postcode;
  String lat;
  String long;
  String userState;
  int role;
  String chainId;
  String storeId;
  String token;

  UserProfil(
      {this.userId,
      this.userAccount,
      this.userNickname,
      this.discription,
      this.avatar,
      this.phonenum1,
      this.phonenum2,
      this.taxnumber,
      this.adress,
      this.region,
      this.country,
      this.postcode,
      this.lat,
      this.long,
      this.userState,
      this.role,
      this.chainId,
      this.storeId,
      this.token});

  UserProfil.fromJson(Map<String, dynamic> json) {
    userId = json['id'].toString();
    userAccount = json['last_name'];
    userNickname = json['first_name'];
    discription=json['description'];
    avatar=json['img_url'];
    phonenum1=json['phone_num1'].toString();
    phonenum2=json['phone_num2'].toString();
    taxnumber=json['tax_number'].toString();
    adress=json['adress'];
    region=json['region'];
    country=json['country'];
    postcode=json['postal_code'].toString();
    lat=json['latitude'];
    long=json['longitude'];
    userState = json['activated_account'].toString();
    role = json['role_id'];
    chainId = json['chain_id']??"";
    storeId = json['store_id'].toString();
    token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_account'] = this.userAccount;
    data['user_nickname'] = this.userNickname;
    data['user_state'] = this.userState;
    data['role'] = this.role;
    data['chain_id'] = this.chainId;
    data['store_id'] = this.storeId;
    data['token'] = this.token;
    return data;
  }

  

}
class SalesManager {
  List<UserProfil> salesManagers;

  SalesManager({this.salesManagers});

  SalesManager.fromJson(Map<String, dynamic> json) {
    if (json['salesManagers'] != null) {
      salesManagers = new List<UserProfil>();
      json['salesManagers'].forEach((v) {
        salesManagers.add(new UserProfil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.salesManagers != null) {
      data['salesManagers'] =
          this.salesManagers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  List<UserProfil> shops;

  Shops({this.shops});

  Shops.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = new List<UserProfil>();
      json['shops'].forEach((v) {
        shops.add(new UserProfil.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}