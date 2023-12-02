class DelAddressResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final String data;

  DelAddressResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory DelAddressResponse.fromJson(Map<String, dynamic> json) {
    return DelAddressResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: json['data'],
    );
  }
}