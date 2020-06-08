import 'package:siyou_b2b/models/suppliers.dart';

import 'Productitems.dart';
import 'category.dart';
import 'brand.dart';

class Product {
  int id;
  bool wishlist;
  String productName;
  String productDescription;
  double taxeRate;
  int productPackage;
  int productBox;
  int categoryId;
  int supplierId;
  int brandId;
  String createdAt;
  String updatedAt;
  Suppliers supplier;
  Brand brand;
  Category category;
  String productImage;
  ItemH item;
  List<Items> items;

  Product(
      {this.id,
      this.wishlist,
      this.productName,
      this.productDescription,
      this.taxeRate,
      this.productPackage,
      this.productBox,
      this.categoryId,
      this.supplierId,
      this.brandId,
      this.createdAt,
      this.updatedAt,
      this.supplier,
      this.brand,
      this.category,
      this.productImage,
      this.item,
      this.items});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wishlist = json['wish_list'] == null ? true : json['wish_list'];
    productName = json['product_name'].toString();
    productDescription = json['product_description'].toString();
    // taxeRate = json['taxe_rate'];
    productImage = json['product_image_url'];
    productPackage = json['product_package'];
    productBox = json['product_box'];
    categoryId = json['category_id'];
    supplierId = json['supplier_id'];
    brandId = json['brand_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    supplier = json['supplier'] != null
        ? new Suppliers.fromJson(json['supplier'])
        : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    item = json['item'] != null ? new ItemH.fromJson(json['item']) : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }
}

class ItemH {
  int productBaseId;
  dynamic itemOnlinePrice;

  ItemH({this.productBaseId, this.itemOnlinePrice});

  ItemH.fromJson(Map<String, dynamic> json) {
    productBaseId = json['product_base_id'];
    itemOnlinePrice = json['item_online_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_base_id'] = this.productBaseId;
    data['item_online_price'] = this.itemOnlinePrice;
    return data;
  }
}
