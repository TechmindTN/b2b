class Suppliers {
  int id;
  String firstName;
  String lastName;
  String description;
  String email;
  int phoneNum1;
  int phoneNum2;
  int taxNumber;
  int roleId;
  dynamic supplierId;
  int validation;
  int productVisibility;
  int logisticService;
  String firstRespName;
  String adress;
  String country;
  String region;
  int postalCode;
  String imgUrl;
  String imgName;
  dynamic minorder;
  String latitude;
  String longitude;
  String distance;
  dynamic coverImgUrl;
  dynamic coverImgName;

  Suppliers(
      {this.id,
      this.firstName,
      this.lastName,
      this.description,
      this.email,
      this.phoneNum1,
      this.phoneNum2,
      this.taxNumber,
      this.roleId,
      this.supplierId,
      this.validation,
      this.productVisibility,
      this.logisticService,
      this.firstRespName,
      this.adress,
      this.country,
      this.region,
      this.postalCode,
      this.imgUrl,
      this.imgName,
      this.minorder,
      this.latitude,
      this.longitude,
      this.coverImgUrl,
      this.coverImgName});

  Suppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    description = json['description'];
    email = json['email'];
    phoneNum1 = json['phone_num1'];
    phoneNum2 = json['phone_num2'];
    taxNumber = json['tax_number'];
    roleId = json['role_id'];
    supplierId = json['supplier_id'];
    validation = json['validation'];
    productVisibility = json['product_visibility'];
    logisticService = json['logistic_service'];
    firstRespName = json['first_resp_name'];
    adress = json['adress'];
    country = json['country'];
    region = json['region'];
    postalCode = json['postal_code'];
    imgUrl = json['img_url'];
    imgName = json['img_name'];
    minorder = json['min_price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    coverImgUrl = json['cover_img_url'];
    coverImgName = json['cover_img_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['description'] = this.description;
    data['email'] = this.email;
    data['phone_num1'] = this.phoneNum1;
    data['phone_num2'] = this.phoneNum2;
    data['tax_number'] = this.taxNumber;
    data['role_id'] = this.roleId;
    data['supplier_id'] = this.supplierId;
    data['validation'] = this.validation;
    data['product_visibility'] = this.productVisibility;
    data['logistic_service'] = this.logisticService;
    data['first_resp_name'] = this.firstRespName;
    data['adress'] = this.adress;
    data['country'] = this.country;
    data['region'] = this.region;
    data['postal_code'] = this.postalCode;
    data['img_url'] = this.imgUrl;
    data['img_name'] = this.imgName;
    data['min_price'] = this.minorder;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['cover_img_url'] = this.coverImgUrl;
    data['cover_img_name'] = this.coverImgName;
    return data;
  }
}
