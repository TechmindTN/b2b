class OrderList {
  int id;
  String orderRef;
  String createdAt;
  String updatedAt;
  String orderDate;
  dynamic requiredDate;
  dynamic shippingDate;
  dynamic shippingType;
  dynamic shippingPrice;
  dynamic shippingAdresse;
  dynamic shippingCountry;
  dynamic orderPrice;
  dynamic commission;
  int supplierId;
  int shopOwnerId;
  int statutId;
  dynamic logisticCompanyId;
  dynamic companyId;
  int orderWeight;
  int paymentMethodId;
  dynamic logisticTarif;
  ShopOwner shopOwner;
  Statut statut;
  List<ProductItem> productItem;

  Supplier supplier;

  OrderList(
      {this.id,
      this.orderPrice,
      this.orderRef,
      this.orderWeight,
      this.supplierId,
      this.statutId,
      this.supplier,
      this.statut,
      this.productItem,
      this.shopOwner});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderRef = json['order_ref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderDate = json['order_date'];
    requiredDate = json['required_date'];
    shippingDate = json['shipping_date'];
    shippingType = json['shipping_type'];
    shippingPrice = json['shipping_price'];
    shippingAdresse = json['shipping_adresse'];
    shippingCountry = json['shipping_country'];
    orderPrice = json['order_price'];
    commission = json['commission'];
    supplierId = json['supplier_id'];
    shopOwnerId = json['shop_owner_id'];
    statutId = json['statut_id'];
    logisticCompanyId = json['logistic_company_id'];
    companyId = json['company_id'];
    orderWeight = json['order_weight'];
    paymentMethodId = json['payment_method_id'];
    logisticTarif = json['logistic_tarif'];
    shopOwner = json['shop_owner'] != null
        ? new ShopOwner.fromJson(json['shop_owner'])
        : null;
    statut =
        json['statut'] != null ? new Statut.fromJson(json['statut']) : null;
    if (json['product_item'] != null) {
      productItem = new List<ProductItem>();
      json['product_item'].forEach((v) {
        productItem.add(new ProductItem.fromJson(v));
      });
    }
    supplier = json['supplier'] != null
        ? new Supplier.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_price'] = this.orderPrice;
    data['order_weight'] = this.orderWeight;
    data['supplier_id'] = this.supplierId;
    data['statut_id'] = this.statutId;
    if (this.shopOwner != null) {
      data['shop_owner'] = this.shopOwner.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier.toJson();
    }
    if (this.statut != null) {
      data['statut'] = this.statut.toJson();
    }
    if (this.productItem != null) {
      data['product_item'] = this.productItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supplier {
  int id;
  String firstName;
  String lastName;

  Supplier({this.id, this.firstName, this.lastName});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class ShopOwner {
  int id;
  String firstName;
  String lastName;
  String adress;
  String country;
  String region;

  ShopOwner(
      {this.id,
      this.firstName,
      this.lastName,
      this.adress,
      this.country,
      this.region});

  ShopOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    adress = json['adress'];
    country = json['country'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['adress'] = this.adress;
    data['country'] = this.country;
    data['region'] = this.region;
    return data;
  }
}

class Statut {
  int id;
  String statutName;

  Statut({this.id, this.statutName});

  Statut.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statutName = json['statut_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statut_name'] = this.statutName;
    return data;
  }
}

class ProductItem {
  int id;
  dynamic itemOnlinePrice;
  String itemBarcode;
  int productBaseId;
  Pivot pivot;
  Product product;

  ProductItem(
      {this.id,
      this.itemOnlinePrice,
      this.itemBarcode,
      this.productBaseId,
      this.pivot,
      this.product});

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemOnlinePrice = json['item_online_price'];
    itemBarcode = json['item_barcode'];
    productBaseId = json['product_base_id'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_online_price'] = this.itemOnlinePrice;
    data['item_barcode'] = this.itemBarcode;
    data['product_base_id'] = this.productBaseId;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Pivot {
  int orderId;
  int itemId;
  int quantity;
  String createdAt;
  String updatedAt;

  Pivot(
      {this.orderId,
      this.itemId,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_id'] = this.itemId;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Product {
  String productName;
  int id;

  Product({this.productName, this.id});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['id'] = this.id;
    return data;
  }
}
