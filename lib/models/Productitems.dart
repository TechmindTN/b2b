
import 'package:siyou_b2b/models/brand.dart';
import 'package:siyou_b2b/models/category.dart';

class Productitems {
  dynamic id;
  String productName;
  String productDescription;
 // dynamic taxeRate;
  dynamic productPackage;
  dynamic productBox;
  dynamic categoryId;
  dynamic supplierId;
  dynamic brandId;
  String createdAt;
  String updatedAt;
  Brand brand;
  Category category;
  List<Items> items;

  Productitems(
      {this.id,
      this.productName,
      this.productDescription,
     // this.taxeRate,
      this.productPackage,
      this.productBox,
      this.categoryId,
      this.supplierId,
      this.brandId,
      this.createdAt,
      this.updatedAt,
      this.brand,
      this.category,
      this.items});

  Productitems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    //taxeRate = json['taxe_rate'];
    productPackage = json['product_package'];
    productBox = json['product_box'];
    categoryId = json['category_id'];
    supplierId = json['supplier_id'];
    brandId = json['brand_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
   // data['taxe_rate'] = this.taxeRate;
    data['product_package'] = this.productPackage;
    data['product_box'] = this.productBox;
    data['category_id'] = this.categoryId;
    data['supplier_id'] = this.supplierId;
    data['brand_id'] = this.brandId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['brand'] = this.brand;
    data['category'] = this.category;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Items {
  dynamic id;
  num itemOnlinePrice;
  num itemOfflinePrice;
  dynamic itemPackage;
  dynamic itemBox;
  String itemBarcode;
  dynamic itemWarnQuantity;
  dynamic itemQuantity;
  dynamic itemDiscountType;
  dynamic itemDiscountPrice;
  String createdAt;
  String updatedAt;
  dynamic productBaseId;
  List<CriteriaBase> criteriaBase;
  List<Images> images;
  num quantity;
  dynamic supplierid;
  String productname;
  Productitems product;


  Items(
      {this.id,
      this.itemOnlinePrice,
      this.itemOfflinePrice,
      this.itemPackage,
      this.itemBox,
      this.itemBarcode,
      this.itemWarnQuantity,
      this.itemQuantity,
      this.itemDiscountType,
      this.itemDiscountPrice,
      this.createdAt,
      this.updatedAt,
      this.productBaseId,
      this.criteriaBase,
      this.images,
      this.quantity,
      this.supplierid,
      this.productname
      });

  


Map<String, dynamic> toMap() {
    return {
      'item_id': id,
      'item_quantity': quantity,
      'item_barcode':itemBarcode,
      'item_price':itemOnlinePrice,
      'item_weight':double.parse(criteriaBase[0].pivot.criteriaValue),
      'item_image':images[0].imageUrl,
      'product_base_name':product.productName
    };
  }
  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemOnlinePrice = json['item_online_price']==null?itemOnlinePrice=1.00:double.parse(json['item_online_price']);
    itemOfflinePrice = double.parse(json['item_offline_price']);
    itemPackage = json['item_package'];
    itemBox = json['item_box'];
    itemBarcode = json['item_barcode'];
    itemWarnQuantity = json['item_warn_quantity'];
    itemQuantity = json['item_quantity'];
    itemDiscountType = json['item_discount_type'];
    itemDiscountPrice = json['item_discount_price'];//double.parse();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productBaseId = json['product_base_id'];
    productname=json['product_base_name'];
    if (json['criteria_base'] != null) {
      criteriaBase = new List<CriteriaBase>();
      json['criteria_base'].forEach((v) {
        criteriaBase.add(new CriteriaBase.fromJson(v));
      });
    }
   if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    product=json['product'] != null ? new Productitems.fromJson(json['product']) : null;
    quantity=0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_online_price'] = this.itemOnlinePrice;
    data['item_offline_price'] = this.itemOfflinePrice;
    data['item_package'] = this.itemPackage;
    data['item_box'] = this.itemBox;
    data['item_barcode'] = this.itemBarcode;
    data['item_warn_quantity'] = this.itemWarnQuantity;
    data['item_quantity'] = this.itemQuantity;
    data['item_discount_type'] = this.itemDiscountType;
    data['item_discount_price'] = this.itemDiscountPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_base_id'] = this.productBaseId;
    data['product_base_name']=this.productname;
    if (this.criteriaBase != null) {
      data['criteria_base'] = this.criteriaBase.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class CriteriaBase {
  dynamic id;
  String name;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  CriteriaBase(
      {this.id, this.name, this.createdAt, this.updatedAt, this.pivot});

  CriteriaBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic productItemId;
  dynamic criteriaId;
  String criteriaValue;
  dynamic criteriaUnitId;
  String createdAt;
  String updatedAt;

  Pivot(
      {this.productItemId,
      this.criteriaId,
      this.criteriaValue,
      this.criteriaUnitId,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    productItemId = json['product_item_id'];
    criteriaId = json['criteria_id'];
    criteriaValue = json['criteria_value'];
    criteriaUnitId = json['criteria_unit_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_item_id'] = this.productItemId;
    data['criteria_id'] = this.criteriaId;
    data['criteria_value'] = this.criteriaValue;
    data['criteria_unit_id'] = this.criteriaUnitId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  dynamic id;
  String imageUrl;
  dynamic productItemId;
  dynamic isSelected;
  String createdAt;
  String updatedAt;
  String imageName;

  Images(
      {this.id,
      this.imageUrl,
      this.productItemId,
      this.isSelected,
      this.createdAt,
      this.updatedAt,
      this.imageName});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    productItemId = json['product_item_id'];
    isSelected = json['is_selected'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageName = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['product_item_id'] = this.productItemId;
    data['is_selected'] = this.isSelected;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_name'] = this.imageName;
    return data;
  }
}