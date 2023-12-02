
class GetCartResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final GetCartData data;

  GetCartResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    //var cartList = json['data'] as List;
    return GetCartResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: GetCartData.fromJson(json['data']),
    );
  }
}

class GetCartData {
  final int userId;
  final String fullName;
  final double cartCost;
  final double cartPrice;
  final double cartDiscountedPrice;
  final double cartDiscountPercentage;
  final double cartPayableTotal;
  final int deliveryCharge;
  final String specialDiscount;
  final String couponApplied;
  final List<CartItems> cartItems;


  GetCartData({this.userId, this.fullName,this.cartCost,this.cartPrice,
    this.cartDiscountedPrice,this.cartDiscountPercentage,this.cartPayableTotal,this.cartItems,this.deliveryCharge,this.specialDiscount,this.couponApplied});

  factory GetCartData.fromJson(Map<String, dynamic> json) {
    var cartItems = json['cartItems'] as List;
    return GetCartData(
      userId: json['userId'],
      fullName: json['fullName'],
      cartCost: json['cartCost'].toDouble(),
      cartPrice: json['cartPrice'].toDouble(),
      cartDiscountedPrice: json['cartDiscountedPrice'].toDouble(),
      cartDiscountPercentage: json['cartDiscountPercentage'].toDouble(),
      cartPayableTotal: json['cartPayableTotal'].toDouble(),
      deliveryCharge: json['deliveryCharge'],
      specialDiscount: json['specialDiscount'].toString(),
      couponApplied: json['couponApplied'],
      cartItems:  cartItems.map((e) => CartItems.fromJson(e)).toList(),
    );
  }
}

class CartItems {
  final int userId;
  final int productId;
  final int stockId;
  final int categoryId;
  final int variantId;
  final int unitId;
  final int cartId;
  int quantityToBeBought;
  final String fullName;
  final String productName;
  final String categoryName;
  final String variantName;
  final String unitName;
  final double cost;
  final double price;
  final double discountedPrice;
  final double discountPercentage;
  final double totalCost;
  final double totalPrice;
  final double totalDiscountedPrice;
  final String imageUrl;
  final String description;
  final String brand;
  final double quantity;
  final String unitSymbol;
  final int stocks;
  bool cartUpdating;


  CartItems({this.userId,this.productId,this.stockId,this.categoryId,
    this.variantId,this.unitId,this.cartId,this.quantityToBeBought,this.fullName,this.productName,
    this.categoryName,this.variantName,this.unitName,this.cost,this.price,
    this.discountedPrice,this.discountPercentage,this.totalCost,this.totalDiscountedPrice,
    this.totalPrice,this.imageUrl,this.description,this.brand,
    this.quantity,this.unitSymbol,this.stocks,this.cartUpdating});

  factory CartItems.fromJson(Map<String, dynamic> json) {
    return CartItems(
      userId: json['userId'],
      productId: json['productId'],
      categoryId: json['categoryId'],
      stockId: json['stockId'],
      variantId: json['variantId'],
      unitId: json['unitId'],
      cartId: json['cartId'],
      quantityToBeBought: json['quantityToBeBought'],
      fullName: json['fullName'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      variantName: json['variantName'],
      unitName: json['unitName'],
      cost: json['cost'].toDouble(),
      price: json['price'].toDouble(),
      discountedPrice: json['discountedPrice'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      totalCost: json['totalCost'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
      totalDiscountedPrice: json['totalDiscountedPrice'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'],
      brand: json['brand'],
      quantity: json['quantity'].toDouble(),
      unitSymbol: json['unitSymbol'],
      stocks: json['stocks'],
      cartUpdating: false,
    );
  }
}