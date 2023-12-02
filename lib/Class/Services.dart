
class ServicesResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final ServicesData data;


  ServicesResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory ServicesResponse.fromJson(Map<String, dynamic> json) {
    return ServicesResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
        data: ServicesData.fromJson(json['data']),
    );
  }
}

class ServicesData {
  final List<AllService> services;
  final List<TimeSlotsData> timeSlots;
  final List<BookingSlotsData> bookingSlots;


  ServicesData({this.services,this.timeSlots, this.bookingSlots});

  factory ServicesData.fromJson(Map<String, dynamic> json) {
    var services = json['services'] as List;
    var timeSlot = json['timeSlots'] as List;
    var bookingSlot = json['bookingSlots'] as List;

    return ServicesData(
        services: services.map((e) => AllService.fromJson(e)).toList(),
        timeSlots: timeSlot.map((e) => TimeSlotsData.fromJson(e)).toList(),
        bookingSlots: bookingSlot.map((e) => BookingSlotsData.fromJson(e)).toList()
    );
  }
}

class AllService {
  final int id;
  final String name;
  final bool isAvailable;
  final int pricePerPerson;

  AllService({this.id,this.name, this.isAvailable,this.pricePerPerson});

  factory AllService.fromJson(Map<String, dynamic> json) {
    return AllService(
    id: json['id'],
    name: json['name'],
      isAvailable: json['isAvailable'],
      pricePerPerson: json['pricePerPerson'],
    );
  }
}
class TimeSlotsData {
  final int id;
  final String name;
  final String startTimeInSeconds;
  final String endTimeInSeconds;
  final bool isActive;

  TimeSlotsData({this.id,this.name,this.startTimeInSeconds,this.endTimeInSeconds,this.isActive});

  factory TimeSlotsData.fromJson(Map<String, dynamic> json) {
    return TimeSlotsData(
      id: json['id'],
      name: json['name'],
      startTimeInSeconds: json['startTimeInSeconds'].toString(),
      endTimeInSeconds: json['endTimeInSeconds'].toString(),
      isActive: json['isActive'],
    );
  }
}
class BookingSlotsData {
  final String date;
  final String bookedSlots1;
  final String bookedSlots2;
  final bool isSlot1Available;
  final bool isSlot2Available;


  BookingSlotsData({this.date,this.bookedSlots1,this.bookedSlots2,this.isSlot1Available,this.isSlot2Available});

  factory BookingSlotsData.fromJson(Map<String, dynamic> json) {
    return BookingSlotsData(
      date: json['date'],
      bookedSlots1: json['bookedSlots1'],
      bookedSlots2: json['bookedSlots2'],
      isSlot1Available: json['isSlot1Available'],
      isSlot2Available: json['isSlot2Available'],
    );
  }
}

