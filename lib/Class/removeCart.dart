
class RemoveCartResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final String data;

  RemoveCartResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory RemoveCartResponse.fromJson(Map<String, dynamic> json) {
    return RemoveCartResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}
