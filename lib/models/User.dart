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