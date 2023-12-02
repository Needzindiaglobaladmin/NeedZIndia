class AddressData {
  final String type;
  final String name;
  final String alternateMobileNumber;
  final String street;
  final String landmark;
  final String district;
  final String city;
  final String pincode;
  final String state;
  final String country;
  final String id;
  final String mobileNumber;


  AddressData({this.type,this.name,this.alternateMobileNumber,this.street,this.landmark,this.district,this.city,this.pincode, this.state,this.country,this.id,this.mobileNumber});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      type: json['type'],
      name: json['name'],
      alternateMobileNumber: json['alternateMobileNumber'],
      street: json['street'],
      landmark: json['landmark'],
      district: json['district'],
      city: json['city'],
      pincode: json['pincode'],
      state: json['state'],
      country: json['country'],
      id: json['id'],
      mobileNumber: json['mobileNumber'],
    );
  }
}
class AddressResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final AddressData data;

  AddressResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: AddressData.fromJson(json['data']),
    );
  }
}