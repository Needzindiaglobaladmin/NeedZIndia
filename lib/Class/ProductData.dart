

import 'package:NeedZIndia/Class/ProductVariant.dart';

class ProductData {
  final int productId;
  final int categoryId;
  final int stockId;
  final int variantId;
  final int unitId;
  final String productName;
  final String categoryName;
  final String variantName;
  final String unitName;
  final String description;
  final String brand;
  final String imageUrl;
  final double cost;
  final double price;
  final double discountedPrice;
  final double discountPercentage;
  final double quantity;
  final String unitSymbol;
  int stocks;
  bool addedToCart;
  int cartId;
  int quantityToBeBought;
  final List<ProductVariant> variants;
  bool add;
  int counter;
  bool cartUpdating;
  bool addingToCart;
  //final dynamic variants;

  ProductData({this.productId, this.categoryId,this.stockId,
    this.variantId,this.unitId,this.productName,this.categoryName,this.variantName,
    this.unitName,this.description,this.brand,this.imageUrl,this.cost,
    this.price,this.discountedPrice,this.discountPercentage,this.quantity,this.unitSymbol,
    this.stocks,this.variants,this.addedToCart,this.cartId,this.quantityToBeBought,this.add,this.counter,this.cartUpdating,this.addingToCart});

  factory ProductData.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List;
    return ProductData(
        productId: json['productId'],
        categoryId: json['categoryId'],
        stockId: json['stockId'],
        variantId: json['variantId'],
        unitId: json['unitId'],
        productName: json['productName'],
        categoryName: json['categoryName'],
        variantName: json['variantName'],
        unitName: json['unitName'],
        description: json['description'],
        brand: json['brand'],
        imageUrl: json['imageUrl'],
        cost: json['cost'].toDouble(),
        price: json['price'].toDouble(),
        discountedPrice: json['discountedPrice'].toDouble(),
        discountPercentage: json['discountPercentage'].toDouble(),
        quantity: json['quantity'].toDouble(),
        unitSymbol: json['unitSymbol'],
        stocks: json['stocks'],
        addedToCart: json['addedToCart'],
        cartId: json['cartId'],
        quantityToBeBought: json['quantityToBeBought'],
        cartUpdating: false,
        addingToCart: false,
        counter: 1,
        add: false,
        variants:variantList.map((e) => ProductVariant.fromJson(e)).toList()
    );
  }
}