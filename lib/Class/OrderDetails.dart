class OrderDetailsResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  //final dynamic data;
  final List<OrderDetailsData> data;

  OrderDetailsResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    var productList = json['data'] as List;
    //print('ProductList<>'+ ProductList.toString());
    //for(int i=0;i<ProductList.length;i++){
    // print('Productitem='+ ProductList[i].toString());
    // }
    return OrderDetailsResponse(
        status: json['status'],
        success: json['success'],
        message: json['message'],
        userFriendlyMessage: json['userFriendlyMessage'],
        data: productList.map((e) => OrderDetailsData.fromJson(e)).toList()
    );
  }
}

class OrderDetailsData {
  final int orderId;
  final String baitOrderId;
  final String couponApplied;
  final double discountOnCoupon;
  final double amountPaidByUser;
  final String expectedDeliveryDate;
  final String actualDeliveryDate;
  final bool isShipped;
  final bool isDelivered;
  final String paymentMode;
  final bool isPaid;
  bool isCancelled;
  final double netOrderAmount;
  final double totalOrderAmount;
  final double totalPayableAmount;
  final double deliveryCharge;
  final OrderedShippingAddress shippingAddress;
  final List<OrderItemsData> orderItems;

  OrderDetailsData({this.orderId,this.couponApplied,this.discountOnCoupon,this.amountPaidByUser,this.expectedDeliveryDate,this.actualDeliveryDate,
    this.isShipped,this.isDelivered,this.isPaid,this.paymentMode,this.netOrderAmount,this.totalOrderAmount,this.totalPayableAmount,
    this.deliveryCharge,this.shippingAddress,this.orderItems,this.baitOrderId,this.isCancelled});

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    var orderList = json['orderItems'] as List;
    //var shippingAddressList = json['shippingAddress'] as List;
    return OrderDetailsData(
      orderId: json['orderId'],
      baitOrderId: json['baitOrderId'],
      couponApplied: json['couponApplied'],
      discountOnCoupon: json['discountOnCoupon'].toDouble(),
      amountPaidByUser: json['amountPaidByUser'].toDouble(),
      expectedDeliveryDate: json['expectedDeliveryDate'],
      actualDeliveryDate: json['actualDeliveryDate'],
      isCancelled: json['isCancelled'],
      isShipped:json['isShipped'],
      isDelivered: json['isDelivered'],
      isPaid:json['isPaid'],
      paymentMode: json['paymentMode'],
      netOrderAmount: json['netOrderAmount'].toDouble(),
      totalOrderAmount: json['totalOrderAmount'].toDouble(),
      totalPayableAmount: json['totalPayableAmount'].toDouble(),
      deliveryCharge: json['deliveryCharge'].toDouble(),
      shippingAddress: OrderedShippingAddress.fromJson(json['shippingAddress']),
      orderItems: orderList.map((e) => OrderItemsData.fromJson(e)).toList(),
    );
  }
}

class OrderItemsData {
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
  final List<OrderedProductVariant> variants;
  //final dynamic variants;

  OrderItemsData({this.orderId,this.basketId,this.productId, this.categoryId,this.stockId,
    this.variantId,this.unitId,this.quantityOrdered,this.productName,this.categoryName,this.variantName,
    this.unitName,this.priceAtTheTimeOfOrdering,this.discountedPriceAtTheTimeOfOrdering,this.totalPriceAtTheTimeOfOrdering,
    this.totalDiscountedPriceAtTheTimeOfOrdering,this.discountPercentageAtTheTimeOfOrdering,this.description,this.brand,this.imageUrl,
    this.quantity,this.unitSymbol,this.variants});

  factory OrderItemsData.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List;
    //var shippingAddressList = json['shippingAddress'] as List;
    return OrderItemsData(
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
      variants:variantList.map((e) => OrderedProductVariant.fromJson(e)).toList(),
    );
  }
}

class OrderedProductVariant {
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

  OrderedProductVariant({this.stockId, this.variantId,this.cost,
    this.price,this.discountedPrice,this.discountPercentage,this.imageUrl,
    this.variantName,this.quantity,this.unitId,this.unitName,this.unitSymbol,this.stocks,this.addedToCart,this.cartId,this.quantityToBeBought});

  factory OrderedProductVariant.fromJson(Map<String, dynamic> json) {
    return OrderedProductVariant(
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

class OrderedShippingAddress {
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

  OrderedShippingAddress({this.id,this.type,this.name,this.mobileNumber,this.alternateMobileNumber,this.state,this.street,
                          this.city,this.country,this.district,this.landmark,this.pincode});

  factory OrderedShippingAddress.fromJson(Map<String, dynamic> json) {
    return OrderedShippingAddress(
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

