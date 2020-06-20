import 'Productitems.dart';

class Orders {
  List<Order> orders;

  Orders({this.orders});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = new List<Order>();
      json['orders'].forEach((v) {
        orders.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int supplierId;
  int paymentid;
  double orderTotalPrice;
  double orderWeight;
  //DateTime date;
  int logisticCompanyId;
  int logisticTarif;
  List<Productlist> orderProductsList;

  Order(
      {this.supplierId,
      this.orderTotalPrice,
      this.orderWeight,
      this.logisticCompanyId,
      this.logisticTarif,
      this.orderProductsList});

  Order.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    orderTotalPrice = json['order_total_price'];
    orderWeight = json['order_weight'];
    logisticCompanyId = json['logistic_company_id'];
    logisticTarif = json['logistic_tarif'];
    
    if (json['order_products_list'] != null) {
      orderProductsList = new List<Productlist>();
      json['order_products_list'].forEach((Items v) {
        orderProductsList.add(Productlist.fromJson(v.toMap()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['order_total_price'] = this.orderTotalPrice;
    data['order_weight'] = this.orderWeight;
    data['logistic_company_id'] = this.logisticCompanyId;
    data['logistic_tarif'] = this.logisticTarif;
    data['required_date']=(DateTime.now().add(Duration(days: 30,))).toString();
    data['payment_method_id']=this.paymentid;
    if (this.orderProductsList != null) {
      data['order_products_list'] =
          this.orderProductsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productlist {
  int itemId;
  int itemQuantity;
  String itemBarcode;
  String itemimage;
  String productname;
  double itemPrice;
  double itemweight;


  Productlist(
      {this.itemId, this.itemQuantity, this.itemBarcode, this.itemPrice,this.itemweight,this.itemimage,this.productname});

  Productlist.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    itemQuantity = json['item_quantity'];
    itemBarcode = json['item_barcode'];
    itemPrice = json['item_price'];
    itemweight=json['item_weight'];
    itemimage=json['item_image'];
    productname=json['product_base_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['item_quantity'] = this.itemQuantity;
    data['item_barcode'] = this.itemBarcode;
    data['item_price'] = this.itemPrice;
    data['item_weight']= this.itemweight;
    data['item_image']=this.itemimage;
    data['product_base_name']=this.productname;
    return data;
  }
}

