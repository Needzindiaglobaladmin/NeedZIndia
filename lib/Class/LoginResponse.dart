class LoginData {
  final String deviceKey;
  final String mobile;

  LoginData({this.deviceKey, this.mobile});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      deviceKey: json['deviceKey'],
      mobile: json['mobile'],
    );
  }
}
class LoginResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final LoginData data;

  LoginResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: LoginData.fromJson(json['data']),
    );
  }
}
