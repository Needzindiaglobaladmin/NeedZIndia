class TokenData {
  final String token;

  TokenData({this.token});

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      token: json['token'],
    );
  }
}
class TokenResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final TokenData data;

  TokenResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: TokenData.fromJson(json['data']),
    );
  }
}