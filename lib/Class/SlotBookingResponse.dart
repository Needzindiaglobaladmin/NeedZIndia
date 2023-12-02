
class SlotBookedShippingAddress {
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

  SlotBookedShippingAddress({this.id,this.type,this.name,this.mobileNumber,this.alternateMobileNumber,this.state,this.street,
    this.city,this.country,this.district,this.landmark,this.pincode});

  factory SlotBookedShippingAddress.fromJson(Map<String, dynamic> json) {
    return SlotBookedShippingAddress(
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



class SlotBookingData {
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
  final SlotBookedShippingAddress shippingAddress;

  SlotBookingData({this.serviceBookingId,this.userId,this.serviceId,this.serviceName,this.serviceDispatchingDate, this.pricePerPerson,this.paymentMode,
    this.isCancelled,this.timeSlotId,this.timeSlotName,this.startTimeInSecond,this.endTimeInSeconds,this.shippingAddress,this.totalBookingAmount,this.numOfPersons});

  factory SlotBookingData.fromJson(Map<String, dynamic> json) {
    return SlotBookingData(
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
      shippingAddress: SlotBookedShippingAddress.fromJson(json['shippingAddress']),
    );
  }
}

class SlotBookingResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final SlotBookingData data;

  SlotBookingResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory SlotBookingResponse.fromJson(Map<String, dynamic> json) {
    return SlotBookingResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: SlotBookingData.fromJson(json['data']),
    );
  }
}
