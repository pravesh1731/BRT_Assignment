class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final double price;
  final double rating;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.rating,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      thumbnail: json["thumbnail"],
      price: double.parse(json["price"].toString()),
      rating: double.parse(json["rating"].toString()),
      category: json["category"],
    );
  }
}