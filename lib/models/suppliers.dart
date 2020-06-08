class Suppliers {
  int id;
  String firstName;
  String lastName;
  String email;
  String phoneNum1;
  String phoneNum2;
  String taxNumber;
  int roleId;
  int supplierId;
  int validation;
  String productVisibility;
  int logistiqueServie;
  String firstRespName;
  String adress;
  String country;
  String region;
  String postalCode;
  String longitude;
  String latitude;
  String image;
  String distance;
  dynamic minorder;

  Suppliers(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNum1,
      this.phoneNum2,
      this.taxNumber,
      this.roleId,
      this.supplierId,
      this.validation,
      this.productVisibility,
      this.logistiqueServie,
      this.firstRespName,
      this.adress,
      this.country,
      this.region,
      this.postalCode,
      this.longitude,
      this.latitude,
      this.image,
      this.minorder});

  Suppliers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phoneNum1 = json['phone_num1'].toString();
    phoneNum2 = json['phone_num2'].toString();
    taxNumber = json['tax_number'].toString();
    roleId = json['role_id'];
    supplierId = json['supplier_id'];
    validation = json['validation'];
    productVisibility = json['product_visibility'].toString();
    logistiqueServie = json['logistique_servie'];
    firstRespName = json['first_resp_name'];
    adress = json['adress'];
    country = json['country'];
    region = json['region'];
    postalCode = json['postal_code'].toString();
    longitude = json['longitude'];
    latitude = json['latitude'];
    image= json['img_url'];
    minorder=json['min_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_num1'] = this.phoneNum1;
    data['phone_num2'] = this.phoneNum2;
    data['tax_number'] = this.taxNumber;
    data['role_id'] = this.roleId;
    data['supplier_id'] = this.supplierId;
    data['validation'] = this.validation;
    data['product_visibility'] = this.productVisibility;
    data['logistique_servie'] = this.logistiqueServie;
    data['first_resp_name'] = this.firstRespName;
    data['adress'] = this.adress;
    data['country'] = this.country;
    data['region'] = this.region;
    data['postal_code'] = this.postalCode;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}