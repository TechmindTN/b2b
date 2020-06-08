import 'User.dart';

class Store {
  String storeId;
  String userId;
  String storeName;
  String storeNameEn;
  String storeNameIt;
  String storeGradeId;
  String storeLogo;
  String storeDomain;
  String storeArea;
  String storeAddress;
  String storeLatitude;
  String storeLongitude;
  String storeIsSelfsupport;
  String storeType;
  String storeIsOpen;
  String storeParentId;
  String storeCategoryId;
  String storeStateId;
  String storeTime;
  String storeEndTime;
  List<String> productCategoryIds;
  List<dynamic> storeO2oTags;
  String storeO2oFlag;
  String shopParentId;
  String storeIp;
  List<String> storeSupplierIds;
  String id;

  User user;

  Store(
    {this.storeId,
    this.userId,
    this.storeName,
    this.storeNameEn,
    this.storeNameIt,
    this.storeLogo,
  
    this.storeAddress,
    });

  Store.fromJson(Map<String, dynamic> json) {
    storeId = json['id'].toString();
    userId = json['shop_owner_id'].toString();
    storeName = json['store_name']??"";
    storeNameEn = json['store_name_en']??"";
    storeNameIt = json['store_name_it']??"";
    storeGradeId = json['store_grade_id'];
    storeLogo = json['store_logo']??"";
    storeAddress = json['store_adress'];
   
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['user_id'] = this.userId;
    data['store_name'] = this.storeName;
    data['store_name_en'] = this.storeNameEn;
    data['store_name_it'] = this.storeNameIt;
    data['store_grade_id'] = this.storeGradeId;
    data['store_logo'] = this.storeLogo;
    data['store_domain'] = this.storeDomain;
    data['store_area'] = this.storeArea;
    data['store_address'] = this.storeAddress;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['store_is_selfsupport'] = this.storeIsSelfsupport;
    data['store_type'] = this.storeType;
    data['store_is_open'] = this.storeIsOpen;
    data['store_parent_id'] = this.storeParentId;
    data['store_category_id'] = this.storeCategoryId;
    data['store_state_id'] = this.storeStateId;
    data['store_time'] = this.storeTime;
    data['store_end_time'] = this.storeEndTime;
    data['product_category_ids'] = this.productCategoryIds;
    if (this.storeO2oTags != null) {
      data['store_o2o_tags'] =
          this.storeO2oTags.map((v) => v.toJson()).toList();
    }
    data['store_o2o_flag'] = this.storeO2oFlag;
    data['shop_parent_id'] = this.shopParentId;
    data['store_ip'] = this.storeIp;
    data['store_supplier_ids'] = this.storeSupplierIds;
    data['id'] = this.id;
    return data;
  }
}
