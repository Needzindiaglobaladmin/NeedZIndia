
class PlaceOrderResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final dynamic data;

  PlaceOrderResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    return PlaceOrderResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data : json['data'] == "" ? "" : PlaceOrderDetailsData.fromJson(json['data']),
    );
  }
}

class PlaceOrderDetailsData {
  final int orderId;
  final String couponApplied;
  final double discountOnCoupon;
  final double amountPaidByUser;
  final String expectedDeliveryDate;
  final bool isShipped;
  final bool isDelivered;
  final String paymentMode;
  final bool isPaid;
  final double netOrderAmount;
  final double totalOrderAmount;
  final double totalPayableAmount;
  final double deliveryCharge;
  final PlaceOrderedShippingAddress shippingAddress;
  final List<PlacedOrderItems> orderItems;

  PlaceOrderDetailsData({this.orderId,this.couponApplied,this.discountOnCoupon,this.amountPaidByUser,this.expectedDeliveryDate,
    this.isShipped,this.isDelivered,this.isPaid,this.paymentMode,this.netOrderAmount,this.totalOrderAmount,this.totalPayableAmount,
    this.deliveryCharge,this.shippingAddress,this.orderItems});

  factory PlaceOrderDetailsData.fromJson(Map<String, dynamic> json) {
    var orderList = json['orderItems'] as List;
    //var shippingAddressList = json['shippingAddress'] as List;
    return PlaceOrderDetailsData(
      orderId: json['orderId'],
      couponApplied: json['couponApplied'],
      discountOnCoupon: json['discountOnCoupon'].toDouble(),
      amountPaidByUser: json['amountPaidByUser'].toDouble(),
      expectedDeliveryDate: json['expectedDeliveryDate'],
      isShipped:json['isShipped'],
      isDelivered: json['isDelivered'],
      isPaid:json['isPaid'],
      paymentMode: json['paymentMode'],
      netOrderAmount: json['netOrderAmount'].toDouble(),
      totalOrderAmount: json['totalOrderAmount'].toDouble(),
      totalPayableAmount: json['totalPayableAmount'].toDouble(),
      deliveryCharge: json['deliveryCharge'].toDouble(),
      shippingAddress: PlaceOrderedShippingAddress.fromJson(json['shippingAddress']),
      orderItems:orderList.map((e) => PlacedOrderItems.fromJson(e)).toList(),
    );
  }
}

class PlacedOrderItems {
  final int orderId;
  final int basketId;
  final int productId;
  final int categoryId;
  final int stockId;
  final int variantId;
  final int unitId;
  final int quantityOrdered;
  final String productName;
  final String categoryName;
  final String variantName;
  final String unitName;
  final double priceAtTheTimeOfOrdering;
  final double discountedPriceAtTheTimeOfOrdering;
  final double totalPriceAtTheTimeOfOrdering;
  final double totalDiscountedPriceAtTheTimeOfOrdering;
  final double discountPercentageAtTheTimeOfOrdering;
  final String imageUrl;
  final String description;
  final String brand;
  final double quantity;
  final String unitSymbol;
  final List<PlaceOrderedProductVariant> variants;
  //final dynamic variants;

  PlacedOrderItems({this.orderId,this.basketId,this.productId, this.categoryId,this.stockId,
    this.variantId,this.unitId,this.quantityOrdered,this.productName,this.categoryName,this.variantName,
    this.unitName,this.priceAtTheTimeOfOrdering,this.discountedPriceAtTheTimeOfOrdering,this.totalPriceAtTheTimeOfOrdering,
    this.totalDiscountedPriceAtTheTimeOfOrdering,this.discountPercentageAtTheTimeOfOrdering,this.description,this.brand,this.imageUrl,
    this.quantity,this.unitSymbol,this.variants});

  factory PlacedOrderItems.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List;
    //var shippingAddressList = json['shippingAddress'] as List;
    return PlacedOrderItems(
      orderId: json['orderId'],
      basketId: json['basketId'],
      productId: json['productId'],
      categoryId: json['categoryId'],
      stockId: json['stockId'],
      variantId: json['variantId'],
      unitId: json['unitId'],
      quantityOrdered: json['quantityOrdered'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      variantName: json['variantName'],
      unitName: json['unitName'],
      priceAtTheTimeOfOrdering: json['priceAtTheTimeOfOrdering'].toDouble(),
      discountedPriceAtTheTimeOfOrdering: json['discountedPriceAtTheTimeOfOrdering'].toDouble(),
      totalPriceAtTheTimeOfOrdering: json['totalPriceAtTheTimeOfOrdering'].toDouble(),
      totalDiscountedPriceAtTheTimeOfOrdering: json['totalDiscountedPriceAtTheTimeOfOrdering'].toDouble(),
      discountPercentageAtTheTimeOfOrdering: json['discountPercentageAtTheTimeOfOrdering'].toDouble(),
      description: json['description'],
      brand: json['brand'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'].toDouble(),
      unitSymbol: json['unitSymbol'],
      variants:variantList.map((e) => PlaceOrderedProductVariant.fromJson(e)).toList(),
    );
  }
}

class PlaceOrderedProductVariant {
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
  final String unitSymbol;
  final int stocks;
  final bool addedToCart;
  final int cartId;
  int quantityToBeBought;

  PlaceOrderedProductVariant({this.stockId, this.variantId,this.cost,
    this.price,this.discountedPrice,this.discountPercentage,this.imageUrl,
    this.variantName,this.quantity,this.unitId,this.unitName,this.unitSymbol,this.stocks,this.addedToCart,this.cartId,this.quantityToBeBought});

  factory PlaceOrderedProductVariant.fromJson(Map<String, dynamic> json) {
    return PlaceOrderedProductVariant(
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
      unitSymbol: json['unitSymbol'],
      stocks: json['stocks'],
      addedToCart: json['addedToCart'],
      cartId:json['cartId'],
      quantityToBeBought:  json['quantityToBeBought'],
    );
  }
}

class PlaceOrderedShippingAddress {
  final String id;
  final String type;
  final String name;
  final String mobileNumber;
  final String alternateMobileNumber;
  final String street;
  final String landmark;
  final String district;
  final String city;
  final String state;
  final String country;
  final String pincode;

  PlaceOrderedShippingAddress({this.id,this.type,this.name,this.mobileNumber,this.alternateMobileNumber,this.state,this.street,
    this.city,this.country,this.district,this.landmark,this.pincode});

  factory PlaceOrderedShippingAddress.fromJson(Map<String, dynamic> json) {
    return PlaceOrderedShippingAddress(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      alternateMobileNumber: json['alternateMobileNumber'],
      state: json['state'],
      street: json['street'],
      city: json['city'],
      country: json['country'],
      district: json['district'],
      landmark: json['landmark'],
      pincode: json['pincode'],
    );
  }
}


