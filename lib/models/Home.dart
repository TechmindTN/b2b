import 'Product.dart';

class Home {
  List<Product> lastAdded;
  List<Product> recommended;
  List<Product> bestSeller;

  Home({this.lastAdded, this.recommended, this.bestSeller});

  Home.fromJson(Map<String, dynamic> json) {
    if (json['last_added'] != null) {
      lastAdded = new List<Product>();
      json['last_added'].forEach((v) {
        lastAdded.add(new Product.fromJson(v));
      });
    }
    if (json['recommended'] != null) {
      recommended = new List<Product>();
      json['recommended'].forEach((v) {
        recommended.add(new Product.fromJson(v));
      });
    }
    if (json['bestSeller'] != null) {
      bestSeller = new List<Product>();
      json['bestSeller'].forEach((v) {
        bestSeller.add(new Product.fromJson(v));
      });
    }
  }
}
