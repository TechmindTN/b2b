import 'package:flutter/material.dart';



class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => new _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Discover",
                  style: Theme.of(context).textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(15.0),
                    color: Colors.grey,
                  ),
                  child: TextField(
                    //controller: editingController,
                    decoration: InputDecoration(
                      //labelText: "Search",
                      hintText: "Search",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    onPressed: () {_scaffoldKey.currentState.openEndDrawer();},
                  ),
                ),
              
              ],
            ),
            SizedBox(height: 7.5),
            
            
           
            
            
            
            
            
            Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Wrap(
                    children: List.generate(products.length, (i) {
                  //final cellWidth = mediaQuery.size.width / 3; // Every cell's `width` will be set to 1/3 of the screen width.
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => null,
                        ),
                      );
                    },
                    child: Container(
                      width: 145,
                      margin: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 3,
                                minWidth: double.infinity),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: Image.network(
                                products[i].images[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            products[i].title,
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color: Colors.black.withOpacity(.85),
                                ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            "${products[i].price}",
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.blueAccent),
                          ),
                          Row(
                            children: <Widget>[
                              FlatButton.icon(
                                icon: Icon(
                                  Icons.star,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "${products[i].rating}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(color: Colors.black),
                                ),
                                onPressed: () {},
                              ),
                              //Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }))),
          ],
        ),
      ),
      
      /*new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("Home Body"),
          ),
          new ListTile(
            title: new RaisedButton(
              child: new Text("Open Drawer"),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ),
        ],
      ),*/
      
      //endDrawer: new AppDrawer(),
    );
  }
}


class Categories {
  final String title;
  final int id;
  final List<SubCategories> subCat;

  Categories({this.title, this.id, this.subCat});
}

class SubCategories {
  final String title;
  final int id;

  SubCategories({this.title, this.id});
}

List<Categories> categories = [
  Categories(
    title: 'Electronics',
    id: 0,
    subCat: [
      SubCategories(id: 0, title: 'Phones'),
      SubCategories(id: 1, title: 'Laptops'),
      SubCategories(id: 2, title: 'Drones'),
      SubCategories(id: 3, title: 'Graphics Cards'),
      SubCategories(id: 4, title: 'CPU'),
      SubCategories(id: 5, title: 'Motherboard'),
    ],
  ),
  Categories(
    title: 'Shoes',
    id: 1,
    subCat: [
      SubCategories(id: 0, title: "OXFORD"),
      SubCategories(id: 1, title: "DERBY"),
      SubCategories(id: 2, title: "MEN’S BOOTS"),
      SubCategories(id: 3, title: "MOCCASIN"),
      SubCategories(id: 4, title: "LOAFER"),
      SubCategories(id: 5, title: "BLUCHER"),
      SubCategories(id: 6, title: "BOAT SHOE"),
      SubCategories(id: 7, title: "MONK"),
      SubCategories(id: 8, title: "STRAP"),
      SubCategories(id: 9, title: "BUDAPESTER"),
      SubCategories(id: 10, title: "BUCKLED SHOES"),
      SubCategories(id: 11, title: "LACE-UP SHOES"),
      SubCategories(id: 12, title: "SLIP-ON SHOES"),
    ],
  ),
  Categories(
    title: 'Cloths',
    id: 2,
    subCat: [
      SubCategories(id: 0, title: "Jackets and coats"),
      SubCategories(id: 1, title: "Trousers and shorts"),
      SubCategories(id: 2, title: "Underwear"),
      SubCategories(id: 3, title: "Suits"),
      SubCategories(id: 4, title: "Skirts and dresses"),
      SubCategories(id: 5, title: "Sweaters and waistcoats"),
    ],
  ),
  Categories(
    title: 'Home',
    id: 3,
    subCat: [
      SubCategories(id: 0, title: "Microwave oven"),
      SubCategories(id: 1, title: "Stacked washing machine \& clothes dryer"),
      SubCategories(id: 2, title: "Gas fireplace"),
      SubCategories(id: 3, title: "Refrigerators"),
      SubCategories(id: 4, title: "Vacuum cleaner"),
      SubCategories(id: 5, title: "Electric water heater tank"),
      SubCategories(id: 6, title: "Small twin window fan"),
    ],
  ),
];

class Product {
  final String mainImage;
  final List<String> images;
  final List<String> tags;
  final List<Color> colors;
  final List<int> size;
  final String title;
  final String price;
  final double rating;
  Product({
    this.rating,
    this.price,
    this.mainImage,
    this.images,
    this.tags,
    this.colors,
    this.size,
    this.title,
  });
}

List<String> homeHero = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJNpAgy_1pUywRj139t5LFXc3Rr8SSJqON5ZzI8wejgADRtAdvPw&s",
  "https://www.mybucketdeals.com/images/banner-productxx.jpg",
  "http://business-newsupdate.com/img/business/wuxi-atu-and-genemedicine-partner-to-develop-oncolytic-virus-products.jpg",
  "https://46ba123xc93a357lc11tqhds-wpengine.netdna-ssl.com/wp-content/uploads/2019/09/amazon-alexa-event-sept-2019.jpg",
];

