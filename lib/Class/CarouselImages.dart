
class CarouselImagesResponse  {
  final int status;
  final bool success;
  final String message;
  final String userFriendlyMessage;
  final CarouselImageData data;

  CarouselImagesResponse({this.status,this.success, this.message,this.userFriendlyMessage,this.data});

  factory CarouselImagesResponse.fromJson(Map<String, dynamic> json) {
    return CarouselImagesResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      userFriendlyMessage: json['userFriendlyMessage'],
      data: CarouselImageData.fromJson(json['data']),
    );
  }
}

class CarouselImageData {
  final List<CarouselMasterData> carouselMasterData;
  final List<CarouselData> carouselData;

  CarouselImageData({this.carouselMasterData, this.carouselData});

  factory CarouselImageData.fromJson(Map<String, dynamic> json) {
    var carouselMasterData = json['carouselMasterData'] as List;
    var carouselData = json['carouselData'] as List;
    return CarouselImageData(
      carouselMasterData: carouselMasterData.map((e) => CarouselMasterData.fromJson(e)).toList(),
      carouselData: carouselData.map((e) => CarouselData.fromJson(e)).toList(),
    );
  }
}

class CarouselMasterData {
  final int carouselId;
  final String carouselName;

  CarouselMasterData({this.carouselId, this.carouselName});

  factory CarouselMasterData.fromJson(Map<String, dynamic> json) {
    return CarouselMasterData(
      carouselId: json['carouselId'],
      carouselName: json['carouselName'],
    );
  }
}


class CarouselData {
  final int carouselId;
  final int carouselDataId;
  final String carouselName;
  final String imageUrl;
  final String redirectAppPageName;

  CarouselData({this.carouselId, this.carouselDataId,this.carouselName,this.imageUrl,
    this.redirectAppPageName});

  factory CarouselData.fromJson(Map<String, dynamic> json) {
    return CarouselData(
      carouselId: json['carouselId'],
      carouselDataId: json['carouselDataId'],
      carouselName: json['carouselName'],
      imageUrl: json['imageUrl'],
      redirectAppPageName: json['redirectAppPageName'],
    );
  }
}

