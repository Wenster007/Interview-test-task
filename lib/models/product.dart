class Product {
  final int? id;
  final String? title;
  final String? description;
  final double? price;
  final String? thumbnail;
  final String? category;
  final double? rating;
  final String? brand;
  final int? stock;
  final List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.thumbnail,
    this.category,
    this.rating,
    this.brand,
    this.stock,
    this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] as String?,
      category: json['category'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      brand: json['brand'] as String?,
      stock: json['stock'] as int?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}
