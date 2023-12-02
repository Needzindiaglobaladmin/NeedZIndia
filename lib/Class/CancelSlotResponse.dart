
class CancelSlotResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final String data;

  CancelSlotResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory CancelSlotResponse.fromJson(Map<String, dynamic> json) {
    return CancelSlotResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}
