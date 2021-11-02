class DataModel {
  List<Products> products;

  DataModel({
    this.products,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = List<Products>();
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
  }
}

/*
"products": [
        {
            "id": 1,
            "name": "Man White Regular Fit Polo Neck Polo T-Shirt",
            "title": "Man White T-Shirt",
            "category_id": 1,
            "description": null,
            "price": 200,
            "discount": 0,
            "discount_type": null,
            "currency": "EGP",
            "in_stock": 30,
            "avatar": "https://retail.amit-learning.com/images/products/mFXrS9i3y07IT9ic7jgcfq90GtMhf91WdlydLsnt.jpg",
            "price_final": 200,
            "price_final_text": "200 EGP"
        },
        ]
 */
class Products {
  final int id;
  final String name;
  final String title;
  final int category_id;
  final String description;
  final num  price;
  final num discount;
  final String discount_type;
  final String currency;
  final int in_stock;
  final String avatar;
  final num  price_final;
  final String price_final_text;

  Products({
    this.id,
    this.name,
    this.title,
    this.category_id,
    this.description,
    this.price,
    this.discount,
    this.discount_type,
    this.currency,
    this.in_stock,
    this.avatar,
    this.price_final,
    this.price_final_text,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json['id'],
        name: json['name'],
        title: json['title'],
      category_id: json['category_id'],
        description: json['description'],
        price: json['price'],
        discount: json['discount'],
      discount_type: json['discount_type'],
        currency: json['currency'],
        in_stock: json['in_stock'],
        avatar: json['avatar'],
        price_final: json['price_final'],
        price_final_text: json['price_final_text'],
    );
  }
}