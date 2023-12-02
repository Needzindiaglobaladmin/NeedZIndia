
class GetAddressResponse {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final List<GetAddressData> data;

  GetAddressResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory GetAddressResponse.fromJson(Map<String, dynamic> json) {
    var address = json['data'] as List;
    return GetAddressResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data:  address.map((e) => GetAddressData.fromJson(e)).toList(),
    );
  }
}

class GetAddressData {
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


  GetAddressData({this.id, this.type,this.name,this.mobileNumber,
    this.alternateMobileNumber,this.street,this.landmark,this.district,this.city,
    this.state,this.country,this.pincode});

  factory GetAddressData.fromJson(Map<String, dynamic> json) {
    return GetAddressData(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      alternateMobileNumber: json['alternateMobileNumber'],
      street: json['street'],
      landmark: json['landmark'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pincode: json['pincode'],
    );
  }
}