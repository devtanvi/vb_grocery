class Product {
  final String productId;
  final String categoryId;
  final String categoryName;
  final String productName;
  final String productDesc;
  final String productImage;
  final String productStatus;
  final List<ProductVariant> productVariants;

  Product({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.productName,
    required this.productDesc,
    required this.productImage,
    required this.productStatus,
    required this.productVariants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> variantsJson = json['product_variant'];

    return Product(
      productId: json['product_id'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      categoryName: json['category_name'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      productDesc: json['product_desc'] as String? ?? '',
      productImage: json['product_image'] as String? ?? '',
      productStatus: json['product_status'] as String? ?? '',
      productVariants: variantsJson.map((variant) => ProductVariant.fromJson(variant)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'category_id': categoryId,
      'category_name': categoryName,
      'product_name': productName,
      'product_desc': productDesc,
      'product_image': productImage,
      'product_status': productStatus,
      'product_variant': productVariants.map((variant) => variant.toJson()).toList(),
    };
  }
}

class ProductVariant {
  final String pvId;
  final String productId;
  final String pvQty;
  final String pvUnit;
  final String pvDisPrice;
  final String pvOriPrice;
  final String pvStatus;

  ProductVariant({
    required this.pvId,
    required this.productId,
    required this.pvQty,
    required this.pvUnit,
    required this.pvDisPrice,
    required this.pvOriPrice,
    required this.pvStatus,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      pvId: json['pv_id'] as String? ?? '',
      productId: json['product_id'] as String? ?? '',
      pvQty: json['pv_qty'] as String? ?? '',
      pvUnit: json['pv_unit'] as String? ?? '',
      pvDisPrice: json['pv_dis_price'] as String? ?? '',
      pvOriPrice: json['pv_ori_price'] as String? ?? '',
      pvStatus: json['pv_status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pv_id': pvId,
      'product_id': productId,
      'pv_qty': pvQty,
      'pv_unit': pvUnit,
      'pv_dis_price': pvDisPrice,
      'pv_ori_price': pvOriPrice,
      'pv_status': pvStatus,
    };
  }
}
