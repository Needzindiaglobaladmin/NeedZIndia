class ProductVariant {
  final int stockId;
  final int variantId;
  final double cost;
  final double price;
  final double discountedPrice;
  final double discountPercentage;
  final String imageUrl;
  final String variantName;
  final double quantity;
  final int unitId;
  final String unitName;
  final String abbreviationSymbol;
  final int stocks;
  final bool addedToCart;

  ProductVariant({this.stockId, this.variantId,this.cost,
    this.price,this.discountedPrice,this.discountPercentage,this.imageUrl,
    this.variantName,this.quantity,this.unitId,this.unitName,this.abbreviationSymbol,this.stocks,this.addedToCart});

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      stockId: json['stockId'],
      variantId: json['variantId'],
      cost: json['cost'].toDouble() ,
      price: json['price'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      imageUrl: json['imageUrl'],
      variantName: json['variantName'],
      quantity: json['quantity'].toDouble(),
      unitId: json['unitId'],
      unitName: json['unitName'],
      abbreviationSymbol: json['abbreviationSymbol'],
      stocks: json['stocks'],
      addedToCart: json['addedToCart'],
    );
  }
}



