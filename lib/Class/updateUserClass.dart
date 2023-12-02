class UpdateUser {
  final String firstName;
  final String lastName;
  final String countryCode;
  final String mobile;
  final String emailId;
  final String gender;
  final String imageUrl;

  UpdateUser({this.firstName,this.lastName,this.countryCode,this.mobile,this.emailId, this.gender,this.imageUrl});

  factory UpdateUser.fromJson(Map<String, dynamic> json) {
    return UpdateUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      countryCode: json['countryCode'],
      mobile: json['mobile'],
      emailId: json['emailId'],
      gender: json['gender'],
      imageUrl: json['imageUrl'],
    );
  }
}
class UpdateUserResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final UpdateUser data;

  UpdateUserResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: UpdateUser.fromJson(json['data']),
    );
  }
}