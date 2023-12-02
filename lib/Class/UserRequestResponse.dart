class UserRequestResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final String data;

  UserRequestResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory UserRequestResponse.fromJson(Map<String, dynamic> json) {
    return UserRequestResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}