List<Product> products = [
  Product(
    title: "BMAX S15 Laptop 15.6 inch",
    price: "€. 400.00",
    images: [
      'https://ae01.alicdn.com/kf/Hd0581c8951ea4e5c9a38a6af74af04f0R.jpg',
      'https://ae01.alicdn.com/kf/He48bd23b634f499db1e5dc972ab19b88h.jpg',
      'https://ae01.alicdn.com/kf/Ha362ee8cbeea472ba90b7cb9c8292c0bg.jpg',
      'https://ae01.alicdn.com/kf/Ha86ae8d81ee143c7b75803dfd207fde9P.jpg'
    ],
    colors: [Colors.black, Colors.red, Colors.grey] ,
    mainImage: 'https://ae01.alicdn.com/kf/Hd0581c8951ea4e5c9a38a6af74af04f0R.jpg',
    size: [],
    tags: ['Product', 'laptop', 'Gaming', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Xiaomi Mi Gaming Laptop",
    price: "€. 1059.00",
    images: [
      'https://ae01.alicdn.com/kf/HTB1SAt8XZfrK1Rjy1Xdq6yemFXaW.jpg',
      'https://ae01.alicdn.com/kf/HTB1AqSmdjbguuRkHFrdq6z.LFXaD.jpg',
      'https://ae01.alicdn.com/kf/HTB1vcJ6X16sK1RjSsrbq6xbDXXaE.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.grey],
    mainImage: 'https://ae01.alicdn.com/kf/H9fb2b7eaa92d4df090ee1dcb9f3dae0fn.jpg',
    size: [],
    tags: ['Product', 'Laptop', 'Xiaomi', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Mens Blazer Jacket Smart Casual Suit Men Clothes 2020",
    price: "€. 100.00",
    images: [
      'https://ae01.alicdn.com/kf/H3b958e5cafdc43bfa2c43d5ec2426d07u.jpg?width=800&height=800&hash=1600',
      'https://ae01.alicdn.com/kf/H860c9c2377254b30b1df4ab382b416f3x.jpg?width=800&height=800&hash=1600',
      'https://ae01.alicdn.com/kf/H40fe784e90254f22a5dccf70d7d5b259J.jpg?width=800&height=800&hash=1600',
      'https://ae01.alicdn.com/kf/H397d8f3829004a7fb93ea8d2b0c72137K.jpg?width=800&height=800&hash=1600'
    ],
    colors: [Colors.black, Colors.red, Colors.grey,Colors.blue[600]],
    mainImage: 'https://ae01.alicdn.com/kf/H3b958e5cafdc43bfa2c43d5ec2426d07u.jpg?width=800&height=800&hash=1600',
    size: [42,45,47,50,53],
    tags: ['Product', 'Clothes', 'Jacket', 'Price', 'Quality'],
    rating: 4.5,
  ),
  Product(
    title: "Disposable medical isolation clothing",
    price: "€. 85.00",
    images: [
      'https://ae01.alicdn.com/kf/H4dfefc1a67204605afabd811182b50b4q.jpg',
      'https://ae01.alicdn.com/kf/Hcd0e93a7bdf749a88f630ec8dec7fa26m.jpg',
      'https://ae01.alicdn.com/kf/H5424b41d1be544208f2c1d30e660a6d3I.jpg',
    ],
    colors: [],
    mainImage: 'https://ae01.alicdn.com/kf/H4dfefc1a67204605afabd811182b50b4q.jpg',
    size: [39,42,45,50,53],
    tags: ['Product', 'Medical', 'CoronaVirus',],
    rating: 4.5,
  ),
  Product(
    title: "Automatic Spray Type Soap Dispenser ",
    price: "€. 100.00",
    images: [
      'https://ae01.alicdn.com/kf/H0485ea036fd847fcb9f331066a1d409b8.jpg',
      'https://ae01.alicdn.com/kf/H212b22b172d0464eb654847812c570d8f.jpg',
      'https://ae01.alicdn.com/kf/He6488feea5f24d9ca493a9ac29c18e42T.jpg',
    ],
    colors: [Colors.white,],
    mainImage: 'https://ae01.alicdn.com/kf/H0485ea036fd847fcb9f331066a1d409b8.jpg',
    size: [],
    tags: ['Product', 'Home', 'health', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Ski Mask Airsoft Training Winter ",
    price: "€. 61.00",
    images: [
      'https://ae01.alicdn.com/kf/Hec0d82fbc3f24944a431e6039200af44f.jpg',
      'https://ae01.alicdn.com/kf/Ha4f43ed8ebf242ba8ef24c987d7bafa1F.jpg',
      'https://ae01.alicdn.com/kf/H0a0d3f4cb6bf49df89650d21cbb2f9cek.jpg',
    ],
    colors: [Colors.black, ],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Mask', 'Sports', ],
    rating: 3.5,
  ),
  Product(
    title: "Joyeauto Wireless Apple Carplay For Mercedes",
    price: "€. 400.00",
    images: [
      'https://ae01.alicdn.com/kf/Hb49d8571ec5b43ba9c541a57e61eed4fY.jpg',
      'https://ae01.alicdn.com/kf/H7fd9ca68185a4427a682b0431f046eeey.jpg',
      'https://ae01.alicdn.com/kf/H7fd9ca68185a4427a682b0431f046eeey.jpg',
    ],
    colors: [Colors.black,],
    mainImage: 'https://ae01.alicdn.com/kf/Hb49d8571ec5b43ba9c541a57e61eed4fY.jpg',
    size: [],
    tags: ['Product', 'TECH', 'Automobil', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "€. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "€. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "€. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "€. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "€. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
];
List<Product> bag = [
  Product(
    title: "Hand Bag",
    price: "€. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality']
  ),
  Product(
    title: "Adidas Superstar",
    price: "€. 400.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality']
  ),
];

class Category {
  final String title;
  final IconData icon;

  Category({this.title, this.icon});
}



class Supplier {
  final String title;
  final String img;

  Supplier({this.title, this.img});
}
List<Supplier> supp = [
  Supplier(
    img: "",
    title: "Siyou SRL",
  ),
  Supplier(
    img: "",
    title: "Adidas",
  ),
  Supplier(
    img: "",
    title: "nike",
  ),
  Supplier(
    img: "",
    title: "Carfour",
  ),
  Supplier(
    img: "",
    title: "Supplier SRL",
  ),
];
