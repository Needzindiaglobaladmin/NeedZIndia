
class CheckPinCodeResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final bool data;

  CheckPinCodeResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory CheckPinCodeResponse.fromJson(Map<String, dynamic> json) {
    return CheckPinCodeResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}
