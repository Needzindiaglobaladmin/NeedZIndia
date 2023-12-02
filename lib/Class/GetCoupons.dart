class GetCouponsData {
  final int couponId;
  final String couponCode;
  final double minOrderAmountThresold;
  final int discountPercentage;
  final double discountAmount;
  final int usagePerUser;
  final bool status;
  final double redemptionStartTime;
  final double redemptionEndTime;
  final String formattedRedemptionStartTime;
  final String formattedRedemptionEndTime;
  final String description;

  GetCouponsData({this.couponId,this.couponCode,this.minOrderAmountThresold,this.discountPercentage,this.discountAmount, this.usagePerUser,this.status,
  this.redemptionStartTime,this.redemptionEndTime,this.formattedRedemptionStartTime,this.formattedRedemptionEndTime,this.description});

  factory GetCouponsData.fromJson(Map<String, dynamic> json) {
    return GetCouponsData(
      couponId: json['couponId'],
      couponCode: json['couponCode'],
      minOrderAmountThresold: json['minOrderAmountThresold'].toDouble(),
      discountPercentage: json['discountPercentage'],
      discountAmount: json['discountAmount'].toDouble(),
      usagePerUser: json['usagePerUser'],
      status: json['status'],
      redemptionStartTime: json['redemptionStartTime'].toDouble(),
      redemptionEndTime: json['redemptionEndTime'].toDouble(),
      formattedRedemptionStartTime: json['formattedRedemptionStartTime'],
      formattedRedemptionEndTime: json['formattedRedemptionEndTime'],
      description: json['description'],
    );
  }
}
class GetCouponsResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final List<GetCouponsData> data;

  GetCouponsResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory GetCouponsResponse.fromJson(Map<String, dynamic> json) {
    var coupons = json['data'] as List;
    return GetCouponsResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: coupons.map((e) => GetCouponsData.fromJson(e)).toList(),
    );
  }
}