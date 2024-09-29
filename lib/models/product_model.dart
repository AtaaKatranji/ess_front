class Product{
  final String name;
  final double price;
  final String desc;

  Product({required this.name,required this.price,required this.desc});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'].toDouble(),
      desc: json['desc'],
    );
  }
}