
class AddCartResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final AddCartData data;

  AddCartResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory AddCartResponse.fromJson(Map<String, dynamic> json) {
    return AddCartResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: AddCartData.fromJson(json['data']),
    );
  }
}

class AddCartData {
  final int userId;
  final String fullName;
  final double cartCost;
  final double cartPrice;
  final double cartDiscountedPrice;
  final double cartDiscountPercentage;
  final double deliveryCharge;
  final List<CartItems> cartItems;


  AddCartData({this.userId,this.fullName,this.cartCost,this.cartPrice,this.cartDiscountedPrice,this.cartDiscountPercentage,this.deliveryCharge,this.cartItems});

  factory AddCartData.fromJson(Map<String, dynamic> json) {
    var cartitem = json['cartItems'] as List;
    return AddCartData(
      userId: json['userId'],
      fullName: json['fullName'] ,
      cartCost: json['cartCost'].toDouble(),
      cartPrice: json['cartPrice'].toDouble(),
      cartDiscountedPrice: json['cartDiscountedPrice'].toDouble(),
      cartDiscountPercentage: json['cartDiscountPercentage'].toDouble(),
      deliveryCharge: json['deliveryCharge'].toDouble(),
      cartItems: cartitem.map((e) => CartItems.fromJson(e)).toList(),
    );
  }
}

class CartItems {
  final int userId;
  final int productId;
  final String fullName;
  final int stockId;
  final int categoryId;
  final int variantId;
  final int unitId;
  final int cartId;
  final int quantityToBeBought;
  final String productName;
  final String categoryName;
  final String variantName;
  final String unitName;
  final double cost;
  final double price;
  final double discountedPrice;
  final double totalCost;
  final double totalPrice;
  final double totalDiscountedPrice;
  final double discountPercentage;
  final String imageUrl;
  final String description;
  final String brand;
  final String unitSymbol;
  final int quantity;
  final int stocks;

  CartItems({this.brand,this.cartId,this.quantityToBeBought,this.imageUrl,this.description,this.price,this.discountPercentage,this.productName,
  this.stockId,this.variantName,this.categoryId,this.categoryName,this.cost,this.discountedPrice,this.fullName,this.productId,this.quantity,this.stocks,
  this.totalCost,this.totalDiscountedPrice,this.totalPrice,this.unitId,this.unitName,this.unitSymbol,this.userId,this.variantId});

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      brand: json['brand'],
      cartId: json['cartId'],
      quantityToBeBought: json['quantityToBeBought'] ,
      imageUrl: json['imageUrl'] ,
      description: json['description'] ,
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      productName: json['productName'] ,
      stockId: json['stockId'],
      variantName: json['variantName'],
      categoryId: json['categoryId'] ,
      categoryName: json['categoryName'] ,
      cost: json['cost'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      fullName: json['fullName'] ,
      productId: json['productId'] ,
      quantity: json['quantity'],
      stocks: json['stocks'],
      totalCost: json['totalCost'].toDouble(),
      totalDiscountedPrice: json['totalDiscountedPrice'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      unitId: json['unitId'] ,
      unitName: json['unitName'] ,
      unitSymbol: json['unitSymbol'] ,
      userId: json['userId'] ,
      variantId: json['variantId'] ,
    );
  }
}