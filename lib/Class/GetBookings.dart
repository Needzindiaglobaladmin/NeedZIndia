class BookedShippingAddress {
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

  BookedShippingAddress({this.id,this.type,this.name,this.mobileNumber,this.alternateMobileNumber,this.state,this.street,
    this.city,this.country,this.district,this.landmark,this.pincode});

  factory BookedShippingAddress.fromJson(Map<String, dynamic> json) {
    return BookedShippingAddress(
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



class GetBookingsData {
  final int serviceBookingId;
  final int userId;
  final int serviceId;
  final String serviceName;
  final String serviceDispatchingDate;
  final int pricePerPerson;
  final String paymentMode;
  final bool isCancelled;
  final int timeSlotId;
  final String timeSlotName;
  final int startTimeInSecond;
  final int endTimeInSeconds;
  final int totalBookingAmount;
  final int numOfPersons;
  final BookedShippingAddress shippingAddress;
  bool cancel = false;

  GetBookingsData({this.serviceBookingId,this.userId,this.serviceId,this.serviceName,this.serviceDispatchingDate, this.pricePerPerson,this.paymentMode,
    this.isCancelled,this.timeSlotId,this.timeSlotName,this.startTimeInSecond,this.endTimeInSeconds,this.shippingAddress,this.cancel,this.totalBookingAmount,this.numOfPersons});

  factory GetBookingsData.fromJson(Map<String, dynamic> json) {
    return GetBookingsData(
      serviceBookingId: json['serviceBookingId'],
      userId: json['userId'],
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      serviceDispatchingDate: json['serviceDispatchingDate'],
      pricePerPerson: json['pricePerPerson'],
      paymentMode: json['paymentMode'],
      isCancelled: json['isCancelled'],
      timeSlotId: json['timeSlotId'],
      timeSlotName: json['timeSlotName'],
      startTimeInSecond: json['startTimeInSecond'],
      endTimeInSeconds: json['endTimeInSeconds'],
      totalBookingAmount:json['totalBookingAmount'],
      numOfPersons: json["numOfPersons"],
      shippingAddress: BookedShippingAddress.fromJson(json['shippingAddress']),
    );
  }
}
class GetBookingsResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final List<GetBookingsData> data;

  GetBookingsResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory GetBookingsResponse.fromJson(Map<String, dynamic> json) {
    var bookings = json['data'] as List;
    return GetBookingsResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: bookings.map((e) => GetBookingsData.fromJson(e)).toList(),
    );
  }
}